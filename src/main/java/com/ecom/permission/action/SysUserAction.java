package com.ecom.permission.action;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecom.core.model.IUser;
import com.ecom.core.model.RequestResultModel;
import com.ecom.extra.action.BaseAction;
import com.ecom.extra.util.Helper;
import com.ecom.permission.entity.SysUser;

@Controller
@RequestMapping(value = "/admin/user")
public class SysUserAction extends BaseAction {

    @RequestMapping(value = "/change/password")
    @ResponseBody
    public Object doChangePassword(HttpSession session) {
        try {
            String oldpassword = getP("oldpassword");
            String newpassword = getP("newpassword");
            String retypedpassword = getP("retypedpassword");
            IUser currentUser = Helper.getCurrentUserObject(getRequest());
            String userName = currentUser.getLoginName();
            if ("super".equals(userName)) {
                return new RequestResultModel(false, "管理员密码不能修改");
            }
            if (StringUtils.isBlank(newpassword)) {
                return new RequestResultModel(false, "新密码不能为空");
            }
            if (!newpassword.equals(retypedpassword)) {
                return new RequestResultModel(false, "输入2次密码不一致");
            }
//            byte[] bs = idmService.doChangePassword(user.getLoginName(), oldpassword, newpassword);
//            Response res = (Response) Helper.xml.unmarshal("com.ecom.rpc.model.response", bs);
//            if ("true".equals(res.getSuccess())) {
//                user.setPassword(newpassword);
//                session.setAttribute(Const.SESSION_KEY_USER, user);
//                //
//                return new RequestResultModel(true, "密码修改成功");
//            } else {
//                return new RequestResultModel(false, res.getReason());
//            }
        } catch (Exception e) {
            return throwException("doChangePassword error", e);
        }
        return session;
    }

}
