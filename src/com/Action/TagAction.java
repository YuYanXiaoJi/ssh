package com.Action;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;


import com.Algorithm.EliminateHtml;
import com.Entity.User;
import com.Entity.UserArticle;
import com.Service.ArticleService;
import com.Service.OtherToTagService;
import com.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@Controller("tagAction")
@Scope("prototype")

public class TagAction extends ActionSupport {
	
	@Resource
	private OtherToTagService otherToTagService;
	@Resource
	private ArticleService articleService;
	@Resource
	private UserService userService;
	
	//接受json
	private String json;
	 
	/*
	public void getArticleByTag(){
		//包不要导错
		JSONObject ObjecJson = new JSONObject();
		ObjecJson = JSONObject.fromObject(json);
		String tagName = ObjecJson.getString("tagName");
		Integer count = ObjecJson.getInt("count");
		Integer pageSize = ObjecJson.getInt("pageSize");
		//查找tagName的id;
		Integer tag_id = articleToTagService.searchTag(tagName).get(0).getId();
		//查找相应的文章Tag关系
		List<ArticleToTag> temp = articleToTagService.getArticleToTagByTag_id(tag_id);
		List<ArticleToTag> temp2 = new LinkedList<ArticleToTag>();
		//需要新的加载的东西
		for(int i = count * pageSize, j = 0; i < temp.size() && j < pageSize; i++, j++){
			temp2.add(temp.get(i));
		}
		//传回json2数组(需要json的所有包,需要添加)
		JsonConfig config = new JsonConfig();
		
		//config.setExcludes(new String[]{"handler","hibernateLazyInitializer"});  
		//config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		
		//过滤  (放弃了采用级联的方式)
		config.setExcludes(new String[] { "userArticle","tag"});
		
		//防止util的时间格式换成json (1.可能是放弃了级联所以无需管  2.可能本来的定义就是java.util.data  总之没报错)
		//config.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		
		
		//取出文章的user he article（取出文章时没有懒加载）
		//通过在jsonarray中放jsonobject  jsonobject中放基本信息
		JSONArray ja = new JSONArray();
		for(ArticleToTag articleToTag:temp2){
			JSONObject jsonObject = new JSONObject();
			UserArticle userArticle = articleService.getArticleDetail(articleToTag.getUserArticle().getId()); 
			jsonObject.put("time", userArticle.getTime().toString().substring(0, 16));
			
			jsonObject.put("title", userArticle.getTitle());
			
			jsonObject.put("greatCount", userArticle.getGreatCount());
			jsonObject.put("content", new EliminateHtml().RemoveHtmlTag(userArticle.getContent()));
			
			Map<String, String> map = new HashMap<String, String>();
			User user = userArticle.getUser();
			map.put("username", user.getUsername());
			map.put("img", user.getAvatar());
			jsonObject.put("user", map);
			
			//因为不知为何  list  key 改为tag 就接收不到
			List<String> list = new LinkedList<String>();
			String tag[] = userArticle.getTag().split("/");
			for(int i = 0; i < tag.length; i++){
				list.add(articleToTagService.getTagById(Integer.parseInt(tag[i])).getTag());
			}
			jsonObject.put("tagName", list);
			
			//方法二  曲线救国
			Map<String, String> tagMap = new LinkedHashMap<String, String>();//为了按顺序用Linked..
			String tag[] = userArticle.getTag().split("/");
			tagMap.put("length",  tag.length + "");//用于jsp 判断文章 有多少个标签
			for(int i = 0; i < tag.length; i++){
				tagMap.put(i + "", articleToTagService.getTagById(Integer.parseInt(tag[i])).getTag());
			}
			jsonObject.put("tagName", tagMap);
			
			
			//System.out.println(jsonObject);
			
			ja.add(jsonObject);
		}
		//System.out.println(ja);
		
		
		JSONArray jsonArray = JSONArray.fromObject(ja, config);
		
		String json2 = jsonArray.toString();
		
		try {
			sendMsg(json2);
		} catch (IOException e) {
			 
			e.printStackTrace();
		}
 
	}
 

	public void sendMsg(String content) throws IOException{
	     HttpServletResponse response = ServletActionContext.getResponse();//获取response
	     response.setContentType("text/html;charset=UTF-8");//编码
	     response.getWriter().write(content);
	}
*/

	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}

	 
	
	
}
