package com.Entity;

import java.util.Date;

public class UserArticleComment {
	
	private Integer id;
	private UserArticle userArticle; 
	private String content;
	private User user;
	private Date time;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public UserArticleComment(  UserArticle userArticle,
			String content, User user, Date time) {
		//super();
		//this.id = id;
		this.userArticle = userArticle;
		this.content = content;
		this.user = user;
		this.time = time;
	}
	public UserArticleComment(){
		
	}
	
	
}
