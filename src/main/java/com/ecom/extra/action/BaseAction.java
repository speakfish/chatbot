package com.ecom.extra.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.ecom.core.action.CoreAction;
import com.ecom.core.model.RequestResultModel;
import com.ecom.core.util.CoreHelper;

public class BaseAction extends CoreAction {
    protected void throwException(String msg, Exception e, HttpServletResponse rs) {
        RequestResultModel model = null;
        if (e instanceof org.springframework.web.multipart.MaxUploadSizeExceededException) {
            model = new RequestResultModel("上传的图片大小不能超过500k.");
        }
        try {
            e.printStackTrace();
            if (model == null) {
                model = new RequestResultModel(msg);
            }
            String s = CoreHelper.json.JSON_Object2String(model);
            write(s, rs);
        } catch (Exception e2) {
            e2.printStackTrace();
        }
    }

    protected void throwException(String msg, HttpServletResponse rs) {
        RequestResultModel model = null;
        try {
            model = new RequestResultModel(msg);
            String s = CoreHelper.json.JSON_Object2String(model);
            write(s, rs);
        } catch (Exception e2) {
            e2.printStackTrace();
        }
    }

    protected RequestResultModel throwException(String msg, Exception e) {
        // SysUser user = Helper.getCurrentUser(getRequest());
        e.printStackTrace();
        if (e instanceof org.springframework.web.multipart.MaxUploadSizeExceededException) {
            return new RequestResultModel("上传的图片大小不能超过500k.");
        }
        return new RequestResultModel(msg);
    }
}
