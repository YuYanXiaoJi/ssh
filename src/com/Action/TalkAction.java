package com.Action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.Algorithm.EliminateHtml;
import com.Entity.Answer;
import com.Entity.AnswerGreat;
import com.Entity.CacheTag;
import com.Entity.OtherToTag;
import com.Entity.Question;
import com.Entity.QuestionFocus;
import com.Entity.Tag;
import com.Entity.User;
import com.Entity.UserUpdate;
import com.Service.CacheTagService;
import com.Service.OtherToTagService;
import com.Service.QuestionFocusService;
import com.Service.TalkService;
import com.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@Controller("talkAction")
@Scope("prototype")

public class TalkAction extends ActionSupport {
	
	@Resource
	private TalkService talkService;
	@Resource
	private UserService userService;
	@Resource
	private OtherToTagService otherToTagService;
	@Resource
	private QuestionFocusService questionFocusService;
	@Resource
	private CacheTagAction cacheTagAction;
	@Resource
	private CacheTagService cacheTagService;
	@Resource
	private AdminStatisticsAction adminAtatisticsAction; 
	
	private Question question;
	private String flag;//分类情况
	private List<Object> list;//首页问题列表展示
	private List<String> tagList;//一个提问中的标签列表
	private Answer answer;
	private List<Object> answerList;//回答列表（存放一级评论，二级评论）
	private List<Answer> secondeAnswerList;
	private String json;//接受点赞信息
	private Integer category;//分别代表数字 1 （是为你推荐）2（是近期最热）3（是最新问题）
	private List<Tag> hotTag;//用于热门标签展示 
	private List<Answer> bestAnswerUser;//优秀回答者
	private List<Question> questionList;//每人回答的问题
	
	private List<Question> relateQuestion;//一个问题的相关的类似问题推荐
	
	private Integer pageSize;//用于分页
	private Integer totalPage;
	private Integer currentPage;
	
	private boolean isShowAll;
	
	
	private String questionFocusImg;//对于关注的问题
	private String questionFocusWord;
 
	@SuppressWarnings("rawtypes")
	static private Set QuestionId;//存放一个session之内的浏览的问题浏览数量
	
	private String isShowAnswerAll;//主要用在在用户界面的时候  如果点开  就只展示用户的这一个回答  
	private String userUpdateName;//用来确定展开的是谁的回答
	
	private String questionCategory[];//用于在修改的时候传回标签
	
	//当需要修改一个问题的时候
	public String reviseQuestion(){
		question = talkService.getQuestionDetailById(question.getId());
		//查找出  这个question 选择了哪些的标签
		question.setTag(question.getTag().trim().replaceAll("\\s+", ""));
		String []tempTag  = question.getTag().split("/");
		questionCategory = new String[3];
		StringBuffer tagCustom = new StringBuffer();
		for(int i = 0; i < tempTag.length; i++){
			if(tempTag[i].length() == 0) continue;
			Tag tag = otherToTagService.getTagById(Integer.parseInt(tempTag[i]));	
			if (i >= 2 ){
				tagCustom.append(tag.getTag() + "/");
			} else {
				questionCategory[i] = tag.getTag();
			}
		}
		if (tempTag.length > 2) {
			questionCategory[2] = tagCustom.substring(0, tagCustom.length()-1); 
		}
		return SUCCESS;
	}
	
