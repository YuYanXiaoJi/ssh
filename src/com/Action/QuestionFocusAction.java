package com.Action;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.Entity.Question;
import com.Entity.QuestionFocus;
import com.Entity.User;
import com.Entity.UserUpdate;
import com.Service.QuestionFocusService;
import com.Service.TalkService;
import com.Service.UserService;


@Controller("questionFocusAction")
@Scope("prototype")
public class QuestionFocusAction {
	@Resource
	private QuestionFocusService quesionFocusService;
	@Resource 
	private  TalkService talkService ;
	@Resource
	private UserService userService;
	
	private String json;
	//关注或者取消关注talk中的某一个---question
	public void focusOrNo() {
		JSONObject jsonObject = new JSONObject(json);
		String question_id = jsonObject.getString("question_id");
		String method = jsonObject.getString("method");//是add还是sub
		Integer user_id1 = (Integer)ServletActionContext.getRequest().getSession().getAttribute("user_id");
		if(user_id1 != null){
 
	    Integer user_id = user_id1;
		User user = new User(user_id);
	    
	    Question q = talkService.getQuestionDetailById(Integer.parseInt(question_id));
	 
	    if(method.equals("add")){
	    	 
		   quesionFocusService.savaQuestionFocus(new QuestionFocus(user, q));
		   q.setFocusCount(q.getFocusCount() + 1);
		   
		   //执行用户的动态信息保存
		   
		   UserUpdate userUpdate = new UserUpdate("关注了问题", q.getId(), q.getTitle(), 
				   //content 为null 作者为空 
				   null , null, q.getFocusCount(), user,new Date()
				   );
		   userService.saveUserUpdate(userUpdate);
		   
		  //保存用户的关注问题数量
		   user = userService.getUserById(user_id);
		   user.setQuestionCount(user.getQuestionCount() + 1);
		   userService.saveUser(user);
		   
		} else {
			if (q.getFocusCount() >= 1 ){
				q.setFocusCount(q.getFocusCount() -1);
			} else {
				q.setFocusCount(0);
			}
			quesionFocusService.deleteQuestionFocus(user_id, q.getId());
			
			//删除用户的动态消息
			userService.deleteUserUpdate("关注了问题", q.getId(), user_id);
			
			//保存用户的关注问题数量
			user = userService.getUserById(user_id);
			user.setQuestionCount(((user.getQuestionCount() - 1) >= 0) ? (user.getQuestionCount() - 1) : 0);
			userService.saveUser(user);
			
		}
	       	//保存问题的关注数量
	       talkService.saveQuestion(q);
		} 
	}
 
	
	
	public String getJson() {
		return json;
	}
	public void setJson(String json) {
		this.json = json;
	}
	
	
	
	
	
}
