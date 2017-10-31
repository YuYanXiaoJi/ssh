package com.Action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
 
 
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
 
 

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.aspectj.util.FileUtil;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.Algorithm.Pager;
import com.Algorithm.PagerService;
import com.Entity.*;
import com.Service.ArticleGreatService;
import com.Service.ArticleService;
import com.Service.OtherToTagService;
import com.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;
/*
 * 增删改查  个人文章的管理
 * 个人操作    不涉及公共(点赞评论什么的)
 */

@SuppressWarnings("serial")
@Controller("userArticleAction")
@Scope("prototype")
public class UserArticleAction extends ActionSupport {
	
	@Resource
	public UserService userService;
	@Resource
	private OtherToTagService otherToTagService;
	@Resource
	private ArticleService articleService;
	@Resource
	private ArticleGreatService  articleGreatService;
	@Resource
	private AdminStatisticsAction adminAtatisticsAction; 
	
	private UserArticle userArticle;
	private List<UserArticle> list;
	
	private File uploadImage;//封面
	private String uploadImageContentType;
	private String uploadImageFileName;
	
	private PagerService pagerService;//分页属性
	private Pager pager;
	protected String currentPage; 
	protected int totalPages;
	protected String totalRows;
	protected String pagerMethod;
	
	private String articleCategory[];//存放草稿的类别
	private String isRevise;
	private String json;//删除文章(userarticle_id)
 
	
	//删除文章  删除的顺序
	public void deleteUserArticle(){
		
		JSONObject jo = new JSONObject(json);
		Integer userArticle_id = jo.getInt("userArticle_id");
		
		//删除文章的所有的评论
		userService.deleteArticleComment(userArticle_id);
		userService.deleteArticleReply(userArticle_id);
 
		//删除动态
		Integer userId = (Integer)ServletActionContext.getRequest().getSession().getAttribute("user_id");
		if (userId != null) {
			userService.deleteUserUpdate("发表了游记", userArticle_id, userId);
		}
		//删除OtherToTag
		otherToTagService.delteArticleToTag(userArticle_id, "article");
		//删除点赞信息
		articleGreatService.deleteArticleToGreat(userArticle_id);
		//删除文章
		userService.deletUserArticle(userArticle_id);
		
		
	}
	
	//得到文章  转到修改页面
	public String getArticleDetailUpdate(){
		list = new LinkedList<UserArticle>();
		list.add(articleService.getArticleDetail(userArticle.getId()));
		getUserArticleCategory(list); // 提取表情 同时 浏览量加一  为了 防止 增加 用户动态
		return SUCCESS;
	}
	
	//查看自己是否已经有了草稿
	public String getUserDraft(){
		String username = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(username == null) return INPUT;
		
		list = userService.getUserDraft(username);
		if(list.size() != 0){
			getUserArticleCategory(list);
		}
		return SUCCESS;
	}
	
	//作为转到articleupdate的页面的  提取  标签的方法
	public void getUserArticleCategory(List<UserArticle> list){
		userArticle = list.get(0);
		userArticle.setGreatCount(userArticle.getGreatCount() + 1);//给 审核的时候判断  浏览量!=1  不必新增  用户动态 
		String []tagName = userArticle.getTag().split("/");
		articleCategory = new String[3];
		StringBuffer tagCustom = new StringBuffer();
		for (int i = 0; i < tagName.length; i++) {
			Tag tag = otherToTagService.getTagById(Integer.parseInt(tagName[i]));	
			if (i >= 2 ) {
				tagCustom.append(tag.getTag() + "/");
			} else {
				articleCategory[i] = tag.getTag();
			}
		}
		if (tagName.length > 2) {
			articleCategory[2] = tagCustom.substring(0, tagCustom.length()-1); 
		}
	}

 
	//保存文章 (保存草稿，修改后的文章，新建的文章)
	public String saveUserArticle() throws IOException{
		
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name == null) return INPUT;
		if(uploadImage != null){
			String path = ServletActionContext.getServletContext().getRealPath("/image/article");
			File file = new File(path);
			if(!file.exists()){
				file.mkdir();
			}
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
			uploadImageFileName = format.format(new Date()) + uploadImageFileName.substring(uploadImageFileName.indexOf('.'));
			FileUtil.copyFile(uploadImage, new File(file, uploadImageFileName));
			userArticle.setCover("image/article/" + uploadImageFileName);
		}
		
