package com.Entity;

import java.util.Date;

public class SportComment {

	private Integer id;
	private Sport sport;//单向一对一
	private String content;
	private User user;
	private Date time;
	
	public SportComment(){
		
	}
 
	public SportComment(  Sport sport, String content, User user,
			Date time) {
		//super();
		//this.id = id;
		this.sport = sport;
		this.content = content;
		this.user = user;
		this.time = time;
	}



	public Date getTime() {
		return time;
	}
 
	public void setTime(Date time) {
		this.time = time;
	}
 
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Sport getSport() {
		return sport;
	}

	public void setSport(Sport sport) {
		this.sport = sport;
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
	
	
	
	
}
