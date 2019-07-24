package com.ecom.permission.action;

import java.awt.image.RenderedImage;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecom.core.model.RequestResultModel;
import com.ecom.extra.action.BaseAction;
import com.ecom.extra.util.Helper;

@Controller
@RequestMapping(value = "/person")
public class PersonAction extends BaseAction {

    @RequestMapping(value = "/head-pic/{type}/{loginName}")
    public void getHeadPic(@PathVariable String type, @PathVariable String loginName, HttpServletRequest request,
                            HttpServletResponse response) {
        try {
            response.setDateHeader("Expires", 0);
            response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
            response.addHeader("Cache-Control", "post-check=0, pre-check=0");
            response.setHeader("Pragma", "no-cache");
            response.setContentType("image/jpg");

            ServletOutputStream out = response.getOutputStream();
            RenderedImage im = ImageIO.read(Helper.getResouceInputStream("/res/avatar.png"));
            ImageIO.write(im, "jpg", out);
            try {
                out.flush();
            } finally {
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/welcome")
    @ResponseBody
    public Object welcome() {
        try {
            Map result = new HashMap();
            result.put("code", "100");
            return new RequestResultModel(true, "操作成功.", result);
        } catch (Exception e) {
            return throwException("welcome error", e);
        }
    }

}
