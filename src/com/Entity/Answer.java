package com.Entity;

import java.util.Date;
/*
 * 对提问的回答
 */
public class Answer {
	private Integer id;
	private User user;
	private Date time;
	private String content;
	private Integer question_id;
	private Integer father_id;//若为对问题的回答    此处为问题编号   对回答的回复（也就是回答的评论）此处为给回答id
	private Integer flag;//0是一级    1是二级
	private Integer greatCount;
	
	public Answer(){
		
	}
 
	public Answer(User user, Date time, String content, Integer question_id,
			Integer father_id, Integer flag,Integer greatCount) {
		//super();
		this.user = user;
		this.time = time;
		this.content = content;
		this.question_id = question_id;
		this.father_id = father_id;
		this.greatCount = greatCount;
	}
 
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(Integer question_id) {
		this.question_id = question_id;
	}
	public Integer getFather_id() {
		return father_id;
	}
	public void setFather_id(Integer father_id) {
		this.father_id = father_id;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public Integer getGreatCount() {
		return greatCount;
	}

	public void setGreatCount(Integer greatCount) {
		this.greatCount = greatCount;
	}
	
	
	
}
