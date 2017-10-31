package com.Entity;
/*
 * 用户 活动关系表
 */
public class SpecialSchemeUser {
	private Integer id;
	private SpecialScheme schemeId;
	private String realName;
	private String telephone;
	private String address;
	private Integer age;
	private String sex;
	
	public SpecialSchemeUser() {
		
	}
	
	
	public SpecialSchemeUser(SpecialScheme schemeId, String realName,
			String telephone, String address, Integer age, String sex) {
		this.schemeId = schemeId;
		this.realName = realName;
		this.telephone = telephone;
		this.address = address;
		this.age = age;
		this.sex = sex;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public SpecialScheme getSchemeId() {
		return schemeId;
	}
	public void setSchemeId(SpecialScheme schemeId) {
		this.schemeId = schemeId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
 
	
}
