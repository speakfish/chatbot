package com.ecom.extra.component;

import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ecom.dict.model.DictModel;
import com.ecom.dict.service.DictService;
import com.ecom.extra.service.BaseService;

@Component
public class CacheHelper {
    @Resource
    public BaseService                                   baseService;

    @Resource
    public DictService                                   dictService;

    public static ConcurrentMap<String, List<DictModel>> dictCacheMap = new ConcurrentHashMap<String, List<DictModel>>();

    public void refreshDictCache() {
        dictService.refreshDictCache(dictCacheMap);
    }

    public static String getDictView(String type, String code) {
        List ls = (List) dictCacheMap.get(type);
        if (ls != null) {
            for (int i = 0; i < ls.size(); i++) {
                DictModel po = (DictModel) ls.get(i);
                if (po.getValue().equals(code)) {
                    return po.getText();
                }
            }
        }
        return "";
    }
}
