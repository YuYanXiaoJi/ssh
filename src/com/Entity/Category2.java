package com.Entity;
/*
 * 景点类别表（类型）
 */
import java.util.HashSet;
import java.util.Set;

public class Category2 {
	private Integer id;
	private String	name;
	//添加多的一方
	private Set<Sport> sport = new HashSet<Sport>();
	
	public Category2(){
		
	}
 
	public Category2(Integer id ) {
      this.id = id;
	 
	}
 
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<Sport> getSport() {
		return sport;
	}

	public void setSport(Set<Sport> sport) {
		this.sport = sport;
	}
	
	
	
	
}
