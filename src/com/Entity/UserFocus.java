package com.Entity;
/*
 * 用户互相关注表
 */
public class UserFocus {
	private Integer id;
	private User user;
	private User targetUser;
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
	public User getTargetUser() {
		return targetUser;
	}
	public void setTargetUser(User targetUser) {
		this.targetUser = targetUser;
	}
	public UserFocus(){
		
	}
	public UserFocus(User user, User targetUser) {
		//super();
		this.user = user;
		this.targetUser = targetUser;
	}
	
	
}
