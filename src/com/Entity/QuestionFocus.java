package com.Entity;
/*
 * 问题关注表
 */
public class QuestionFocus {
	private Integer id;
	private User user;
	private Question question;
	
	public QuestionFocus( User user, Question question) {
		//super();
		//this.id = id;
		this.user = user;
		this.question = question;
	}
	
	public QuestionFocus(){
		
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
	public Question getQuestion() {
		return question;
	}
	public void setQuestion(Question question) {
		this.question = question;
	}
	
	

}
