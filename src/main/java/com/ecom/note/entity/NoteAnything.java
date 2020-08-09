package com.ecom.note.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecom.extra.entity.BasePo;
import com.ecom.extra.util.Helper;

@Entity
@Table(name = "note_anything")
public class NoteAnything extends BasePo {
	/**
	 * @author Long.Liu
	 * add hk logic 
	 */
	private static final long serialVersionUID = 1L;
	private Date createDate;
	private Integer type;
	private String field;
	private String bookName;
	private String comment;

	 public String getCreateDateView() {
	        return Helper.date.time2Str(createDate);
	    }
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	
	
}
