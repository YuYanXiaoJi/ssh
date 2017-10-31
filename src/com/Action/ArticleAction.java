package com.Action;

import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.Algorithm.CRList;
import com.Algorithm.EliminateHtml;
import com.Algorithm.Pager;
import com.Algorithm.PagerService;
import com.Entity.News;
import com.Entity.Tag;
import com.Entity.User;
import com.Entity.UserArticle;
import com.Entity.UserArticleComment;
import com.Entity.UserArticleReply;
import com.Service.ArticleGreatService;
import com.Service.ArticleService;
import com.Service.OtherToTagService;
import com.Service.NewsService;
import com.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@Controller("articleAction")
@Scope("prototype")
public class ArticleAction extends ActionSupport {
	@Resource
	private ArticleService articleService;
	@Resource
	private UserService userService;
	@Resource
	private NewsService newsService;
	@Resource
	private ArticleGreatService articleGreatService;
	@Resource
	private OtherToTagService otherToTagService;
	@Resource
	private CacheTagAction cacheTagAction;
	@Resource
	private AdminStatisticsAction adminAtatisticsAction; 
	

	
	private List<UserArticle> listAritcle;
	private UserArticle userArticle;
	private String CR;
	private UserArticleReply userArticleReply;
	private List<CRList> crlist ;//存放排序过的评论
 
	
	private PagerService pagerService;//分页属性
	private Pager pager;
	protected String currentPage;//从jsp中传递过来的当前页
	protected int totalPages;
	protected String totalRows;
	protected String pagerMethod;
	private String isToEnd;
	protected String startPage;//为了前台展示
	protected String endPage;
	
 
	@SuppressWarnings("rawtypes")
	static private Set ArticleId;//关于增加文章的浏览量
	
	private String greatImg;//点赞图片
 
	private String[] tag;//文章的标签
	private String json;//用于加载更多的article
	
	private List<Tag> tagList;
	
	//保存消息
	public void saveNews(User targetuser, User user, String title, Integer title_id, Date time, Integer type1, Integer type2, Integer flag){
		News news = new News(targetuser, user, title, title_id, time, type1, type2, flag);
		newsService.saveNews(news);
	}
	
 
	//判断回复类型
	/*public String saveUserArticleCR(){
		char[] kk = CR.toCharArray(); 
		if(kk[0] != '[' || kk[1] != '回'|| kk[2] != '复' || kk[3] != ':'){
			return "saveUserArticleComment";
		}
		else{
			return "saveUserArticleReply";
		}
	}*/
	//对2级回复保存
	public String saveUserArticleReply(){
		UserArticleReply sr = new UserArticleReply();
		
		/*String targetUser = "";
		char[] cr = CR.toCharArray();
		for(int j = 0, i= 0; i < CR.length(); i++){
			if(cr[i] == ']') break;
			if(j == 1) targetUser = targetUser + cr[i];
			if(cr[i] == ':') j++;
		}*/
		
		sr.setTime(new Date());
		//登入者
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name == null) return INPUT;
		
		User user = userService.getUserByName(name);
		sr.setUser(user);
		//回复目标者
		//User targetuser = userService.getUserByName(userArticleReply.getTargetUser().getUsername());
		
		//sr.setTargetUser(targetuser);
		sr.setType(userArticleReply.getType());
		sr.setContent(CR);
		sr.setTargetCRId(userArticleReply.getTargetCRId());
		UserArticle userarticle = articleService.getArticleDetail(userArticle.getId());
		sr.setUserArticle(userarticle);
		articleService.saveUserArticleReply(sr);
		
		//需要给文章的评论数+1
		UserArticle temp = articleService.getArticleDetail(userArticle.getId());
		temp.setCommentCount(temp.getCommentCount() + 1);
		userService.saveUserArticle(temp);
		
		//保存消息
		//saveNews(targetuser, user, userarticle.getTitle(), userarticle.getId(), new Date(), 1, 1, 0);
		
		//统计留言
		adminAtatisticsAction.countAdd("comment");
				
