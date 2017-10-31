package com.Entity;

public class AnswerGreat {
	
	private Integer id;
	private Answer answer;
	private User user;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Answer getAnswer() {
		return answer;
	}
	public void setAnswer(Answer answer) {
		this.answer = answer;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public AnswerGreat(Answer answer, User user) {
		//super();
		this.answer = answer;
		this.user = user;
	}
	public AnswerGreat(){
		
	}
	
}
