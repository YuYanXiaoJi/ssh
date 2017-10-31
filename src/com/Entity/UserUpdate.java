package com.Entity;

import java.util.Date;

/*
 *  个人动态表
 */
public class UserUpdate {
	private Integer id;
	private String flag;// 发表了游记    | 点赞了游记    点赞了景点   点赞了回答 提出了问题  关注了问题  回答了问题  
	private Integer other_id;//上面的flag的内筒的ID号  （例如文章的id号）
	private String title;//任何种类都有动态标题
	private String content;//关注了某问题是没有内容的只有标题
	private User author;//回答了某问题就是自己   其他的都是其他user   关注了问题没有user  
	private Integer count;//可以表示（26人赞同了该文章）
	private User owner;//区别是谁的动态
	private Date time;
	
	public UserUpdate(){
		
	}
 
	public UserUpdate(String flag, Integer other_id, String title,
			String content, User author, Integer count, User owner,Date time) {
		//super();
		this.flag = flag;
		this.time = time;
		this.other_id = other_id;
		this.title = title;
		this.content = content;
		this.author = author;
		this.count = count;
		this.owner = owner;
	}



	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public Integer getOther_id() {
		return other_id;
	}
	public void setOther_id(Integer other_id) {
		this.other_id = other_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	 
	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
	
	
}
