package com.Action;
/*
 * 
 * 这是用户点赞乡村的操作
 */

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

 
import com.Algorithm.EliminateHtml;
import com.Entity.Sport;
import com.Entity.SportWantTo;
import com.Entity.User;
import com.Entity.UserUpdate;
 
import com.Service.SportService;
import com.Service.SportWantToService;
import com.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@Controller("sportWantToAction")
@Scope("prototype")

public class SportWantToAction extends ActionSupport {
	@Resource
	private SportWantToService sportWantToService;
	@Resource
	private UserService userService;
	@Resource
	private SportService sportService;
	
	private String json;//接受传递
	

	//增加或者删除点赞信息
	public void addOrSub(){
		JSONObject jsonObject = new JSONObject(json);
		String sport_id = jsonObject.getString("sport_id");
		String method = jsonObject.getString("method");
		
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name != null ){
 
		User user = userService.getUserByName(name);
		
		Sport sport = new Sport();
		sport = sportService.getSportDetail(Integer.parseInt(sport_id));
		
		if(method.equals("加")){
 
			SportWantTo sportWantTo = new SportWantTo();
			sportWantTo.setSport(sport);
			sportWantTo.setUser(user);
			
			sportWantToService.saveWant(sportWantTo);
			
			//sport的想去数加一   同时加综合评分---浏览0.2  想去0.3 评论0.5
			sport.setWantCount(sport.getWantCount() + 1);
			sport.setScore(sport.getScore() + 0.3);
			sportService.saveSport(sport);
			
			//同时保存用户的动态信息
			//处理存储进去的content 同时  截取
			String content = sport.getContent();
			/*if(content.length() > 550){
				content = content.substring(0,540);
			}*/
			UserUpdate userUpdate = new UserUpdate("点赞了景点", sport.getId(), sport.getName(),
				
				content,//new EliminateHtml().RemoveHtmlTag(content),
				//author为空
				null, sport.getWantCount(), user, new Date());
			
			userService.saveUserUpdate(userUpdate);
			
			
		}
		else {
			sportWantToService.deleteWant(Integer.parseInt(sport_id), user.getId());
			
			//sport的想去数加一  得分不减
			if(sport.getWantCount() > 0){
				sport.setWantCount(sport.getWantCount() - 1);
				sportService.saveSport(sport);
			}
			
			//删除用户的动态
			userService.deleteUserUpdate("点赞了景点", Integer.parseInt(sport_id), user.getId());
			
		}
		
		//传回新的点赞量
		String wantCount = sport.getWantCount().toString();
		String json2 = "{\"wantCount\":\"" + wantCount + "\"}";
		try {
			sendMsg(json2);
		} catch (IOException e) {
			 
			e.printStackTrace();
		}
		}
	}
	public void sendMsg(String content) throws IOException{
	     HttpServletResponse response = ServletActionContext.getResponse();//获取response
	     response.setContentType("text/html;charset=UTF-8");//编码
	     response.getWriter().write(content);
	   }
	
	
	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}
}
