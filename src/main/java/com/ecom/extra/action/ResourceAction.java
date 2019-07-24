package com.ecom.extra.action;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecom.core.model.IUser;
import com.ecom.core.model.TreeModel;
import com.ecom.core.util.ConverUtil;
import com.ecom.extra.util.Helper;
import com.ecom.permission.entity.SysResource;

@Controller
@RequestMapping(value = "/resource")
public class ResourceAction extends BaseAction {
    private static Log log = LogFactory.getLog(ResourceAction.class);

    @RequestMapping(value = "/get")
    @ResponseBody
    public Object getCurrentUserResource() {
        try {
            IUser currentUser = Helper.getCurrentUserObject();
            List ls = new ArrayList();
            if ("super".equals(currentUser.getLoginName())) {
                String hql = "from SysResource where status=0";
                ls = baseService.find(hql);
            } else {
                String sql = "select * from sys_resource a, (select distinct resourceId from rel_role_resource where 1=1 and floor(MOD(" + currentUser.getRole()
                                        + " / power(2,roleCode), 2)) = 1)b where a.code=b.resourceId and a.status=0 order by code";
                ls = baseService.findBySql2Map(sql);
                for (int i = 0; i < ls.size(); i++) {
                    Map map = (Map) ls.get(i);
                    SysResource po = new SysResource();
                    po.setCode((String) map.get("code"));
                    po.setId(Long.parseLong(map.get("id").toString()));
                    po.setName((String) map.get("name"));
                    po.setUrl((String) map.get("url"));
                    if (map.get("type") != null) {
                        po.setType(Integer.parseInt(map.get("type").toString()));
                    }
                    ls.set(i, po);
                }
            }
            List menuList = new ArrayList();
            List pageList = new ArrayList();
            Map filterMap = new TreeMap();
            for (int i = 0; i < ls.size(); i++) {
                SysResource po = (SysResource) ls.get(i);
                TreeModel treeMode = new TreeModel();
                if (StringUtils.isBlank(po.getCode())) {
                    continue;
                }
                treeMode.setType(po.getType());
                treeMode.setCode(po.getCode());
                treeMode.setId(po.getCode());
                treeMode.setText(po.getUrl());
                treeMode.setName(po.getName());
                if (po.getCode().startsWith("9")) {
                    pageList.add(treeMode);
                } else {
                    menuList.add(treeMode);
                }
                //
                filterMap.put(po.getCode(), treeMode);
            }

            menuList = Helper.tree.buildTreeModelList(menuList);
            //
            Map map = new HashMap();
            map.put("menu", menuList);
            map.put("page", pageList);
            return map;
        } catch (Exception e) {
            return throwException("getCurrentUserResource error", e);
        }
    }

    /**
     * 控制菜单数据显示
     * 
     * @return
     */
    @RequestMapping(value = "/resource2")
    @ResponseBody
    public Object getCurrentUserResource2() {
        try {
            IUser currentUser = Helper.getCurrentUserObject(getRequest());
            InputStream is = null;
            if ("super".equals(currentUser.getLoginName())) {
                is = Helper.getResouceInputStream("/data/menu/menu.json");
            } else {
                is = Helper.getResouceInputStream("/data/menu/menu-user.json");
            }
            List reList = new ArrayList();
            if (is != null) {
                String json = ConverUtil.converInputStream2String(is);
                List ls = Helper.json.JSON_String2List(json, SysResource.class);
                for (int i = 0; i < ls.size(); i++) {
                    SysResource po = (SysResource) ls.get(i);
                    TreeModel treeMode = new TreeModel();
                    if (StringUtils.isBlank(po.getCode())) {
                        continue;
                    }
                    treeMode.setCode(po.getCode());
                    treeMode.setId(new Long(i) + "");
                    treeMode.setText(po.getUrl());
                    treeMode.setName(po.getName());
                    reList.add(treeMode);
                }
            }
            reList = Helper.tree.buildTreeModelList(reList);
            Map map = new HashMap();
            map.put("menu", reList);
            return map;
        } catch (Exception e) {
            return throwException("getCurrentUserResource2 error", e);
        }
    }
}
