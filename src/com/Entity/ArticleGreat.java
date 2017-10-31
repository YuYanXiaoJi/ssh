package com.Entity;

public class ArticleGreat {
	
	private Integer id;
	private UserArticle userArticle;
	private User user;
	
	
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
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	public ArticleGreat(){
		
	}
	public ArticleGreat(UserArticle userArticle, User user) {
		//super();
		this.userArticle = userArticle;
		this.user = user;
	}
	 
	
	
 
}
