package com.Entity;

import java.util.Date;

/*
 * 记录每天的访问量  浏览量 ...
 */
public class PageView {
	private Integer id;
	private Date time;
	private Integer loginCount;//用户登入数量
	private Integer pageViewCount;//浏览量
	private Integer articleCount;//新增文章
	private Integer commentCount;//新增评论
	private Integer questionCount;//新增提问
	private Integer answerCount;//新增回答数
	private Integer registerCount;//新增注册人
	
	public PageView() {
		
	}
 
	public PageView(Date time, Integer loginCount, Integer pageViewCount,
			Integer articleCount, Integer commentCount, Integer questionCount,
			Integer answerCount, Integer registerCount) {
 
		this.time = time;
		this.loginCount = loginCount;
		this.pageViewCount = pageViewCount;
		this.articleCount = articleCount;
		this.commentCount = commentCount;
		this.questionCount = questionCount;
		this.answerCount = answerCount;
		this.registerCount = registerCount;
	}
 
	public Integer getRegisterCount() {
		return registerCount;
	}
	public void setRegisterCount(Integer registerCount) {
		this.registerCount = registerCount;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Integer getLoginCount() {
		return loginCount;
	}
	public void setLoginCount(Integer loginCount) {
		this.loginCount = loginCount;
	}
	public Integer getPageViewCount() {
		return pageViewCount;
	}
	public void setPageViewCount(Integer pageViewCount) {
		this.pageViewCount = pageViewCount;
	}
	public Integer getArticleCount() {
		return articleCount;
	}
	public void setArticleCount(Integer articleCount) {
		this.articleCount = articleCount;
	}
	public Integer getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(Integer commentCount) {
		this.commentCount = commentCount;
	}
	public Integer getQuestionCount() {
		return questionCount;
	}
	public void setQuestionCount(Integer questionCount) {
		this.questionCount = questionCount;
	}

	public Integer getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(Integer answerCount) {
		this.answerCount = answerCount;
	}
	 
	 

}
