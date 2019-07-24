package com.ecom.dict.service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentMap;

import org.springframework.stereotype.Service;

import com.ecom.core.model.RequestResultModel;
import com.ecom.core.util.CoreHelper;
import com.ecom.dict.entity.DictItemEntity;
import com.ecom.dict.entity.DictTypeEntity;
import com.ecom.dict.model.DictModel;
import com.ecom.dict.model.json.Item;
import com.ecom.dict.model.json.Root;
import com.ecom.dict.model.json.Row;
import com.ecom.extra.Const;
import com.ecom.extra.service.BaseService;
import com.ecom.extra.util.Helper;

@Service
public class DictService extends BaseService {

    public void doClearDictData() {
        String hql = "delete from DictItemEntity";
        runHql(hql);
        hql = "delete from DictTypeEntity";
        runHql(hql);
    }

    public void doImportDictData() throws Exception {
        String hql = "select count(*) from DictTypeEntity where status=" + Const.STATUS_ACTIVE;
        List ls = find(hql);
        if ("0".equals(ls.get(0).toString())) {
            InputStream is = Helper.getResouceInputStream("/data/dict.xml");
            Root root = (Root) CoreHelper.xml.unmarshal("com.ecom.dict.model.json", is);
            List rowList = root.getRow();
            for (int i = 0; i < rowList.size(); i++) {
                Row r = (Row) rowList.get(i);
                //
                DictTypeEntity po = new DictTypeEntity();
                po.setCode(r.getCode());
                po.setName(r.getName());
                po.setStatus(Const.STATUS_ACTIVE);
                doSaveDictType(po);
                //
                List itemList = r.getItem();
                if (itemList != null) {
                    for (int j = 0; j < itemList.size(); j++) {
                        Item item = (Item) itemList.get(j);
                        //
                        DictItemEntity di = new DictItemEntity();
                        di.setCode(r.getCode());
                        di.setValue(item.getItemValue());
                        di.setName(item.getItemName());
                        di.setStatus(Const.STATUS_ACTIVE);
                        doSaveDictItem(di);
                    }
                }
            }
        }
    }

    public void refreshDictCache(ConcurrentMap<String, List<DictModel>> dictCacheMap) {
        dictCacheMap.clear();
        String hql = "select new com.ecom.dict.model.DictModel(code,name) from DictTypeEntity";
        List ls = find(hql);
        dictCacheMap.put("_DictType", ls);
        //
        hql = "from DictItemEntity";
        ls = find(hql);
        for (int i = 0; i < ls.size(); i++) {
            DictItemEntity po = (DictItemEntity) ls.get(i);
            String key = po.getCode();
            List list = (List) dictCacheMap.get(key);
            if (list == null) {
                list = new ArrayList();
            }
            DictModel model = new DictModel();
            model.setValue(po.getValue());
            model.setText(po.getName());
            list.add(model);
            dictCacheMap.put(key, list);
        }
    }

    public String getDictView(ConcurrentMap<String, List<DictModel>> dictCacheMap, String dictType, String dictCode) {
        List ls = (List) dictCacheMap.get(dictType);
        if (ls != null) {
            for (int i = 0; i < ls.size(); i++) {
                DictModel po = (DictModel) ls.get(i);
                if (po.getValue().equals(dictCode)) {
                    return po.getText();
                }
            }
        }
        return "";
    }

    public RequestResultModel doSaveDictType(DictTypeEntity po) {
        RequestResultModel result = doValidDictType(po);
        if (result.isSuccess()) {
            save(po);
        }
        return result;
    }

    public RequestResultModel doSaveDictItem(DictItemEntity po) {
        RequestResultModel result = doValidDictItem(po);
        if (result.isSuccess()) {
            save(po);
        }
        return result;
    }

    private RequestResultModel doValidDictType(DictTypeEntity po) {
        String hql = "select count(*) from DictTypeEntity where code=? or name=?";
        List ls = find(hql, po.getCode(), po.getName());
        if ("0".equals(ls.get(0).toString())) {
            return new RequestResultModel(true, null);
        }
        return new RequestResultModel(false, "编码或名称已存在");
    }

    private RequestResultModel doValidDictItem(DictItemEntity po) {
        String hql = "select count(*) from DictItemEntity where status=0 and code=? and (value=? or name=?)";
        List ls = find(hql, po.getCode(), po.getValue(), po.getName());
        if ("0".equals(ls.get(0).toString())) {
            return new RequestResultModel(true, null);
        }
        return new RequestResultModel(false, "值或名称已存在");
    }
}