	//点赞ajax操作
	public void addOrSub(){
		JSONObject jsonObject = new JSONObject();
		jsonObject = JSONObject.fromObject(json);
		String answer_id = jsonObject.getInt("answer_id")+"";
		String method = jsonObject.getString("method");
 		
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name != null){
 
		User user = userService.getUserByName(name);
		//User user = userService.getUserByName("aa");
		
		Answer answer = new Answer();
		answer = talkService.getOneFatherAnswer(Integer.parseInt(answer_id));
		
		if(method.equals("加")){
 
			AnswerGreat answerGreat = new AnswerGreat();
			answerGreat.setAnswer(answer);
			answerGreat.setUser(user);
			
			talkService.saveAnswerGreat(answerGreat);
			
			//这个回答的点赞量加一
			answer.setGreatCount(answer.getGreatCount() + 1);
			talkService.saveAnswer(answer);
			
			//记录用户的动态消息
			//得到这个回答的问题的标题 （这里的ID不是回答表中的ID号而是这个问题的ID号）
			Question q = talkService.getQuestionDetailById(answer.getQuestion_id());
			//而content是回答的content
			String content = answer.getContent();
			/*if(content.length() > 550){
				content = content.substring(0,550);
			}*/
			UserUpdate userUpdate = new UserUpdate("点赞了回答", q.getId(), q.getTitle(), content, 
					//author 找到这个回答者 
					answer.getUser(), answer.getGreatCount(), user, new Date());
			userService.saveUserUpdate(userUpdate);
			
		} else {
			talkService.deleteAnswerGreat(user.getId(),Integer.parseInt(answer_id));
			
			//文章的点赞量减一
			if(answer.getGreatCount() > 0){
				answer.setGreatCount(answer.getGreatCount() - 1);
				talkService.saveAnswer(answer);
			}
			//删除用户的动态消息
			//得到这个回答的问题的标题 （这里的ID不是回答表中的ID号而是这个问题的ID号）
			Question q = talkService.getQuestionDetailById(answer.getQuestion_id());
			userService.deleteUserUpdate("点赞了回答", q.getId(), user.getId());
		}
		
		//传回新的点赞量
		String greatCount = answer.getGreatCount().toString();
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
	
	//得到对于一个father而言的所有的son回复
	public String getSecondeAnswerAll(){
		//得到father
		answer = talkService.getOneFatherAnswer(answer.getId());
		//得到所有的二级回复
		secondeAnswerList = talkService.getSonAllOfFather(answer.getId());
		return SUCCESS;
	}
	
	//ajax 保存一级二级回复
	public  void ajaxSaveReply() {
		JSONObject jo = new JSONObject();
		jo = JSONObject.fromObject(json);
		answer = new Answer();
		answer.setTime(new Date());
		answer.setGreatCount(0);
		User user = userService.getUserByName(ServletActionContext.getRequest().getSession().getAttribute("name").toString());
		answer.setUser(user);
		
		answer.setContent(jo.getString("content"));
		answer.setFather_id(jo.getInt("father_id"));
		answer.setQuestion_id(jo.getInt("question_id"));
		answer.setFlag(jo.getInt("flag"));
		
		talkService.saveAnswer(answer);
		
		if (answer.getFlag() == 0) {
			JSONObject jo2 = new JSONObject();
			jo2.put("father_id", answer.getId());
			try {
				sendMsg(jo2.toString());
			} catch (IOException e) { 
				e.printStackTrace();
			}
			
			//保存用户的回答的动态    //得到这个回答的question  作为动态表中的otherID
			Question q = talkService.getQuestionDetailById(answer.getQuestion_id());
			String content = answer.getContent();
			/*if(content.length() > 550){
				content = content.substring(0,550);
			}*/
			UserUpdate userUpdate = new UserUpdate("回答了问题",
					//other_id 为该问题的ID
					answer.getQuestion_id(), q.getTitle(), 
					//得到回答的内容  author 为自己
					content,
					//new EliminateHtml().RemoveHtmlTag(content),
					 user, answer.getGreatCount(),
					 user , new Date()
					);
			userService.saveUserUpdate(userUpdate);
			
			//如果是一级回答  更新question的**个回答个数
			q.setReplyCount(q.getReplyCount() + 1);
			talkService.saveQuestion(q);
			
			//统计
			adminAtatisticsAction.countAdd("answer"); 
		}
  
		
	}
 
	//得到一个问题的详情
	public String getQuestionDetail(){
		
		question = talkService.getQuestionDetailById(question.getId());
		//得到tag
		String tag_id[] = question.getTag().split("/");
		tagList = new LinkedList<String>();
		for(int i = 0; i < tag_id.length; i++){
			tagList.add(otherToTagService.getTagById(Integer.parseInt(tag_id[i])).getTag());
		}
		
		//得到all回答 ( 可能需要筛选  有时  只需要一个)
		 getAnswerAll();
 
		 //得到相关浏览(相关的question) 每个标签两条相关
		 relateQuestion = new LinkedList<Question>();
		 ArrayList<Integer>  arrayQuestion = new ArrayList<Integer>();
		 arrayQuestion.add(question.getId());
		 for(int i = 0; i < tag_id.length; i++) {
			 //得到含有该标签的other
			 List<OtherToTag> questionToTag = otherToTagService.getOtherForRecommend("question", Integer.parseInt(tag_id[i]));
			 for(int j = 0, z = 0; j < questionToTag.size() && z < 2; z++, j++) {
				 //每个推荐2条
				 int questionId = questionToTag.get(j).getOtherId();
				 if(!arrayQuestion.contains(questionId)) {
					 relateQuestion.add(talkService.getQuestionDetailById(questionId));
					 arrayQuestion.add(questionId);
				 }
				 
			 }
		 }
		 
		 
		 
		//查看时候已经关注了该问题
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name != null){

		User user = userService.getUserByName(name);
		 
		List<QuestionFocus> questionFocusList = questionFocusService.search(user.getId(), question.getId());
		if(questionFocusList.size() == 0){
			questionFocusImg = "../image/focusNo.png";
			questionFocusWord = "关注问题";
		}else{
			questionFocusImg = "../image/focus.png";
			questionFocusWord = "已关注";
		}
		
		}else {
			questionFocusImg = "../image/focusNo.png";
			questionFocusWord = "关注问题";
		}
		
		//根据session是否失效判断  是否重新计数
		 if(ServletActionContext.getRequest().getSession().getAttribute("QuestionId") != null){
			 //浏览量
			 if(QuestionId != null && !QuestionId.contains(question.getId())){
				 question.setPageView(question.getPageView() + 1);  
				 talkService.saveQuestion(question);
			 }
		 }
		 
		//设置cacheTag
		if(name != null){
			cacheTagAction.saveCacheTag(question.getTag());
		}
		
		//统计
	    adminAtatisticsAction.countAdd("pageView"); 
 
		return SUCCESS;
	}
	