		userArticle.setTime(new Date());
		userArticle.setIsExamination("false");
		if (String.valueOf(isRevise).equals("null") || String.valueOf(isRevise).equals("")) {  //如果是修改就不需要
			userArticle.setGreatCount(1);//浏览量
			userArticle.setScore(0.0);
			userArticle.setCommentCount(0);
			userArticle.setWantCount(0);
		}
		
		userArticle.setUser(userService.getUserByName(name));
		//进行文章的tag打标签 并且保存文章  
		doArticleToTag(name);
			
		if(userArticle.getIsDraft().equals("false")){ 
			adminAtatisticsAction.countAdd("article"); 
			return SUCCESS;
		}	
		else return "index";//保存的是草稿
	}
	
 
	
	//进行一些列tag操作   注意先保存-文章-再保存-关系-
	public void  doArticleToTag(String name){
		//取出关键tag
		String str[] = userArticle.getTag().trim().replaceAll("\\s+", "").split("/");
		 
		StringBuffer tag2 = new StringBuffer();

		//标签id和tag实体  将贵州/人文历史  --->  23/34
		List<Tag> taglist = new LinkedList<Tag>(); //存放文章的tag 用于后续的otherToTag的互相关系的保存
		//去除相同标签用
		Set<String> tempTagName = new HashSet<String>();
		
		for (int i = 0; i < str.length; i++) {
			if(tempTagName.contains(str[i])) continue;
			tempTagName.add(str[i]);
			if(str[i].length() == 0) continue;
			List<Tag> tempTag = new LinkedList<Tag>(); 
			tempTag = otherToTagService.getTagIdByName(str[i]); //检查该标签是否存在
			if(tempTag.size() == 0){
				Tag  tag = new Tag(str[i], 0);
				otherToTagService.saveTag(tag);//保存一个本来没有新的tag
				tempTag.add(tag);//用户后面加入到taglist中（taglist用于保存关系）
				//otherToTagService.saveTag(tempTag.get(0));
			} else {
				//对标签的热门程度+1（热门）
				tempTag.get(0).setTagCount(tempTag.get(0).getTagCount() + 1);
				otherToTagService.saveTag(tempTag.get(0));
			}
			taglist.add(tempTag.get(0));
			tag2.append("/" + tempTag.get(0).getId());
		}
 
		userArticle.setTag(tag2.substring(1));
		//保存文章
		userService.saveUserArticle(userArticle);

		//User user = userService.getUserByName(name);
		
		//如果是草稿不保存关系   发表新文章或者修改文章再保存tag-article  combination
		if (userArticle.getIsDraft().equals("false")) {
			List<OtherToTag> tagRelationAll ;
			if(String.valueOf(isRevise).equals("true")){  //如果是修改（已经发表过的）
				//得到原有的所有的标签关系
				tagRelationAll = otherToTagService.getOtherToTagByOtherAll(userArticle.getId(), "article");
				for(OtherToTag var1 : tagRelationAll){
					int flag = 0;
					for(Tag  var2 : taglist){//taglist  是现在的文章的标签
						if(var1.getTag().getTag().equals(var2.getTag())){ //说明关系还需保留
							flag = 1; break;
						}
					}
					if(flag == 0){//这个关系需要删除
						otherToTagService.deleteOtherToTag(var1);
					}
				}
				
				for(Tag var2 : taglist){
					int flag = 0;
					for(OtherToTag var1 : tagRelationAll){
						if(var1.getTag().getTag().equals(var2.getTag())){ //说明关系已经存在
							flag = 1; break;
						}
					}
					if(flag == 0){ //需要新加这个关系
						otherToTagService.saveOtherToTag(new OtherToTag(userArticle.getId(), var2, "article"));
					}
				}		
			} else {//草稿或者第一次发表
				//避免标签的重复 保证otherToTag 的不重复
				Set<String> temp = new HashSet<String>();
				for (Tag var2 : taglist) {
					if (temp.contains(var2.getTag())) continue;
					temp.add(var2.getTag());
					otherToTagService.saveOtherToTag(new OtherToTag(userArticle.getId(), var2, "article"));
				}
			}
	  }
		
		//添加用户的动态  只有发表新的文章的时候才保存动态   
		//用户管理员审核之后才  添加用户动态
		/*if(String.valueOf(isRevise).equals("null") && userArticle.getIsDraft().equals("false")){
			String content = userArticle.getContent();
			if(content.length() > 550){
				content = content.substring(0,550);
			}
			userService.saveUserUpdate(new UserUpdate("发表了游记", userArticle.getId(),userArticle.getTitle(), 
					new EliminateHtml().RemoveHtmlTag(content), user, null, user, userArticle.getTime()
					));
		}*/
	}
	
	//得到所有用户文章
	public String getUserArticleAll(){
		
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name == null) return INPUT;
		list = new LinkedList<UserArticle>();
		list = userService.getUserArticleAll(name);
		
		//分页
		List<UserArticle> template = list;
		list = new LinkedList<UserArticle>();
		if(template.size() > 0){
			 Page(template.size(), 2);
			 for(int i = this.pager.getStartRow() - 1, z = 0; i < this.pager.getTotalRows() && z < this.pager.getPageSize(); z++, i++){
				 list.add(template.get(i));
			 }
		 }
 
		return SUCCESS;
	}
	
	
	//分页函数
	public void Page(int totalRow, int PageRow){ 
		pagerService = new PagerService();
		this.pager = pagerService.getPager(this.getCurrentPage(), this.getPagerMethod(), totalRow, PageRow);
		this.setCurrentPage(String.valueOf(this.pager.getCurrentPage()));
		this.setTotalRows(String.valueOf(totalRow));
		this.totalPages = pager.getTotalPages();
	}

	
	public File getUploadImage() {
		return uploadImage;
	}

	public void setUploadImage(File uploadImage) {
		this.uploadImage = uploadImage;
	}

	public String getUploadImageContentType() {
		return uploadImageContentType;
	}

	public void setUploadImageContentType(String uploadImageContentType) {
		this.uploadImageContentType = uploadImageContentType;
	}

	public String getUploadImageFileName() {
		return uploadImageFileName;
	}

	public void setUploadImageFileName(String uploadImageFileName) {
		this.uploadImageFileName = uploadImageFileName;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public PagerService getPagerService() {
		return pagerService;
	}

	public void setPagerService(PagerService pagerService) {
		this.pagerService = pagerService;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public String getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public String getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(String totalRows) {
		this.totalRows = totalRows;
	}

	public String getPagerMethod() {
		return pagerMethod;
	}

	public void setPagerMethod(String pagerMethod) {
		this.pagerMethod = pagerMethod;
	}

	public List<UserArticle> getList() {
		return list;
	}

	public void setList(List<UserArticle> list) {
		this.list = list;
	}

	public UserArticle getUserArticle() {
		return userArticle;
	}
 
	public void setUserArticle(UserArticle userArticle) {
		this.userArticle = userArticle;
	}

	public String[] getArticleCategory() {
		return articleCategory;
	}

	public void setArticleCategory(String[] articleCategory) {
		this.articleCategory = articleCategory;
	}

	public String getIsRevise() {
		return isRevise;
	}

	public void setIsRevise(String isRevise) {
		this.isRevise = isRevise;
	}
	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}
 
	
}
