package com.Entity;

import java.util.Date;

public class UserArticleReply {
	
	private Integer id;
	private UserArticle userArticle;
	private Integer	targetCRId; 
	private String type; 
	private User user;
	private User targetUser;//Ä¿±êÈË
	private Date time;
	private String content;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public UserArticle getUserArticle() {
		return userArticle;
	}
	public void setUserArticle(UserArticle userArticle) {
		this.userArticle = userArticle;
	}
	public Integer getTargetCRId() {
		return targetCRId;
	}
	public void setTargetCRId(Integer targetCRId) {
		this.targetCRId = targetCRId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public User getTargetUser() {
		return targetUser;
	}
	public void setTargetUser(User targetUser) {
		this.targetUser = targetUser;
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
	public UserArticleReply(  UserArticle userArticle,
			Integer targetCRId, String type, User user, User targetUser,
			Date time, String content) {
		//super();
		//this.id = id;
		this.userArticle = userArticle;
		this.targetCRId = targetCRId;
		this.type = type;
		this.user = user;
		this.targetUser = targetUser;
		this.time = time;
		this.content = content;
	}
	
	public UserArticleReply(){
		
	}
}