	//ajax 得到更多的回答
	public  void ajaxGetMoreAnswer() {
		JSONObject jo = new JSONObject();
		jo = JSONObject.fromObject(json);
		int totalCount = jo.getInt("totalCount");//前端已显示的条数
		int addCount = jo.getInt("addCount");//每次需要新增的条数
		int question_id = jo.getInt("question_id");
		
		List<Answer> templateAll  = talkService.getAnswerAllToOneQuestion(question_id);//得到了一级和二级所有回复
		//函数内容参数增加条数，endRow，startRow，listAll
		sortFatherAndSon(addCount, totalCount + addCount - 1, totalCount, templateAll);
		
		JSONArray ja = new JSONArray();
		ja = JSONArray.fromObject(answerList);
		/*for (int i = 0; i < answerList.size(); i++) {
			System.out.println(((Answer)((Map)answerList.get(i)).get("father")).getContent());
		}*/
		JSONObject jo2 = new JSONObject();
		jo2.put("list", ja);
		jo2.put("isShowAll", isShowAll);
		try {
			sendMsg(jo2.toString());
		} catch (IOException e) { 
			e.printStackTrace();
		}
		
	}
 
	//第一次得到所有的回答all 
	@SuppressWarnings("rawtypes")
	public void getAnswerAll(){
		List<Answer> templateAll ;
		
		pageSize = 3; //设置加载的第一次加载的页数
		currentPage = 1; 
		int startRow = (currentPage - 1) * pageSize;

		//主要区别 是从  用户主页点击DAO这个问题  还是从   问题列表  点击到问题的详情（需不需要展示所有）
		if(isShowAnswerAll != null && isShowAnswerAll.equals("false")){
			User u = userService.getUserByName(userUpdateName);//在userAction 中的 去一个**用户的主页的时候  已设置了  其名字
			templateAll = talkService.getOneAnswerToOneQuestion(u.getId(), question.getId());
		}else{
			templateAll = talkService.getAnswerAllToOneQuestion(question.getId());//得到了一级和二级所有回复
		}
		
		//进行对回答的排序   add -> answerList
		sortFatherAndSon(pageSize, startRow + pageSize, startRow, templateAll);
 
		//记录这个问题的浏览数
		HttpSession session = ServletActionContext.getRequest().getSession();
		if(session.getAttribute("QuestionId") == null){
			session.setAttribute("QuestionId", true);
			QuestionId = new HashSet();
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void sortFatherAndSon(int addCount,int endRow ,int startRow, List<Answer> templateAll) {
		List<Answer> fatherAnswer = new LinkedList();
		List<Answer> sonAnswer = new LinkedList();
		answerList = new LinkedList<Object>(); 
		
		for (Answer var2 : templateAll) {
			if(var2.getFlag() == 0) fatherAnswer.add(var2);
			else sonAnswer.add(var2);
		}
		
		isShowAll = (endRow  >= fatherAnswer.size() ) ? true : false;
		
		for (int i = startRow, j = 0; i < fatherAnswer.size() && j < addCount; i++, j++ ) {
			Map<String, Object> map = new LinkedHashMap<String, Object>();
			map.put("father", fatherAnswer.get(i));
			List<Answer> sonAnswerToOneFather = new LinkedList<Answer>();
			for (Answer var3 : sonAnswer) {
				 if(var3.getFather_id() == fatherAnswer.get(i).getId()){
					 sonAnswerToOneFather.add(var3);
					}
				 }
				 map.put("son", sonAnswerToOneFather);
					//对每一个回答判断之前是否点过赞(前端显示不同图片)
				 map.put("img", checkIsGreat(fatherAnswer.get(i).getId()));
				 answerList.add(map);
		 }
	}
 
	//判断是否点过赞(用户，问题id)
	public String checkIsGreat(Integer answer_id){
		List<AnswerGreat> list = new LinkedList<AnswerGreat>();
		String name =  (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name != null && !name.equals("")){
			User user = userService.getUserByName(name);
		
			list = talkService.checkIsGreat(user.getId(), answer_id);
			if(list.size() == 0){
				return "../image/00.jpg";
			}
			else return "../image/11.jpg";
		}
		else return "../image/00.jpg";
	}

	//执行显示分类问题   得到所有的问题
	public String getQuestionAll(){
		
		list = new LinkedList<Object>();
		List<Question> temp = new LinkedList<Question>();
		//防止重复推荐
		ArrayList<Integer> talkList = new ArrayList<Integer>();
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
 
		if(category == 1) {
			if(name != null) {
				//为你推荐   得到用户的cacheTag
				User user = userService.getUserByName(name);	
				List<CacheTag> cacheTagList = cacheTagService.getUserCacheTagList(user.getId());
				for(CacheTag var : cacheTagList) {
					List<OtherToTag> questionToTag = otherToTagService.getOtherForRecommend("question", var.getTagId());
					for(OtherToTag  var2 : questionToTag) {
						if(!talkList.contains(var2.getOtherId())) {
							Question quesiton = talkService.getQuestionDetailById(var2.getOtherId());
							temp.add(quesiton);
							talkList.add(quesiton.getId());
						}
					}
				}
				List<Question> temp2 = talkService.getQuestionOrderByFocus();
				for(Question var3 : temp2) {
					if(!talkList.contains(var3.getId())) {
						temp.add(var3);
					}
				}		
			} else {
				temp = talkService.getQuestionOrderByFocus();
			}
 
		} else if(category == 2) {//近期最热
			temp = talkService.getQuestionElite();
		} else if(category == 3) {//最新问题
			//时间最新  并且没有回答的一系列问题
		   temp = talkService.getQuestionAllByTime();		 
		}
		
		//得到每一个问题的标签和这个问题的最高票回答
	    getTag(temp);
		
 
		return 	SUCCESS;
	}
	
	
	
	//得到推荐1,2,3类回答（问题首页）   得到每一项的tag  结构：(list(map("answer","question","tag")))
	public void getTag(List<Question> temp){
 	
		for(Question item:temp){
			List<String>  tag = new LinkedList<String>();//用于存放每一个问题中的tag标签
			//得到该问题的最高票的回答
			List<Answer> answer = new LinkedList<Answer>();
			answer = talkService.getAnswerExcludeSon(item.getId());
			
			String tag_id[] =  item.getTag().split("/");
			for(int i = 0; i < tag_id.length; i++){
				tag.add(otherToTagService.getTagById(Integer.parseInt(tag_id[i])).getTag());
			}
			Map<String, Object> map = new LinkedHashMap<String, Object>();	
			
			if(category != 3 && answer.size() != 0 ){
				Answer best = new Answer();
				best = answer.get(0);
				//去掉回答中的html 
				best.setContent(new EliminateHtml().RemoveHtmlTag(best.getContent()));
				map.put("answer", best);
				map.put("question", item);
				//得到这个高票回答的回复数
				List<Answer> l = new LinkedList<Answer>();
				l = talkService.getSonAllOfFather(best.getId());
				map.put("commentCount", l.size());
				map.put("tag", tag);
				list.add(map);
			} else if(category == 3) {//得到没回答的 问题 （最新问题）   && answer.size() == 0
				item.setContent(new EliminateHtml().RemoveHtmlTag(item.getContent()));
				//为了前台的jsp 可以用同一个  c:forearch
				map.put("answer", item);//为了显示这个问题的summary
				map.put("question", item);//都是这个问题
				map.put("commentCount", item.getPageView());//实为浏览量
				map.put("tag", tag);
				list.add(map);
			}	
		}

		
		List<Object> tempList = new LinkedList<Object>();
		tempList = list;
		list = new LinkedList<Object>(); 
		//进行分页
		pageSize = 6;
		if(currentPage == null) currentPage = 1;
		totalPage = (tempList.size() % pageSize == 0) ? (tempList.size() / pageSize) : ((tempList.size() / pageSize) + 1);
		if(totalPage == 0) totalPage = 1;
		int startRow = (currentPage - 1) * pageSize;
		for(int i = startRow, j =0; j < pageSize && i < tempList.size(); i++, j++) {
			list.add(tempList.get(i));
		}
		
		
		 //得到15个热门标签
		 getHotTagTop();
		 //得到优秀回答用户
		 getBestAnswerUserTop();
  
	}
	
	public void getBestAnswerUserTop(){
		List<Answer> temp ;
		//得到赞最多而且（保证用户不重复）
		Set<Integer> user_id = new HashSet<Integer>();
		temp = talkService.getBestAnswerTop();
		bestAnswerUser = new LinkedList<Answer>();
		for(int i = 0; i < 7 && i < temp.size(); i++){
			if(!user_id.contains(temp.get(i).getUser().getId())){
				//对于HTML标签的处理
				temp.get(i).setContent(new EliminateHtml().RemoveHtmlTag(temp.get(i).getContent()));
				bestAnswerUser.add(temp.get(i));
				user_id.add(temp.get(i).getUser().getId());
			}
			
		}
	}
	
	public void getHotTagTop(){
		List<Tag> temp = new LinkedList<Tag>();
		temp = otherToTagService.getTagAllDesc();
		hotTag = new LinkedList<Tag>();
		for(int i = 0; i < 25 && i < temp.size(); i++){
			hotTag.add(temp.get(i));
		}
	}
	
	//执行保存新问题
	public String saveQuestion() {
		
		String isUpdateQuestion = "";
		if(question.getId() == null) isUpdateQuestion = "NO";
		else isUpdateQuestion = "YES";
		
		String name = (String)ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name == null) return INPUT;
				
		//String name = "aa";
		User user = userService.getUserByName(name);
		//临时存放tag 为了 联系tag和question
		List<Tag> tempTag = new LinkedList<Tag>();
		//找标签
		question.setTag(question.getTag().trim().replaceAll("\\s+", ""));
		String tag[] = question.getTag().split("/");
		String realTag = "";
		
		Set<String> tempTagName = new HashSet<String>();
		
		for(int i = 0; i < tag.length; i++){
			if(tag[i].length() == 0 || tempTagName.contains(tag[i])) continue;
			tempTagName.add(tag[i]);
			List<Tag> tempTagList = new LinkedList<Tag>();
			tempTagList	= otherToTagService.getTagIdByName(tag[i]);
			if(tempTagList.size() != 0){
				realTag = realTag + "/" + tempTagList.get(0).getId();
				tempTag.add(tempTagList.get(0));
			}else{
				//创建新的标签
				otherToTagService.saveTag(new Tag(tag[i], 0));
				Tag tempTag2 ;
				tempTag2 = otherToTagService.getTagIdByName(tag[i]).get(0);
				realTag = realTag + "/" + tempTag2.getId();
				tempTag.add(tempTag2);
				
			}
			 
		}
		question.setFocusCount(1);//提问者
		question.setPageView(0);
		question.setReplyCount(0);
		question.setTag(realTag.substring(1));
		question.setUser(user);
		question.setTime(new Date());
		
		talkService.saveQuestion(question);
		
		//保存questionFocus
		questionFocusService.savaQuestionFocus(new QuestionFocus(user, question));
		
		//关注了问题的图片和蚊子
		questionFocusImg = "../image/focus.png";
		questionFocusWord = "已关注";
		
		//为了jsp 跳转DAO该问题
		question = talkService.getQuestionAllByTime().get(0);
		
		//保存question和tag的关系
		
		tempTagName = new HashSet<String>();
		for(Tag var:tempTag){
			if(tempTagName.contains(var.getTag())) continue;
			tempTagName.add(var.getTag());
			otherToTagService.saveOtherToTag(new OtherToTag(question.getId(), var, "question"));
		}
		
		//执行保存用户的动态（如果是修改问题的话   不应该保存）
		if(isUpdateQuestion.equals("NO")){
			String content = question.getContent();
			/*if(content.length() > 550){
				content = content.substring(0, 550);
			}*/
			UserUpdate userUpdate = new UserUpdate("提出了问题", 
					//问题id
					question.getId(), question.getTitle(), content, //new EliminateHtml().RemoveHtmlTag(content),
					//author 为空 count 为空
					null, null, user, new Date()
					);
			userService.saveUserUpdate(userUpdate);
		}
		
		//统计
	    adminAtatisticsAction.countAdd("question"); 
 
		return SUCCESS;
	}

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public List<Object> getList() {
		return list;
	}

	public void setList(List<Object> list) {
		this.list = list;
	}

	public List<String> getTagList() {
		return tagList;
	}

	public void setTagList(List<String> tagList) {
		this.tagList = tagList;
	}
 
	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
	}
 
