package com.Action;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.Algorithm.EliminateHtml;
import com.Entity.ArticleGreat;
import com.Entity.User;
import com.Entity.UserArticle;
import com.Entity.UserUpdate;
import com.Service.ArticleGreatService;
import com.Service.ArticleService;
import com.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@Controller("articleGreatAction")
@Scope("prototype")
public class ArticleGreatAction extends ActionSupport {
	
	@Resource
	private ArticleGreatService articleGreatService;
	@Resource
	private UserService userService;
	@Resource
	private ArticleService articleService;
	
	private String json;//接受传递
	
	
	//增加或者删除点赞信息
	public void addOrSub(){
		JSONObject jsonObject = new JSONObject(json);
		String userArticle_id = jsonObject.getString("userArticle_id");
		String method = jsonObject.getString("method");
			
		//User user = userService.getUserByName(ServletActionContext.getRequest().getSession().getAttribute("name").toString());
		Integer user_id1 = (Integer) ServletActionContext.getRequest().getSession().getAttribute("user_id");
		if(user_id1 != null ) {
 
	    Integer user_id = user_id1; 
		User user = new User(user_id);
		
	    UserArticle userArticle = new UserArticle();
	    
		userArticle = articleService.getArticleDetail(Integer.parseInt(userArticle_id));
		
		if(method.equals("加")){
 
			ArticleGreat articleGreat = new ArticleGreat(userArticle, user);
  
			articleGreatService.saveGreat(articleGreat);
			
			//文章的点赞量加一
			userArticle.setGreatCount(userArticle.getGreatCount() + 1);
			
			userService.saveUserArticle(userArticle);
			
			//增加用户的动态
			String content = userArticle.getContent();
			/*if(content.length() > 550){
				content = content.substring(0,550);
			}*/
			UserUpdate userUpdate = new UserUpdate("点赞了游记", userArticle.getId(), userArticle.getTitle(),
					//得到文章的内容
					content,//new EliminateHtml().RemoveHtmlTag(content),
					//游记的作者   文章的 点赞数
					userArticle.getUser(), userArticle.getGreatCount(), user, new Date());
				
			userService.saveUserUpdate(userUpdate);
			
		}
		else {
			articleGreatService.deleteGreat(Integer.parseInt(userArticle_id), user.getId());
			
			//文章的点赞量减一
			if(userArticle.getGreatCount() > 0){
				userArticle.setGreatCount(userArticle.getGreatCount() - 1);
				userService.saveUserArticle(userArticle);
			}
			
			//删除了用户的动态消息
			userService.deleteUserUpdate("点赞了游记", userArticle.getId(), user.getId());
		}
		
		//传回新的点赞量
		String greatCount = userArticle.getGreatCount().toString();
		String json2 = "{\"greatCount\":\"" + greatCount + "\"}";
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
