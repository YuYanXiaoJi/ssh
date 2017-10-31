package com.Entity;
/*
 * 文章to标签表
 * 问题to标签
 */
public class OtherToTag {
	
	private Integer id;
	private Integer otherId;//问题或者文章的id
	private Tag tag;
	private String flag;//用来区分是文章还是问题 article question

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getOtherId() {
		return otherId;
	}
	public void setOtherId(Integer otherId) {
		this.otherId = otherId;
	}
	public Tag getTag() {
		return tag;
	}
	public void setTag(Tag tag) {
		this.tag = tag;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	public OtherToTag(){
		
	}

	public OtherToTag(Integer otherId, Tag tag, String flag) {
		//super();
		this.otherId = otherId;
		this.tag = tag;
		this.flag = flag;
	}
	
	
	 
}
