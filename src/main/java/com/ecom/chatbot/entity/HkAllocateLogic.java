package com.ecom.chatbot.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecom.extra.entity.BasePo;
import com.ecom.extra.util.Helper;

@Entity
@Table(name = "hk_allocate_logic")
public class HkAllocateLogic extends BasePo {
	/**
	 * @author Long.Liu
	 * add hk logic 
	 */
	private static final long serialVersionUID = 1L;
	private Date createDate;
	private String fieldGdmName;
	private String reportName;
	private String logic;
	private String fieldLdmName;
	private String selfComment;
	private String cellLogicName;
	 public String getCreateDateView() {
	        return Helper.date.time2Str(createDate);
	    }
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getFieldGdmName() {
		return fieldGdmName;
	}
	public void setFieldGdmName(String fieldGdmName) {
		this.fieldGdmName = fieldGdmName;
	}
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public String getLogic() {
		return logic;
	}
	public void setLogic(String logic) {
		this.logic = logic;
	}
	public String getFieldLdmName() {
		return fieldLdmName;
	}
	public void setFieldLdmName(String fieldLdmName) {
		this.fieldLdmName = fieldLdmName;
	}
	public String getSelfComment() {
		return selfComment;
	}
	public void setSelfComment(String selfComment) {
		this.selfComment = selfComment;
	}
	public String getCellLogicName() {
		return cellLogicName;
	}
	public void setCellLogicName(String cellLogicName) {
		this.cellLogicName = cellLogicName;
	}
	
	
}
