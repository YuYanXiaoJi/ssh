package com.Entity;

public class SportWantTo {
	
	private Integer id;
	private Sport sport;
	private User user;
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
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	public SportWantTo(){
		
	}
	public SportWantTo(Sport sport, User user) {
		//super();
		this.sport = sport;
		this.user = user;
	}
	
}
