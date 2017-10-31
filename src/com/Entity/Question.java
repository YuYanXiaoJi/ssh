package com.Entity;

import java.util.Date;

public class Question {
	private Integer id;
	private String tag;
	private String title;
	private String content;
	private User user;
	private Integer pageView;
	private Integer focusCount;
	private Integer replyCount;
	private Date time;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Integer getPageView() {
		return pageView;
	}
	public void setPageView(Integer pageView) {
		this.pageView = pageView;
	}
	public Integer getFocusCount() {
		return focusCount;
	}
	public void setFocusCount(Integer focusCount) {
		this.focusCount = focusCount;
	}
	public Integer getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(Integer replyCount) {
		this.replyCount = replyCount;
	}
	
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Question(){
		
	}
	
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Question(Integer id){
		this.id = id;
	}
	public Question(String tag, String title, String content, User user,
			Integer pageView, Integer focusCount, Integer replyCount,Date time) {
		//super();
		this.tag = tag;
		this.title = title;
		this.content = content;
		this.user = user;
		this.pageView = pageView;
		this.focusCount = focusCount;
		this.replyCount = replyCount;
		this.time = time;
	}
	 
	
	
}
