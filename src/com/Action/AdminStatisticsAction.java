package com.Action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.Algorithm.CRList;
import com.Entity.Answer;
import com.Entity.Category1;
import com.Entity.Category2;
import com.Entity.OtherToTag;
import com.Entity.PageView;
import com.Entity.Question;
import com.Entity.QuestionFocus;
import com.Entity.SpecialScheme;
import com.Entity.SpecialSchemeUser;
import com.Entity.Sport;
import com.Entity.SportComment;
import com.Entity.SportReply;
import com.Entity.SportWantTo;
import com.Entity.Tag;
import com.Entity.User;
import com.Entity.UserArticle;
import com.Entity.UserArticleComment;
import com.Entity.UserArticleReply;
import com.Entity.UserUpdate;
import com.Service.AdminStatisticsService;
import com.Service.ArticleGreatService;
import com.Service.ArticleService;
import com.Service.OtherToTagService;
import com.Service.QuestionFocusService;
import com.Service.SportService;
import com.Service.SportWantToService;
import com.Service.TalkService;
import com.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;
 


@SuppressWarnings("serial")
@Controller("adminStatisticsAction")
@Scope("prototype")
public class AdminStatisticsAction extends ActionSupport {
	@Resource
	private AdminStatisticsService adminStatisticsService;
	@Resource
	private SportService sportService;
	@Resource
	public UserService userService;
	@Resource
	private OtherToTagService otherToTagService;
	@Resource
	private SportWantToService sportWantToService; 
	@Resource
	private ArticleService articleService;
	@Resource
	private ArticleGreatService  articleGreatService;
	@Resource
	private TalkService talkService;
	@Resource
	private QuestionFocusService quesionFocusService;
	
	
	private String json;//index 页面修改 等信息传递过来
	private User user;
	
	private List<Sport> sportList;//admin  查看文章集合
	private Integer totalPage;//文章集和分页
	private Integer currentPage;
	private Integer pageSize;
	
	private Integer totalPage2;//用于文章jsp 中待审核的列表分页
	private Integer currentPage2; 
	
	private Integer modalPageSize;//用于模态框 的分页
	private Integer modalCurrentPage;
	private Integer modalTotalPage;
	private  List<CRList> crlist;
	
	private Sport sport;
	private String sportCategory1;//浙江
	private String sportCategory2;//山青水绿
	
	private String sportTime;//用于sport的修改的时候 传递 时间
	private String sportCustomTag;//admin自定义的标签是的传递（tagid-->tagname  1/2/3 --> 美丽/明天/你好）
	
	private List<UserArticle> examinationLoading;//待审核的
	private List<UserArticle> examinationAdopt;//通过审核的文章
	
	private List<Question> questionList;
	private List<Object> answerList;//admin 查看question的answer 列表
	
	private List<User> userList;//admin manage-User  
	
	private SpecialScheme specialScheme;//添加特别策划
	private List<SpecialScheme> specialSchemeList;
	private SpecialSchemeUser specialSchemeUser;//用户活动报名
	
	
	
	
	//用户报名
	public String saveSpecialSchemeUser() {
		specialScheme = adminStatisticsService.getSpecialSchemeDetail(specialScheme.getId());
		specialScheme.setUserCount(specialScheme.getUserCount() + 1);
		adminStatisticsService.saveSpecialScheme(specialScheme);
		
		specialSchemeUser.setSchemeId(specialScheme);
		adminStatisticsService.saveSpecialSchemeUser(specialSchemeUser);
		
		return SUCCESS;
	}
	
	//得到活动详情
	public String getSpecialSchemeDetail() {
		specialScheme = adminStatisticsService.getSpecialSchemeDetail(specialScheme.getId());
		return SUCCESS;
	}
	
	//admin 新建保存   或者  修改保存   特别策划
	public String saveScheme() {
 
		if(specialScheme.getUserCount() == null) {
			specialScheme.setUserCount(0);
			specialScheme.setTime(new Date());
		}
			
		adminStatisticsService.saveSpecialScheme(specialScheme);
		return SUCCESS;
	}
	
	// 得到所有的活动
	public String getSpecialSchemeAll() {
		List<SpecialScheme> tempList = adminStatisticsService.getSchenmeListAll();
		pageSize = 6;
		if(currentPage == null) currentPage = 1;
		totalPage = (tempList.size() % pageSize == 0) ? (tempList.size() / pageSize) : ((tempList.size() / pageSize) + 1);
		if(totalPage == 0) totalPage = 1;
		int startRow = (currentPage - 1) * pageSize;
		
		specialSchemeList = new  LinkedList<SpecialScheme>(); 
		for	(int i = startRow, j = 0; i < tempList.size() && j < pageSize; j++, i++) {
			specialSchemeList.add(tempList.get(i));
		}
		
		return SUCCESS;
	}
	
	//admin 退出登入
	public String adminLoginOut() {
		ServletActionContext.getRequest().getSession().removeAttribute("admin");
		return SUCCESS;
	}
	
