package com.ecom.extra.web;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;

import com.ecom.core.util.SystemInitUtils;
import com.ecom.dict.service.DictService;
import com.ecom.extra.Const;
import com.ecom.extra.component.CacheHelper;
import com.ecom.extra.service.BaseService;
import com.ecom.extra.util.Helper;
import com.ecom.permission.entity.SysResource;

public class StartUpInitBean extends SystemInitUtils {
    private static Log log = LogFactory.getLog(StartUpInitBean.class);

    @Resource
    public BaseService baseService;

    @Resource
    public DictService dictService;

    public void setApplicationContext(ApplicationContext arg0) throws BeansException {
        Const.isCheckSessionRequest = false;
        //
        doSystemInit();
    }

    private void doSystemInit() {
        try {
            String hql = "delete from SysResource";
            baseService.runHql(hql);

            hql = "select count(*) from SysResource";
            List ls = baseService.find(hql);
            if (ls.size() > 0) {
                Long num = (Long) ls.get(0);
                if (num == 0) {
                    File f = Helper.getResouceFile("/data/menu.json");
                    if (f != null && f.exists()) {
                        String json = FileUtils.readFileToString(f, "UTF-8");
                        ls = Helper.json.JSON_String2List(json, SysResource.class);
                        for (int i = 0; i < ls.size(); i++) {
                            SysResource po = (SysResource) ls.get(i);
                            // po.setStatus(0);
                            baseService.save(po);
                        }
                    }
                }
            }
        } catch (Exception e) {
            log.error("StartUpInitBean doSystemInit", e);
        }
        try {
            dictService.doClearDictData();
            dictService.doImportDictData();
            dictService.refreshDictCache(CacheHelper.dictCacheMap);
            log.debug(CacheHelper.dictCacheMap);
        } catch (Exception e) {
            log.error("StartUpInitBean dictService", e);
        }
    }
}
