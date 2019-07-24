package com.ecom.chatbot.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecom.extra.entity.BasePo;
import com.ecom.extra.util.Helper;

@Entity
@Table(name = "chatbot_question_answer")
public class QuestionAnswer extends BasePo {
	/**
	 * @author Long.Liu
	 * 问答实体类
	 */
	private static final long serialVersionUID = 1L;
	private Date createtime;
	private String question;
	private String answer;
	private Integer type;
	private Integer source;
	 public String getCreateDateView() {
	        return Helper.date.time2Str(createtime);
	    }
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getSource() {
		return source;
	}
	public void setSource(Integer source) {
		this.source = source;
	}
	
}
