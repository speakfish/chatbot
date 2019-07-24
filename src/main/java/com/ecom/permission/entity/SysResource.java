package com.ecom.permission.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecom.extra.entity.BasePo;

@Entity
@Table(name = "sys_resource")
public class SysResource extends BasePo {
    private String  code;
    private String  name;
    private String  url;
    private Integer type;//1 不显示左边栏  2不显示在菜单栏
    private Integer status;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
