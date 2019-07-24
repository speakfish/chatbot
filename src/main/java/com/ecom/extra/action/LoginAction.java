package com.ecom.extra.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ecom.core.AppException;
import com.ecom.core.component.CaptchaService;
import com.ecom.core.model.RequestResultModel;
import com.ecom.core.util.MD5;
import com.ecom.extra.Const;
import com.ecom.extra.util.Helper;
import com.ecom.permission.entity.SysUser;
import com.google.code.kaptcha.Constants;

@Controller
public class LoginAction extends BaseAction {
    @Resource
    private CaptchaService                    captchaService;

    private String                            HOME_PAGE = "/page/home/view";

    private ConcurrentMap<String, List<Long>> visitMap  = new ConcurrentHashMap();

    private ConcurrentMap<String, Long>       loginMap  = new ConcurrentHashMap();

    @RequestMapping(value = "/public/login-page")
    public String loginPage() {
        // FIXME
        String host = getRequest().getHeader("host");
        String visitKey = Helper.net.getIp(Helper.getRequest());
        //
        boolean flag = isNeedCaptcha(host, visitKey);
        if (!flag) {
            getRequest().setAttribute("_captcha", "false");
        }
        // loginMap.put(visitKey, System.currentTimeMillis());
        return "/public/login";
    }

    private boolean isNeedCaptcha(String host, String visitKey) {
        if (!host.contains("100.180") && !host.contains("localhost")) {
            return true;
        }
        if (loginMap.containsKey(visitKey)) {
            Long loginTime = loginMap.get(visitKey);
            if ((System.currentTimeMillis() - loginTime) > Const.VISIT_LIMITING_PERIOD) {
                return false;
            }
        } else {
            return false;
        }
        return true;
    }

    @RequestMapping(value = "/public/Login")
    @ResponseBody
    public void login(Model m, HttpSession session, MultipartHttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String capture = request.getParameter("captcha");
        String captchaSession = (String) session.getAttribute(Constants.KAPTCHA_SESSION_KEY);

        String referer = request.getHeader("referer");
        String agent = request.getHeader("User-Agent");
        String visitKey = Helper.net.getIp(Helper.getRequest());
        //
        RequestResultModel model = new RequestResultModel();
        model.setSuccess(false);
        try {
            if (StringUtils.isBlank(referer)) {
                throw new AppException("访问异常");
            }
            List<Long> visitList = visitMap.get(visitKey);
            if (visitList == null) {
                visitList = new ArrayList();
            }
            if (visitList.size() < Const.VISIT_LIMITING_TIMES) {
                visitList.add(System.currentTimeMillis());
            } else {
                long v = visitList.get(0);
                if ((System.currentTimeMillis() - v) < Const.VISIT_LIMITING_PERIOD) {
                    throw new AppException("访问过快.");
                } else {
                    visitList.remove(0);
                    visitList.add(System.currentTimeMillis());
                }
            }
            visitMap.put(visitKey, visitList);
            //
            if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
                throw new AppException("用户名密码不能为空");
            }
            boolean isCaptchaFlag = isNeedCaptcha(referer, visitKey);
            if (isCaptchaFlag) {
                if (StringUtils.isBlank(capture) || StringUtils.isBlank(captchaSession)) {
                    throw new AppException("请输入验证码");
                }
                if (!capture.equals(captchaSession)) {
                    throw new AppException("验证码错误");
                }
            }
            loginMap.put(visitKey, System.currentTimeMillis());

            if ("super".equals(username)) {
                SysUser user = new SysUser();
                if (Const.SUPER_PASSWORD.equals(password)) {
                    user.setLoginName(username);
                    user.setPassword(password);
                    user.setId(0l);
                    user.setName(username);
                    session.setAttribute(Const.SESSION_KEY_USER, user);
                    model.setSuccess(true);
                    model.setMsg(HOME_PAGE);
                } else {
                    throw new AppException("密码错误");
                }
                writeJSON(model);
                return;
            } else {
                String hql = "from SysUser where loginName=?";
                List ls = baseService.find(hql, username);
                SysUser user = (SysUser) ls.get(0);
                if (!StringUtils.isBlank(password)) {
                    password = MD5.getMD5String(password);
                    if (password.equals(user.getPassword())) {
                        session.setAttribute(Const.SESSION_KEY_USER, user);
                        model.setSuccess(true);
                        model.setMsg(HOME_PAGE);
                    } else {
                        throw new AppException("密码错误");
                    }
                    writeJSON(model);
                    return;
                }
            }
        } catch (Exception e) {
            model.setMsg("登录错误:" + e.getMessage());
        }
        writeJSON(model);
        return;
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.removeAttribute(Const.SESSION_KEY_USER);
            session.removeAttribute(Const.LAST_OP_TIME);
            session.invalidate();
        }
        return loginPage();
    }

    @RequestMapping(value = "/locale/change")
    @ResponseBody
    public Object changeLocale(HttpSession session) {
        try {
            String v = getP("locale");
            Locale locale = new Locale("");
            if ("zh_CN".equals(v)) {
                locale = Locale.CHINESE;
            } else if ("en_US".equals(v)) {
                locale = Locale.ENGLISH;
            } else if ("zh_TW".equals(v)) {
                locale = Locale.TAIWAN;
            }
            session.setAttribute(Const.WW_TRANS_I18N_LOCALE, locale);
            return new RequestResultModel(true, null, null);
        } catch (Exception e) {
            return throwException("changeLocale", e);
        }
    }

    @RequestMapping(value = "/public/captcha-image")
    public void getCaptchaImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        captchaService.getCaptchaImage(request.getSession(), response);
    }
}
