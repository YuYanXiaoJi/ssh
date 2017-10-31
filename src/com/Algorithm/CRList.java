package com.Algorithm;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

import com.Entity.SportComment;
import com.Entity.SportReply;
import com.Entity.User;
import com.Entity.UserArticleComment;
import com.Entity.UserArticleReply;
/*
 * 现将SportComment和SportReply的类型转成CRList类型    放于list1 和 list2
 * 然后再 排序  放在list3 中传回
 */
public class CRList {
	
	private Integer rank;
	private Date time;
	private User user;//登入的用户
	private User targetUser;
	private String content;
	private Integer flag;//为了找父子关系的时候标记号（0）（1,2） 
	private Integer id;//自身的ID号
	private Integer targetId;
	
public	List<CRList> getCRArticleList(List<UserArticleComment> sc, List<UserArticleReply> sr){
		
		List<CRList> list3 = new LinkedList<CRList>();
		
		Stack<CRList> S = new Stack<CRList>();
		
		List<CRList> list2 = new LinkedList<CRList>();
		
		for(int i = 0; i < sc.size(); i++){
			S.push(changeToCRArticle1(sc.get(i)));
		}
		
		for(int i = 0; i< sr.size(); i++){
			list2.add(changeToCRArticle2(sr.get(i)));
		}
		
		while(!S.isEmpty()){
			CRList template = S.pop();
			list3.add(template);
			for(int i = 0; i<list2.size(); i++){
				//如果是父子关系
				if((template.getId() == list2.get(i).getTargetId())){
					if((list2.get(i).getFlag() == 2 && template.getFlag() == 2) || (list2.get(i).getFlag() - template.getFlag() == 1)){
						if((template.getRank() + 50) >= 600){
							list2.get(i).setRank(600);
						}else{
							list2.get(i).setRank(template.getRank() + 50);
						}
						
						S.push(list2.get(i));
					}	
				}
			}
		}
		
		/*for(int i =0 ;i<list3.size();i++){
			System.out.println(list3.get(i).getContent()+"  "+list3.get(i).getRank());
		}*/
			return list3;
	}
	
	private CRList changeToCRArticle1(UserArticleComment temp){
		return new CRList(0, temp.getTime(), temp.getUser(), null, temp.getContent(), 0, temp.getId(), null);
	}
	
	private CRList changeToCRArticle2(UserArticleReply temp){
		int a = 2;
		if(temp.getType().equals("comment")){
			a = 1;
		}
		return new CRList(0, temp.getTime(), temp.getUser(), temp.getTargetUser(), temp.getContent(), a, temp.getId(), temp.getTargetCRId());
	}
	
	
//---------------------------------------------------------------------------------	
	public	List<CRList> getCRList(List<SportComment> sc, List<SportReply> sr){
		
		List<CRList> list3 = new LinkedList<CRList>();
		
		Stack<CRList> S = new Stack<CRList>();
		
		List<CRList> list2 = new LinkedList<CRList>();
		
		for(int i = 0; i < sc.size(); i++){
			S.push(changeToCR1(sc.get(i)));
		}
		
		for(int i = 0; i< sr.size(); i++){
			list2.add(changeToCR2(sr.get(i)));
		}
		
		while(!S.isEmpty()){
			CRList template = S.pop();
			list3.add(template);
			for(int i = 0; i<list2.size(); i++){
				//如果是父子关系
				if((template.getId() == list2.get(i).getTargetId())){
					if((list2.get(i).getFlag() == 2 && template.getFlag() == 2) || (list2.get(i).getFlag() - template.getFlag() == 1)){
						if((template.getRank() + 50) >= 600){
							list2.get(i).setRank(600);
						}else{
							list2.get(i).setRank(template.getRank() + 50);
						}
						//list2.get(i).setRank(template.getRank() + 30);
						S.push(list2.get(i));
					}	
				}
			}
		}
		
		/*for(int i =0 ;i<list3.size();i++){
			System.out.println(list3.get(i).getContent()+"  "+list3.get(i).getRank());
		}*/
			return list3;
	}
	
	private CRList changeToCR1(SportComment temp){
		return new CRList(0, temp.getTime(), temp.getUser(), null, temp.getContent(), 0, temp.getId(), null);
	}
	
	private CRList changeToCR2(SportReply temp){
		int a = 2;
		if(temp.getType().equals("comment")){
			a = 1;
		}
		return new CRList(0, temp.getTime(), temp.getUser(), temp.getTargetUser(), temp.getContent(), a, temp.getId(), temp.getTargetCRId());
	}
	
 
	public CRList(Integer rank, Date time, User user, User targetUser,
			String content, Integer flag, Integer id, Integer targetId) {
		//super();
		this.rank = rank;
		this.time = time;
		this.user = user;
		this.targetUser = targetUser;
		this.content = content;
		this.flag = flag;
		this.id = id;
		this.targetId = targetId; 
	}

	public CRList(){
		
	}

	public Integer getRank() {
		return rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTargetId() {
		return targetId;
	}

	public void setTargetId(Integer targetId) {
		this.targetId = targetId;
	}
	
	
	

}