		return SUCCESS;
	}
	
	//进行对文章的评论的保存
	public String saveUserArticleComment(){
		UserArticleComment userArticleComment = new UserArticleComment();
		String u = CR;
		 
		userArticleComment.setContent(u);
		//前台进行了检查了是否登入
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name == null) return INPUT;
		
		User user = userService.getUserByName(name);
		userArticleComment.setUser(user);
		userArticleComment.setTime(new Date());
		UserArticle userarticle = articleService.getArticleDetail(userArticle.getId());
		userArticleComment.setUserArticle(userarticle);
		articleService.saveUserArticleComment(userArticleComment);
		
		//需要给文章的评论数+1
		UserArticle temp = articleService.getArticleDetail(userArticle.getId());
		temp.setCommentCount(temp.getCommentCount() + 1);
		userService.saveUserArticle(temp);
		
		//保存消息
		//User targetuser = userService.getUserById(userarticle.getUser().getId());
		//(targetuser, user, userarticle.getTitle(), userarticle.getId(), new Date(), 0, 1, 0);
		
		//统计留言
	    adminAtatisticsAction.countAdd("comment");

		return SUCCESS;
	}
	
	//利用ajax 得到更多的文章
	public void getArticleMore(){
		JSONObject ObjecJson = new JSONObject();
		ObjecJson = JSONObject.fromObject(json);
		Integer total = ObjecJson.getInt("total");
		Integer size = ObjecJson.getInt("size");//每次加载数
		Integer state = 1;//用来区别是不是加载完毕了
		
		//listAritcle = new  LinkedList<UserArticle>();
		listAritcle = articleService.getArticleAllByPageView();
		List<UserArticle> temp = new LinkedList<UserArticle>();
		int i = total ;
		for(int j = 1; i < listAritcle.size() && j <= size; j++, i++){
			temp.add(listAritcle.get(i));
		}
		if(i == listAritcle.size()) state = 0;
		
		//JsonConfig config = new JsonConfig();
		//放弃采用级联
		//config.setExcludes(new String[] { "user"});
		
		JSONArray ja = new JSONArray();
		for (UserArticle item:temp) {
			JSONObject jsonObject = new JSONObject();
			//User user = item.getUser();
			//jsonObject.put("user", user);
			item.setContent(new EliminateHtml().RemoveHtmlTag(item.getContent()));
			jsonObject.put("userArticle", item);
			jsonObject.put("state", state);
 
			ja.add(jsonObject);	
		}
		
		JSONArray jsonArray = JSONArray.fromObject(ja);
		
		String json2 = jsonArray.toString();
		//System.out.println("------------------------------"+json2);
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
	

	//导航栏点击需要得到所有文章的时候
	@SuppressWarnings("rawtypes")
	public String getArticleAll(){
		listAritcle = new  LinkedList<UserArticle>();
        
		listAritcle = articleService.getArticleAllByPageView();  //其实是按照分数来的
        //listAritcle = articleService.getArticleByGreatCount();
 
		List<UserArticle> template = new LinkedList<UserArticle>();
		template = listAritcle;
		listAritcle = new LinkedList<UserArticle>();
		 if(template.size() > 0){
			 Page(template.size(), 2);
			 for(int i = this.pager.getStartRow() - 1, j = 0; i < this.pager.getTotalRows() && j < this.pager.getPageSize(); j++, i++){
				 template.get(i).setContent(new EliminateHtml().RemoveHtmlTag(template.get(i).getContent()));
				 listAritcle.add(template.get(i));
			 }
		 }
		
		//得到一个会话开始的session  防止文章浏览量刷新加1   
		HttpSession session = ServletActionContext.getRequest().getSession();
		if(session.getAttribute("ArticleId") == null){
			session.setAttribute("ArticleId", true);
			ArticleId = new HashSet();
		}
		
		//得到热门的标签 25ge
		tag = new String[25];
		List<Tag> tempTag = otherToTagService.getTagAllDesc();
		for(int i = 0; i < 25; i++){
			tag[i] = tempTag.get(i).getTag();
		}
 
		return SUCCESS;
	}
	
	//增加文章的浏览量 +1(取的名字有误pageview==wantcount)
	@SuppressWarnings("unchecked")
	public void  addPageView(){
		//根据session是否失效判断  对文章的浏览量增加1
		if(ServletActionContext.getRequest().getSession().getAttribute("ArticleId") != null){
			//去类中查看是否有文章id了
			if(ArticleId != null && !ArticleId.contains(userArticle.getId())){
				userArticle.setWantCount(userArticle.getWantCount() + 1);
				//更新  浏览量 +1
				userService.saveUserArticle(userArticle);
				ArticleId.add(userArticle.getId());
			 }
		}
	}
	
	//得到文章的详情
	public String getArticleDetail(){
		
		userArticle = articleService.getArticleDetail(userArticle.getId());
		ServletActionContext.getRequest().setAttribute("id", userArticle.getId());
		
		//浏览量加1
		addPageView();
		
		//判断是否可以点赞
		checkIsGreat();
 
		//得到这个文章的评论
		List<UserArticleComment> comment = articleService.getUserArticleComment(userArticle.getId());
		List<UserArticleReply> reply = articleService.getUserArticleReply(userArticle.getId());
		//利用数据结构排序
		crlist=new CRList().getCRArticleList(comment, reply);
		
		//得到tag 的处理
		getAllTag();
		
		//得到该作者的其他文章
		//listAritcle = articleService.getArticleAllByUserId(userArticle.getUser().getId());
		listAritcle = articleService.getUserOtherArticle(userArticle.getUser().getId(), userArticle.getId());
		//分页操作
		List<CRList> template = new LinkedList<CRList>();
		template = crlist;
		crlist = new LinkedList<CRList>();
		if (template.size() > 0) {
			Page(template.size(), 8);
			for(int i = this.pager.getStartRow() - 1,j = 0; i < this.pager.getTotalRows() && j < this.pager.getPageSize(); j++, i++){
				crlist.add(template.get(i));
			}
		}
		//设置start和end的page
		setPage();
		
		//设置登入者cacheTag
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name != null){
			cacheTagAction.saveCacheTag(userArticle.getTag());
		}
		
		//统计
		adminAtatisticsAction.countAdd("pageView");
		
		return SUCCESS;
	}
	
	public void setPage(){
		if(currentPage == null){
			currentPage = "1";
			startPage = "1";
			endPage =  totalPages+"";
		} else {
			if(Integer.parseInt(currentPage) - 3 < 0){
				 startPage = 1 + "";
			 }else{
				 startPage = (Integer.parseInt(currentPage) - 3) + ""; 
			 }
			 if(Integer.parseInt(currentPage) + 3 <= totalPages){
				 endPage = (Integer.parseInt(currentPage) + 3) + "";
			 }else{
				 endPage = totalPages + "";
			 } 
		}
		
	}
	
	//判断是否可以点赞
	public void checkIsGreat(){
		//检查是否是登入用户
		String name = (String) ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name != null){
			User user = userService.getUserByName(name);
			if(articleGreatService.checkIsGreat(userArticle.getId(), user.getId()).size() != 0){
				greatImg = "../image/11.jpg";
			}
			else greatImg ="../image/00.jpg";
		}
		else{
			greatImg = "../image/00.jpg";
		}
	}
	
	//进行tag的String[]处理
	public void  getAllTag(){
		//先得到序列
		String str[] = userArticle.getTag().split("/");
		Set<String> tempTagName = new HashSet<String>();
		tag = new String[str.length];
		for (int i =0; i < str.length; i++){
			if (tempTagName.contains(str[i])) continue;
			tempTagName.add(str[i]);
			Tag temp = otherToTagService.getTagById(Integer.parseInt(str[i]));
			tag[i] = temp.getTag();
		}
		
	}
	
	//分页函数
		public void Page(int totalRow, int PageRow){
			 
			pagerService = new PagerService();
			this.pager = pagerService.getPager(this.getCurrentPage(), this.getPagerMethod(), totalRow, PageRow);
			this.setCurrentPage(String.valueOf(this.pager.getCurrentPage()));
			this.setTotalRows(String.valueOf(totalRow));
			this.totalPages = pager.getTotalPages();
		}
	
	//得到优秀游记  在index页面显示
	public String getIndexArticle(){
		List<UserArticle> templist = articleService.getUserArticleOrderByScore();
		listAritcle = new  LinkedList<UserArticle>();
		for(int i = 0; i < 3; i++) {
			listAritcle.add(templist.get(i));
		}
		
		for(UserArticle temp:listAritcle){
			//去掉HTML语句
			temp.setContent(new EliminateHtml().RemoveHtmlTag(temp.getContent()));
		}
		
		//以及得到5个最高的热门标签
		tagList = otherToTagService.getTagAllDesc();
 
		return SUCCESS;
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

	public List<CRList> getCrlist() {
		return crlist;
	}

	public void setCrlist(List<CRList> crlist) {
		this.crlist = crlist;
	}
 
	public UserArticleReply getUserArticleReply() {
		return userArticleReply;
	}

	public void setUserArticleReply(UserArticleReply userArticleReply) {
		this.userArticleReply = userArticleReply;
	}

	public String getCR() {
		return CR;
	}

	public void setCR(String cR) {
		CR = cR;
	}

	public UserArticle getUserArticle() {
		return userArticle;
	}

	public void setUserArticle(UserArticle userArticle) {
		this.userArticle = userArticle;
	}
 
	public List<UserArticle> getListAritcle() {
		return listAritcle;
	}

	public void setListAritcle(List<UserArticle> listAritcle) {
		this.listAritcle = listAritcle;
	}


	public String getGreatImg() {
		return greatImg;
	}


	public void setGreatImg(String greatImg) {
		this.greatImg = greatImg;
	}
	public String[] getTag() {
		return tag;
	}
	public void setTag(String[] tag) {
		this.tag = tag;
	}
 
	public String getJson() {
		return json;
	}
 
	public void setJson(String json) {
		this.json = json;
	}
 
	public String getIsToEnd() {
		return isToEnd;
	}
 
	public void setIsToEnd(String isToEnd) {
		this.isToEnd = isToEnd;
	}
 
	public String getStartPage() {
		return startPage;
	}
 
	public void setStartPage(String startPage) {
		this.startPage = startPage;
	}
 
	public String getEndPage() {
		return endPage;
	}
 
	public void setEndPage(String endPage) {
		this.endPage = endPage;
	}


	public List<Tag> getTagList() {
		return tagList;
	}


	public void setTagList(List<Tag> tagList) {
		this.tagList = tagList;
	}
 
 
	
}
