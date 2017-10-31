package com.Entity;
/*
 * 作为用来记录用户平时浏览习惯的表
 * 每个用户固定30条记录(15条作为New 15条作为old)
 * 多的则剔除相对最不常浏览的tag的标签
 */
public class CacheTag {
	private Integer id;
	private Integer tagId;
	private Integer userId;
	private Integer count;//频率
	private String flag;//old or new
	
	public CacheTag(){
		
	}
  
 
	public CacheTag(Integer tagId, Integer userId, Integer count, String flag) {
		 
		this.tagId = tagId;
		this.userId = userId;
		this.count = count;
		this.flag = flag;
	}


	public Integer getTagId() {
		return tagId;
	}


	public void setTagId(Integer tagId) {
		this.tagId = tagId;
	}


	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	 
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	
	
}
