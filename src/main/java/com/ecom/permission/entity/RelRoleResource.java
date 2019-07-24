package com.ecom.permission.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecom.extra.entity.BasePo;

@Entity
@Table(name = "rel_role_resource")
public class RelRoleResource extends BasePo {
    private String roleCode;
    private String resourceId;

    public String getRoleCode() {
        return roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode;
    }

    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }

}
