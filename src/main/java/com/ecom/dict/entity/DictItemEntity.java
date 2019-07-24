package com.ecom.dict.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecom.extra.entity.BasePo;

@Entity
@Table(name = "sys_dict_item")
public class DictItemEntity extends BasePo {
    private String  code;
    private String  value;
    private String  name;
    private Integer status;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
