package com.Entity;
/*
 * 所有标签表
 */
public class Tag {
	
	private Integer id;
	private String tag;
	//用于判断是否热门标签
	private Integer tagCount;
	
	
	 
	public Tag(String tag, Integer tagCount) {
		//super();
		this.tag = tag;
		this.tagCount = tagCount;
	}


	public Tag(){
	  
	}
	
	
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
	
	public Integer getTagCount() {
		return tagCount;
	}
	public void setTagCount(Integer tagCount) {
		this.tagCount = tagCount;
	}
	
	
}
