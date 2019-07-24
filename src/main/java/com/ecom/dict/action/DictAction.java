package com.ecom.dict.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecom.extra.action.BaseAction;
import com.ecom.extra.component.CacheHelper;

@Controller
@RequestMapping(value = "/dict")
public class DictAction extends BaseAction {
    @Resource
    private CacheHelper cacheHelper;

    @RequestMapping(value = "/fill/list.compress")
    @ResponseBody
    public Object listFill() {
        try {
            String dictCodes = getP("dictCodes");
            Map map = new HashMap();
            if (StringUtils.isNotBlank(dictCodes)) {
                String[] keys = dictCodes.split(",");
                for (int i = 0; i < keys.length; i++) {
                    List ls = new ArrayList();
                    if ("".equals(keys[i])) {

                    } else {
                        ls = (List) CacheHelper.dictCacheMap.get(keys[i]);
                    }
                    map.put(keys[i], ls);
                }
            }
            return map;
        } catch (Exception e) {
            return throwException("listFill error", e);
        }
    }
}