	//admin Forbidden usser
	public void adminForbiddenUser() {
		JSONObject jo =new JSONObject();
		jo = JSONObject.fromObject(json);
		String method = jo.getString("method");
		JSONArray ja = jo.getJSONArray("userId");
		 for(int i = 0 ; i < ja.size(); i++) {
			 User user = userService.getUserById(ja.getInt(i));
			 if(method.equals("disable"))
			 	user.setIsForbidden("true");
			 else user.setIsForbidden("false");
			 userService.saveUser(user);
		 }
	}
	
	//admin 管理用户
	public String adminGetUserAll() {
		List<User>  tempList = adminStatisticsService.adminGetUserAll();
		
		 pageSize = 10;
		 if(currentPage == null) currentPage = 1; 
		 int startRow = (currentPage - 1) * pageSize;
		 totalPage = (tempList.size() % pageSize == 0) ? (tempList.size() / pageSize) : ((tempList.size() / pageSize) + 1);
		 
		 userList = new LinkedList<User>();
		 for(int i = startRow, j = 0; i < tempList.size() && j < pageSize; i++, j++) {
			 userList.add(tempList.get(i));
		 }
		 
		 return SUCCESS;
	}
	
	
	//admin 删除一个question 下的评论
	public void adminDeleteQuestionAnswer() {
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(json);
		for(int i = 0; i < ja.size(); i++) {
			JSONObject jo = new JSONObject();
			jo = ja.getJSONObject(i);
			Integer id =  jo.getInt("id");   //admin 可能删除的是一级  也可能是二级  通过rank 判断
			Integer flag = jo.getInt("flag");
			if(flag == 0) {
				//因为有可能有二级评论
				Answer answer = talkService.getOneAnswerDetailById(id);
				answer.setContent("该回答已被折叠");
				talkService.saveAnswer(answer);
			}else {
				//根据id 删除二级评论
				talkService.deleteAnswerById(id);
			}
		}
	}
	
