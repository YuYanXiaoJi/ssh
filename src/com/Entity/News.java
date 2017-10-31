package com.Entity;

import java.util.Date;

public class News {
	
	private Integer id;
	private User targetUser;
	private User user;
	private String title;
	private Integer title_id;
	private Date time;
	private Integer type1;//0-对回复下的回复   1-对文章的回复
	private Integer type2;//0-景点  1-文章
	private Integer flag;//0-未读  1-已读
	
	 
	public News(){
		
	}

	public News( User targetUser, User user, String title,
			Integer title_id, Date time, Integer type1, Integer type2,
			Integer flag) {
		//super();
		//this.id = id;
		this.targetUser = targetUser;
		this.user = user;
		this.title = title;
		this.title_id = title_id;
		this.time = time;
		this.type1 = type1;
		this.type2 = type2;
		this.flag = flag;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getTargetUser() {
		return targetUser;
	}

	public void setTargetUser(User targetUser) {
		this.targetUser = targetUser;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getTitle_id() {
		return title_id;
	}

	public void setTitle_id(Integer title_id) {
		this.title_id = title_id;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getType1() {
		return type1;
	}

	public void setType1(Integer type1) {
		this.type1 = type1;
	}

	public Integer getType2() {
		return type2;
	}

	public void setType2(Integer type2) {
		this.type2 = type2;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	
	 
	
	
	
	
}