	public List<Object> getAnswerList() {
		return answerList;
	}
 
	public void setAnswerList(List<Object> answerList) {
		this.answerList = answerList;
	}
 
	public List<Answer> getSecondeAnswerList() {
		return secondeAnswerList;
	}
 
	public void setSecondeAnswerList(List<Answer> secondeAnswerList) {
		this.secondeAnswerList = secondeAnswerList;
	}

	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}
	public Integer getCategory() {
		return category;
	}
	public void setCategory(Integer category) {
		this.category = category;
	}
	public List<Tag> getHotTag() {
		return hotTag;
	}
	public void setHotTag(List<Tag> hotTag) {
		this.hotTag = hotTag;
	}
	public List<Answer> getBestAnswerUser() {
		return bestAnswerUser;
	}
	public void setBestAnswerUser(List<Answer> bestAnswerUser) {
		this.bestAnswerUser = bestAnswerUser;
	}
	
	public List<Question> getQuestionList() {
		return questionList;
	}
	public void setQuestionList(List<Question> questionList) {
		this.questionList = questionList;
	}
	public String getQuestionFocusImg() {
		return questionFocusImg;
	}
	public void setQuestionFocusImg(String questionFocusImg) {
		this.questionFocusImg = questionFocusImg;
	}
	public String getQuestionFocusWord() {
		return questionFocusWord;
	}
	public void setQuestionFocusWord(String questionFocusWord) {
		this.questionFocusWord = questionFocusWord;
	}
	public String getIsShowAnswerAll() {
		return isShowAnswerAll;
	}
	public void setIsShowAnswerAll(String isShowAnswerAll) {
		this.isShowAnswerAll = isShowAnswerAll;
	}
	public String getUserUpdateName() {
		return userUpdateName;
	}
	public void setUserUpdateName(String userUpdateName) {
		this.userUpdateName = userUpdateName;
	}

	public String[] getQuestionCategory() {
		return questionCategory;
	}

	public void setQuestionCategory(String[] questionCategory) {
		this.questionCategory = questionCategory;
	}
	public List<Question> getRelateQuestion() {
		return relateQuestion;
	}

	public void setRelateQuestion(List<Question> relateQuestion) {
		this.relateQuestion = relateQuestion;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
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

	public boolean getIsShowAll() {
		return isShowAll;
	}

	public void setShowAll(boolean isShowAll) {
		this.isShowAll = isShowAll;
	}
 

	 
	
	
}