	//admin 查看一个question下的所有的回答
	public void getAnswerAll() {
		JSONObject jo = new JSONObject();
		jo = JSONObject.fromObject(json);
		Integer questionId = jo.getInt("questionId");
		
		answerList = new LinkedList<Object>();
		  
		List<Answer> templateAll = talkService.getAnswerAllToOneQuestion(questionId);//得到了一级和二级所有回复
		List<Answer> fatherList = new LinkedList<Answer>();
		List<Answer> sonList = new LinkedList<Answer>();
		
		for(Answer var:templateAll) {
			if(var.getFlag() == 0) fatherList.add(var);
			else sonList.add(var);
		}
		
		//模态框  分页
		modalPageSize = 10; //每页展示多少条父评论
		modalCurrentPage = jo.getInt("modalCurrentPage");
		//这里的分页是以有多少条父评论为基础的
		modalTotalPage = (fatherList.size() % modalPageSize == 0) ? (fatherList.size() / modalPageSize) : ((fatherList.size() / modalPageSize) + 1);
		int startRow = (modalCurrentPage - 1) * modalPageSize;
		
		List<Answer> templateAll2 = new LinkedList<Answer>();
		for(int i = startRow, j =0; j < modalPageSize && i < fatherList.size(); i++, j++) {
			templateAll2.add(fatherList.get(i));
		 }
 
		for(Answer var:templateAll2){	// 在这一页需要战士的fatherAnswer（即tempalteAll2)  找到其sonReply
			//先找出一级评论--结构-->(list(map(father,son(list))))
			
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				map.put("father", var);
				//存放二级评论
				List<Answer> sonAnswer = new LinkedList<Answer>();   
				for(Answer var2 : sonList){      // templateAll2  真正有的条数（含一二级评论的） 内容
					if(var2.getFlag() == 1 && var2.getFather_id() == var.getId()){
						sonAnswer.add(var2);
					}
				}
				map.put("son", sonAnswer);
				
				answerList.add(map);
			 
		}
 
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(answerList);
		
		JSONObject jo2  = new JSONObject();
		jo2.put("modalCurrentPage", modalCurrentPage);
		jo2.put( "modalTotalPage", modalTotalPage);
		jo2.put("answerlist", ja);
		
		try {
			sendMsg(jo2.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	//admin 删除 文章的评论
	public void adminDeleteArticleComment() {
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(json);
		for(int i = 0; i < ja.size(); i++) {
			JSONObject jo = new JSONObject();
			jo = ja.getJSONObject(i);
			Integer id =  jo.getInt("id");   //admin 可能删除的是一级  也可能是二级  通过rank 判断
			Integer rank = jo.getInt("rank");
			if(rank == 0) {
				//userService.deleteArticleCommentById(id);
				UserArticleComment ac = articleService.getUserArticleCommentById(id);
				ac.setContent("该评论已被折叠");
				articleService.saveUserArticleComment(ac);
			}else {
				//从 reply 表中删除
				userService.deleteArticleReplyById(id);
			}
		}
	}
	
	//admin  得到文章的评论
	public void getArticleCommentAll() {
		JSONObject jo = new JSONObject();
		jo = JSONObject.fromObject(json);
		Integer articleId = jo.getInt("articleId");
		
		//得到这个文章的评论
		List<UserArticleComment> comment = articleService.getUserArticleComment(articleId);
		List<UserArticleReply> reply = articleService.getUserArticleReply(articleId);
		//利用数据结构排序
		crlist=new CRList().getCRArticleList(comment, reply);
		//模态框的分页
		modalPagination(jo);
		
	}
	
	public void modalPagination(JSONObject jo) {
		//模态框的分页
		 modalPageSize = 6;
		 modalCurrentPage = jo.getInt("modalCurrentPage");
		 modalTotalPage = (crlist.size() % modalPageSize == 0) ? (crlist.size() / modalPageSize) : ((crlist.size() / modalPageSize) + 1);
		 int startRow = (modalCurrentPage - 1) * modalPageSize;
		 List<CRList> tempCRList = new LinkedList<CRList>();
		 for(int i = startRow, j =0; j < modalPageSize && i < crlist.size(); i++, j++) {
			 tempCRList.add(crlist.get(i));
		 }
		 
		 JSONArray ja = new JSONArray();
		 ja = JSONArray.fromObject(tempCRList);
		 
		 JSONObject jo2 = new JSONObject();
		 jo2.put("crList", ja);
		 jo2.put("modalCurrentPage", modalCurrentPage);
		 jo2.put("modalTotalPage", modalTotalPage);
		 
		 try {
			sendMsg(jo2.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//admin 删除sport 的选中的评论
	public void adminDeleteComment() {
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(json);
		for(int i = 0; i < ja.size(); i++) {
			JSONObject jo = new JSONObject();
			jo = ja.getJSONObject(i);
			Integer id =  jo.getInt("id");   //admin 可能删除的是一级  也可能是二级  通过rank 判断
			Integer rank = jo.getInt("rank");
			if(rank == 0) {
				SportComment sc = sportService.getSportCommentById(id);
				sc.setContent("该评论已被折叠");
				sportService.saveSportComment(sc);
			}else {
				//从 reply 表中删除
				sportService.deleteSportReply(id);
			}
		}
	}
	
	//admin 得到sport的所有的评论
	public void getSportCommentAll() {
		JSONObject jo = new JSONObject();
		jo = JSONObject.fromObject(json);
		Integer sportId = jo.getInt("sportId");
		 
		//得到相关景点的评论和回复
		 List<SportComment> comment = sportService.getSportComment(sportId);
		 List<SportReply> reply = sportService.getSportReply(sportId);
		//利用数据结构进行排序
		 crlist = new CRList().getCRList(comment, reply);
		 
		 modalPagination(jo);
	}
	
	// admin 删除一个问题(删除 -用户的关注--用户的回答--用户提问的动态--最后删除这个问题)
	public void adminDeleteQuestion() {
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(json);
		for(int i = 0; i < ja.size(); i++) {
			//得到所有的问题--用户  关注关系   delete
			List<QuestionFocus> questionFocusList = quesionFocusService.getOneQuestionFocusAll(ja.getInt(i));
			for(QuestionFocus var : questionFocusList) {
				quesionFocusService.deleteQueestionFocusById(var.getId());
			}
			//得到该问题下的所有的回答  delete
			List<Answer> answerList = talkService.getAnswerAllToOneQuestion(ja.getInt(i));
			for(Answer var : answerList) {
				talkService.deleteAnswerById(var.getId());
			}
			//删除问题
			talkService.deleteQuestion(ja.getInt(i));
			//删除用户动态（回答了问题,关注了问题,等等）
			userService.adminDeleteUpdate("提出了问题", ja.getInt(i));
			userService.adminDeleteUpdate("关注了问题", ja.getInt(i));
			userService.adminDeleteUpdate("回答了问题", ja.getInt(i));
			userService.adminDeleteUpdate("点赞了回答", ja.getInt(i));
			//删除otherTotag
			otherToTagService.delteArticleToTag(ja.getInt(i), "question");
		}
	}
	
	// admin  查看问题的详情
	public void adminGetQuestionDetail() {
		JSONObject jo = new JSONObject();
		jo = JSONObject.fromObject(json);
		Integer questionId = jo.getInt("questionId");
		Question question = talkService.getQuestionDetailById(questionId);
		jo.put("question", question);
		try {
			sendMsg(jo.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//admin 得到talk 的不同提问
	public String adminGetQuestionAll() {
	    pageSize = 10;
	    if(currentPage == null) currentPage = 1; 
		int startRow = (currentPage - 1) * pageSize;
		
		List<Question> tempList = talkService.getQuestionAllByTime();
		totalPage = (tempList.size() % pageSize == 0)?(tempList.size() / pageSize):((tempList.size() / pageSize) + 1);
		
		questionList = new LinkedList<Question>();
		for(int i = startRow, j = 0; j < pageSize && i < tempList.size(); j++, i++) {
			questionList.add(tempList.get(i));
		}
 
		return SUCCESS;	
	}
	
	
	//ａｄｍｉｎ得到article-detail
	public void adminGetArticleDetail() {
		JSONObject jo = new JSONObject();
		jo = JSONObject.fromObject(json);
		Integer articleId = jo.getInt("articleId");
		UserArticle ua = articleService.getArticleDetail(articleId);
		JSONObject json2 = new JSONObject();
		json2.put("article", ua);
		try {
			sendMsg(json2.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	//admin 通过审核
	public void adminAdoptArticle() {
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(json);
		for (int i = 0; i < ja.size(); i++) {
			UserArticle userArticle = articleService.getArticleDetail(ja.getInt(i));
			userArticle.setIsExamination("true");
			userService.saveUserArticle(userArticle);
			
			//添加用户的动态信息
			/*String content = userArticle.getContent();
			if(content.length() > 550){
				content = content.substring(0,550);
			}*/
			//未完善  若修改 则动态   ---暂时通过浏览量判断是否是第一次发表 还是修改 （则不需此动态）-----------------------------------------------------------
			if (userArticle.getGreatCount() == 1) {
				user = userService.getUserById(userArticle.getUser().getId());
				/*userService.saveUserUpdate(new UserUpdate("发表了游记", userArticle.getId(),userArticle.getTitle(), 
						new EliminateHtml().RemoveHtmlTag(content), user, null, user, userArticle.getTime()
				 ));*/
				userService.saveUserUpdate(new UserUpdate("发表了游记", userArticle.getId(),userArticle.getTitle(), 
						userArticle.getContent(), user, null, user, userArticle.getTime()
				 ));
			}
			
		}
	}
	
	//admin 删除文章
	public void adminDeleteArticle() {
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(json);
		 for (int i = 0; i < ja.size(); i++) {
			//删除文章的所有的评论
			userService.deleteArticleComment(ja.getInt(i));
			userService.deleteArticleReply(ja.getInt(i));
	 
			//删除动态(包括发表了  评论了 点赞了游记 不止一个人的动态)
			//UserArticle userArticle = articleService.getArticleDetail(ja.getInt(i));
			userService.adminDeleteUpdate("点赞了游记", ja.getInt(i));
			userService.adminDeleteUpdate("发表了游记", ja.getInt(i));
			 
			//删除OtherToTag
			otherToTagService.delteArticleToTag(ja.getInt(i), "article");
			//删除点赞信息
			articleGreatService.deleteArticleToGreat(ja.getInt(i));
			//删除文章
			userService.deletUserArticle(ja.getInt(i));
		} 
	}
	
	//admin管理   article 得到文章集合  (已经审核的和没有审核的)
	public String adminGetArticleAll() {
		pageSize = 10;
		
		List<UserArticle> examinationLoadingTemp = articleService.getExaminationLoading();
		if(currentPage2 == null) currentPage2 = 1; 
		int startRow2 = (currentPage2 - 1) * pageSize;
		totalPage2 = (examinationLoadingTemp.size() % pageSize == 0)?(examinationLoadingTemp.size() / pageSize):((examinationLoadingTemp.size() / pageSize) + 1);
		examinationLoading = new LinkedList<UserArticle>();
		for(int i = startRow2, j = 0; j < pageSize && i < examinationLoadingTemp.size(); j++, i++) {
			examinationLoading.add(examinationLoadingTemp.get(i));
		}
		
		List<UserArticle> examinationAdoptTemp = articleService.getExaminationAdopt();
		if(currentPage == null) currentPage = 1;
		int startRow = (currentPage - 1) * pageSize;
		totalPage = (examinationAdoptTemp.size() % pageSize == 0)?(examinationAdoptTemp.size() / pageSize):((examinationAdoptTemp.size() / pageSize) + 1);
		examinationAdopt = new LinkedList<UserArticle>();
		for(int i = startRow, j = 0; j < pageSize && i < examinationAdoptTemp.size(); j++, i++) {
			examinationAdopt.add(examinationAdoptTemp.get(i));
		}

		return SUCCESS;
	}
 
	
	//admin 对sport的删除
	public void adminDeleteSport() {
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(json);
		//删除comment  reply  sportWantTo otherToTag
		 for(int i = 0 ; i < ja.size(); i++) {
			//删除基本评论
			List<SportComment> sportCList = sportService.getSportComment(ja.getInt(i));
			List<SportReply> sportRList = sportService.getSportReply(ja.getInt(i));
			for(SportComment var : sportCList) {
				sportService.deleteSportComment(var.getId());
			}
			for(SportReply var : sportRList) {
				sportService.deleteSportReply(var.getId());
			}
			//删除点赞
			List<SportWantTo> sportWList = sportWantToService.getOneSportAll(ja.getInt(i));
			for(SportWantTo var : sportWList) {
				sportWantToService.deleteSportWantTo(var.getId());
			}
			//删除tag和sport的关系
			List<OtherToTag> sportToTagList = otherToTagService.getOtherToTagByOtherAll(ja.getInt(i), "sport");
			for(OtherToTag var : sportToTagList) {
				otherToTagService.deleteOtherToTag(var);
			}
			//删除景点
			sportService.deleteSport(ja.getInt(i));
			//删除用户动态
			userService.adminDeleteUpdate("点赞了景点", ja.getInt(i));
		} 
		
	}
	
	//admin  对sport 进行修改
	public String adminGetSportDetail() {
		sport = sportService.getSportDetail(sport.getId());
		
		SimpleDateFormat myfrt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		sportTime = myfrt.format(sport.getTime());
		
		StringBuffer tagName = new StringBuffer("");
		String []str = sport.getCustomTag().split("/");
		for(int i = 0; i < str.length; i++) {
			Tag tag = otherToTagService.getTagById(Integer.parseInt(str[i]));
			tagName.append("/" + tag.getTag());
		}
		sportCustomTag = tagName.substring(1);
		
		return SUCCESS;
	}
	
	//admin添加新的 sport
	public String saveUpdateSport() throws ParseException {
		Category1  category1 = new Category1(sportService.getCategory1Id(sportCategory1).getId());
		Category2  category2 = new Category2(sportService.getCategory2Id(sportCategory2).getId());
		sport.setCategory1(category1);
		sport.setCategory2(category2);
 	
		if(sport.getId() == null) {
			sport.setTime(new Date());
			sport.setCommentCount(0);
			sport.setWantCount(0);
			sport.setScore(0.0);
			sport.setPageViewCount(0);
		}else {  //说明是修改 
			SimpleDateFormat myFrt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			 sport.setTime(myFrt.parse(sportTime));
		}
		
		
		//设置自定义的标签
		
		String []str = sport.getCustomTag().trim().replaceAll("\\s+", "").split("/");
		List<Tag> taglist = new LinkedList<Tag>(); //存放sport的tag 用于后续的otherToTag的互相关系的保存
		StringBuffer tag2 = new StringBuffer();
		
		Set<String> tempTagName = new HashSet<String>();
		
		for(int i = 0; i < str.length; i++) {
			if(str[i].length() == 0) continue;
			if(tempTagName.contains(str[i])) continue;
			tempTagName.add(str[i]);
			List<Tag> tempTag = new LinkedList<Tag>(); 
			tempTag = otherToTagService.getTagIdByName(str[i]); //检查该标签是否存在
			if (tempTag.size() == 0) {
				Tag tag = new Tag(str[i], 0);
				otherToTagService.saveTag(tag);//保存一个本来没有新的tag
				tempTag.add(tag);//后面加入到taglist中（taglist用于保存关系）
			} else {
				//对标签的热门程度+1（热门）
				tempTag.get(0).setTagCount(tempTag.get(0).getTagCount() + 1);
				otherToTagService.saveTag(tempTag.get(0));
			}
			taglist.add(tempTag.get(0));
			tag2.append("/" + tempTag.get(0).getId());
		}
		sport.setCustomTag(tag2.substring(1));
		
		//判断是不是修改  还是第一次保存
		boolean isUpdate = (sport.getId() == null) ? false : true;
		
		sportService.saveSport(sport);
		
		//进行tag he sport de 关联   （需要检查该关系是否存在了  因为有 修改这个操作  ，文章可能是修改）
		//如果是修改的话  需要查看sport-tag 关系是不是需要删除  或者新增
		if(isUpdate) {
			List<OtherToTag> tagRelationAll ;
			//得到本来已有的关系
			tagRelationAll = otherToTagService.getOtherToTagByOtherAll(sport.getId(), "sport");
			for(OtherToTag var1 : tagRelationAll){
				int flag = 0;
				for(Tag  var2 : taglist){//taglist  是现在的sport的标签
					if(var1.getTag().getTag().equals(var2.getTag())){ //说明关系还需保留
						flag = 1; break;
					}
				}
				if(flag == 0){//这个关系需要删除(本来有，跟新过后无)
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
				if(flag == 0){ //需要新加这个关系(本来无 ，现在需要新增)
					otherToTagService.saveOtherToTag(new OtherToTag(sport.getId(), var2, "sport"));
				}
			}
		}else { //直接保存关系就可以
			Set<String> temp = new HashSet<String>();
			for (Tag var2 : taglist) {
				if (temp.contains(var2.getTag())) continue;
				temp.add(var2.getTag());
				otherToTagService.saveOtherToTag(new OtherToTag(sport.getId(), var2, "sport"));
			}
		}
	  
		return SUCCESS;
	}
	
	
	//admin 得到所有的乡村 信息展示列表
	public String adminGetSportAll() {
		pageSize = 10;
		if(currentPage == null) currentPage = 1; 
		int startRow = (currentPage - 1) * pageSize;
		
		List<Sport> tempList = sportService.getSportAllByTime();
		totalPage = (tempList.size() % pageSize == 0)?(tempList.size() / pageSize):((tempList.size() / pageSize) + 1);
		
		sportList = new LinkedList<Sport>();
		for(int i = startRow, j = 0; j < pageSize && i < tempList.size(); j++, i++) {
			sportList.add(tempList.get(i));
		}
 
		return SUCCESS;
	}
	
	
	//得到大类别的占比报表
	public void getPageViewPie() {
		Double countAll = 0.0;
		List<Sport> sportList = sportService.getSportAllOrderBySocre();
		for(Sport var : sportList) {
			countAll +=var.getScore();
		}

		Double category[] = {0.0,0.0,0.0,0.0,0.0};//存放类别的占比量    
		for(Sport var : sportList) {
			if(var.getCategory2().getName().equals("民族风情")) {
				category[0] += var.getScore();
			}else if(var.getCategory2().getName().equals("人文历史")) {
				category[1] += var.getScore();
			}else if(var.getCategory2().getName().equals("田园休闲")) {
				category[2] += var.getScore();
			}else if(var.getCategory2().getName().equals("健康生态")) {
				category[3] += var.getScore();
			}else if(var.getCategory2().getName().equals("山青水绿")) {
				//category[4] += var.getScore();
				category[4] = 100.0;
			}
		}
		JSONArray ja = new JSONArray();
		//将大类 存储ajax
		for(int i = 0; i < 5; i++) {
			JSONObject jo = new JSONObject();
			if(i == 0) {
				jo.put("name", "民族风情");
			}else if(i == 1) {
				jo.put("name", "人文历史");
			}else if(i == 2) {
				jo.put("name", "田园休闲");
			}else if(i == 3) {
				jo.put("name", "健康生态");
			}else if(i == 4) {
			}
			jo.put("value", category[i]);
			ja.add(jo);
		}
		
		//选择前30个景点  其他的访问量少的  用其他概括
		Double temp = 0.0;
		int i;
		for(i = 0; i < 30 && i < sportList.size(); i++) {
			temp += sportList.get(i).getScore();
			JSONObject jo = new JSONObject();
			jo.put("name", sportList.get(i).getName());
			jo.put("value", sportList.get(i).getScore());
			ja.add(jo);
		}
		if(i != sportList.size()) {
			JSONObject jo = new JSONObject();
			jo.put("name",  "其他");
			jo.put("value", countAll-temp);
			ja.add(ja);
		}
		try {
			sendMsg(ja.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	//得到字符云
	public void getTagCloud() {
		List<Tag> tagList = otherToTagService.getTagAllDesc();
		JSONArray ja = new JSONArray();
		//得到最高的50个关键词搜索量
		for(int i = 0; i < 50 && i <tagList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("tagName", tagList.get(i).getTag());
			jo.put("value", tagList.get(i).getTagCount());
			ja.add(jo);
		}
		try {
			sendMsg(ja.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 得到活动用户 报表（分析报名用户的年龄和城分布情况）
	public void getSchemeUser() {
		List<SpecialSchemeUser> schemeUser = adminStatisticsService.getSchemeUserAll();//得到用户的报名表
		JSONArray ja = new JSONArray();//存放一个用户的情况
		JSONArray ja2 = new JSONArray();//存放所有的用户
		ArrayList<String> provinceArray = new ArrayList<String>();
		for(SpecialSchemeUser var : schemeUser) {
			//过滤得到的名字
			String province = "";
			if	(var.getAddress().contains("省")) {
				province = var.getAddress().substring(0, var.getAddress().indexOf('省'));
			}else {
				province = var.getAddress().substring(0, var.getAddress().indexOf('市'));
			}
			
			String sex = var.getSex();
			Integer age = var.getAge();
			JSONObject jo = new JSONObject(); 
			jo.put("sex", sex);
			jo.put("age", age);
			jo.put("province", province);
			if (!provinceArray.contains(province)) {
				provinceArray.add(province);
			}
			ja2.add(jo);
		}
		
		//下面的是假设的数据
		String []provinceName = {"北京","天津","上海","重庆","河北","山西","内蒙古","辽宁","吉林","黑龙江","江苏","浙江","安徽","福建","江西","山东","青海","宁夏","新疆","香港","澳门","台湾"};

		for(int i = 0; i < 200; i++) {
			JSONObject jo = new JSONObject();
			String province = "";
			if (i < 10) {
				jo.put("province", "浙江");
				province = "浙江";
			}else if(i > 11 && i < 20) {
				jo.put("province", "上海");
				province = "上海";
			}else if(i > 21 && i < 30) {
				jo.put("province", "广东");
				province = "广东";
			}else if(i > 31 && i < 40) {
				jo.put("province", "江苏");
				province = "江苏";
			} {
				int random1 = new Random().nextInt(provinceName.length);
				province = provinceName[random1];
				jo.put("province", province);
			}
			
			
			if(i < 60) {
				jo.put("sex", "男");
				jo.put("age", new Random().nextInt(32) + 18);
			}
			else {
				jo.put("sex", "女");
				jo.put("age", new Random().nextInt(32) + 25);
			}
			
			
			if (!provinceArray.contains(province)) {
				provinceArray.add(province);
			}
			ja2.add(jo);
		}
		//以上为假设的数据
		
		JSONArray ja3 = new JSONArray();
		ja3 = JSONArray.fromObject(provinceArray);
		ja.add(ja2);
		ja.add(ja3);
		
		try {
			sendMsg(ja.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	//得到每日访问量
	public void getPageViewAll() {
		List<PageView> pageViewList = adminStatisticsService.getAllOrderByTime();
		JSONArray ja = new JSONArray();
		//以下为假设的数据
		for(int i = 1; i <= 30; i++) {
			JSONObject jo = new JSONObject();
			jo.put("n", 2017);
			jo.put("y", 7);   //前端需要减一  月份
			jo.put("r", i);
			jo.put("pageViewCount", (Math.random()*30) - 0);
			ja.add(jo);
		}
		for(int i = 1; i <= 17; i++) {
			JSONObject jo = new JSONObject();
			jo.put("n", 2017);
			jo.put("y", 8);
			jo.put("r", i);
			jo.put("pageViewCount", (Math.random()*30) - 0);
			ja.add(jo);
		}
		//以上为假设的数据
		
		for(int i = pageViewList.size() - 1; i >= 0; i--) {
			JSONObject jo = new JSONObject();
			SimpleDateFormat myDate = new SimpleDateFormat("yyyyMMddhhmm");
			jo.put("n", myDate.format(pageViewList.get(i).getTime()).substring(0, 4));
			jo.put("y", myDate.format(pageViewList.get(i).getTime()).substring(4, 6));
			jo.put("r", myDate.format(pageViewList.get(i).getTime()).substring(6, 8));
			jo.put("pageViewCount", pageViewList.get(i).getPageViewCount());
			ja.add(jo);
		}
		try {
			sendMsg(ja.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//admin login-out
	public void cancealAdminLogin() {
		ServletActionContext.getRequest().getSession().removeAttribute("admin");
	}
	
	//amdin detail update
	public void adminDetailUpdate() throws ParseException {
		JSONObject jo = new JSONObject();
		jo = JSONObject.fromObject(json);
		String loginTime = jo.getString("loginTime");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		user.setRegisterDate(sdf.parse(loginTime));
		user.setBackground(jo.getString("trueName"));
		userService.saveUser(user);
		//同时将session中的内容更改
		//ServletActionContext.getRequest().getSession().removeAttribute("admin");
		ServletActionContext.getRequest().getSession().setAttribute("admin", user.getUsername());
	}
	
	
	//admin的得到登入信息等    和今日 信息汇总表
	public void getAdminDetail() {
		String args;
		JSONObject jo = new JSONObject();
		String name = (String)ServletActionContext.getRequest().getSession().getAttribute("admin");
		if(name == null) {
			args = "{'sta':'unLoginValid'}";
			jo = JSONObject.fromObject(args);
		}else {
			User admin = userService.getUserByName(name);
			//得到今日基本信息
			List<PageView> pageViewList = adminStatisticsService.getAllOrderByTime();
			
			SimpleDateFormat myFmt=new SimpleDateFormat("yyyyMMdd");
			PageView pageView = pageViewList.get(0);
			Date date = pageView.getTime();
			String time = myFmt.format(date);
			String now = myFmt.format(new Date());
			
			SimpleDateFormat myFmt2=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String loginTime = myFmt2.format(admin.getRegisterDate());
			//有没有今日的汇总
			if(time.equals(now)) {
				jo.put("statistics", pageView);
				jo.put("admin", admin);
				jo.put("loginTime", loginTime);
			}else {
				pageView = new PageView(new Date(), 0, 0, 0, 0, 0, 0, 0);
				jo.put("statistics", pageView);
				jo.put("admin", admin);
				jo.put("loginTime", loginTime);
			}
			
		}
		
		try {
			sendMsg(jo.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//统计每天的新增信息
	public void countAdd(String str) {
		List<PageView> list = adminStatisticsService.getAllOrderByTime();
		if(list.size() != 0) {
			SimpleDateFormat myFmt=new SimpleDateFormat("yyyyMMdd");
			PageView pageView = list.get(0);
			Date date = pageView.getTime();
			String time = myFmt.format(date);
			String now = myFmt.format(new Date());
			if(time.equals(now)) {
				if(str.equals("login")) {
					pageView.setLoginCount(pageView.getLoginCount() + 1);
				}else if(str.equals("article")) {
					pageView.setArticleCount(pageView.getArticleCount() + 1);
				}else if(str.equals("pageView")) {
					pageView.setPageViewCount(pageView.getPageViewCount() + 1);
				}else if(str.equals("comment")) {
					pageView.setCommentCount(pageView.getCommentCount() + 1);
				}else if(str.equals("question")) {
					pageView.setQuestionCount(pageView.getQuestionCount() + 1);
				}else if(str.equals("answer")) {
					pageView.setAnswerCount(pageView.getAnswerCount() + 1);
				}else if(str.equals("register")) {
					pageView.setRegisterCount(pageView.getRegisterCount() + 1);
				}
				
				adminStatisticsService.savePageView(pageView);
				
			}else {
				//代表新的一天
				PageView pageView2 = new PageView();
				if(str.equals("login")) {
					pageView2 = new PageView(new Date(), 1, 0, 0, 0, 0, 0, 0);
				}else if(str.equals("article")) {
					pageView2 = new PageView(new Date(), 0, 0, 1, 0, 0, 0, 0);
				}else if(str.equals("pageView")) {
					pageView2 = new PageView(new Date(), 0, 1, 0, 0, 0, 0, 0);
				}else if(str.equals("comment")) {
					pageView2 = new PageView(new Date(), 0, 0, 0, 1, 0, 0, 0);
				}else if(str.equals("question")) {
					pageView2 = new PageView(new Date(), 0, 0, 0, 0, 1, 0, 0);
				}else if(str.equals("answer")) {
					pageView2 = new PageView(new Date(), 0, 0, 0, 0, 0, 1, 0);
				}else if(str.equals("register")) {
					pageView2 = new PageView(new Date(), 0, 0, 0, 0, 0, 0, 1);
				}
				adminStatisticsService.savePageView(pageView2);
			}
			 
			
		}else { //当没有数据的时候
			PageView pageView2 = new PageView();
			if(str.equals("login")) {
				pageView2 = new PageView(new Date(), 1, 0, 0, 0, 0, 0, 0);
			}else if(str.equals("article")) {
				pageView2 = new PageView(new Date(), 0, 0, 1, 0, 0, 0, 0);
			}else if(str.equals("pageView")) {
				pageView2 = new PageView(new Date(), 0, 1, 0, 0, 0, 0, 0);
			}else if(str.equals("comment")) {
				pageView2 = new PageView(new Date(), 0, 0, 0, 1, 0, 0, 0);
			}else if(str.equals("question")) {
				pageView2 = new PageView(new Date(), 0, 0, 0, 0, 1, 0, 0);
			}else if(str.equals("answer")) {
				pageView2 = new PageView(new Date(), 0, 0, 0, 0, 0, 1, 0);
			}else if(str.equals("register")) {
				pageView2 = new PageView(new Date(), 0, 0, 0, 0, 0, 0, 1);
			}
			adminStatisticsService.savePageView(pageView2);
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
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<Sport> getSportList() {
		return sportList;
	}
	public void setSportList(List<Sport> sportList) {
		this.sportList = sportList;
	}
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Sport getSport() {
		return sport;
	}
	public void setSport(Sport sport) {
		this.sport = sport;
	}
	public String getSportCategory1() {
		return sportCategory1;
	}
	public void setSportCategory1(String sportCategory1) {
		this.sportCategory1 = sportCategory1;
	}
	public String getSportCategory2() {
		return sportCategory2;
	}
	public void setSportCategory2(String sportCategory2) {
		this.sportCategory2 = sportCategory2;
	}
	public String getSportTime() {
		return sportTime;
	}
	public void setSportTime(String sportTime) {
		this.sportTime = sportTime;
	}
	public String getSportCustomTag() {
		return sportCustomTag;
	}
	public void setSportCustomTag(String sportCustomTag) {
		this.sportCustomTag = sportCustomTag;
	}

	public List<UserArticle> getExaminationLoading() {
		return examinationLoading;
	}

	public void setExaminationLoading(List<UserArticle> examinationLoading) {
		this.examinationLoading = examinationLoading;
	}

	public List<UserArticle> getExaminationAdopt() {
		return examinationAdopt;
	}

	public void setExaminationAdopt(List<UserArticle> examinationAdopt) {
		this.examinationAdopt = examinationAdopt;
	}
	public Integer getTotalPage2() {
		return totalPage2;
	}

	public void setTotalPage2(Integer totalPage2) {
		this.totalPage2 = totalPage2;
	}

	public Integer getCurrentPage2() {
		return currentPage2;
	}

	public void setCurrentPage2(Integer currentPage2) {
		this.currentPage2 = currentPage2;
	}


	public List<Question> getQuestionList() {
		return questionList;
	}


	public void setQuestionList(List<Question> questionList) {
		this.questionList = questionList;
	}

	public Integer getModalPageSize() {
		return modalPageSize;
	}

	public void setModalPageSize(Integer modalPageSize) {
		this.modalPageSize = modalPageSize;
	}

	public Integer getModalCurrentPage() {
		return modalCurrentPage;
	}

	public void setModalCurrentPage(Integer modalCurrentPage) {
		this.modalCurrentPage = modalCurrentPage;
	}

	public Integer getModalTotalPage() {
		return modalTotalPage;
	}

	public void setModalTotalPage(Integer modalTotalPage) {
		this.modalTotalPage = modalTotalPage;
	}

	public List<CRList> getCrlist() {
		return crlist;
	}

	public void setCrlist(List<CRList> crlist) {
		this.crlist = crlist;
	}


	public List<User> getUserList() {
		return userList;
	}
 
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}


	public SpecialScheme getSpecialScheme() {
		return specialScheme;
	}


	public void setSpecialScheme(SpecialScheme specialScheme) {
		this.specialScheme = specialScheme;
	}

	public List<SpecialScheme> getSpecialSchemeList() {
		return specialSchemeList;
	}

	public void setSpecialSchemeList(List<SpecialScheme> specialSchemeList) {
		this.specialSchemeList = specialSchemeList;
	}

	public SpecialSchemeUser getSpecialSchemeUser() {
		return specialSchemeUser;
	}

	public void setSpecialSchemeUser(SpecialSchemeUser specialSchemeUser) {
		this.specialSchemeUser = specialSchemeUser;
	}
 
}
