package com.Entity;

import java.util.Date;

/*
 * 单向一对一
 */
public class SportReply {

	private Integer id;
	private Sport sport;
	private Integer	targetCRId;//回复评论或者回复回复的目标ID
	private String type;//类型  是  comment 还是  reply（前者是对comment的回复后者是对回复的回复）
	private User user;
	private User targetUser;//目标人
	private Date time;
	private String content;
	
	public SportReply(){
		
	}
 
	public SportReply( Sport sport, Integer targetCRId, String type,
			User user, User targetUser, Date time, String content) {
		//super();
		//this.id = id;
		this.sport = sport;
		this.targetCRId = targetCRId;
		this.type = type;
		this.user = user;
		this.targetUser = targetUser;
		this.time = time;
		this.content = content;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
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
	
	
	
	
}
