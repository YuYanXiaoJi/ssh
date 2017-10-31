package com.Dao;

import java.util.List;

import com.Entity.Category1;
import com.Entity.Category2;
import com.Entity.Question;
import com.Entity.Sport;
import com.Entity.SportComment;
import com.Entity.SportReply;
import com.Entity.UserArticle;

public interface SportDao {
	//保存景点
	  void saveSport(Sport sport);
	 // 删除sport
	  void deleteSport(Integer sportId);
	//在sport的详情页面  例如 按照浙江  田园风光  评论数  进行搜索
	  List<Sport> getSportAll(String category1, String category2, String category3);
	  
	  List<Sport> getSportAllByTime();
	  
	//得到详情
	  Sport getSportDetail(Integer id);
	
	  //本来用于按照sport的content搜索用户关键字
	  List<Sport> searchSportByDefault(String h);
	//按照关键字搜索文章
	  List<UserArticle> searchUserArticle(String h);
	  //按照关键字 搜question
	  List<Question> searchQuestion(String h);
	  
	//得到浙江  的id  (类别的id)
	  Category1 getCategory1Id(String name);
	  Category2 getCategory2Id(String name);
	//保存评论（一级）
	  void saveSportComment(SportComment sportComment);
	//得到一级评论
	  List<SportComment> getSportComment(Integer id);
	//得到二级评论
	  List<SportReply> getSportReply(Integer id);
	//保存二级评论
	  void saveSportReply(SportReply sportReply);
	  //删除一级评论
	 void deleteSportComment(Integer id);
	  //删除二级评论
	  void deleteSportReply(Integer id);
	  //得DAOcomment 为了admin的删除
	  SportComment getSportCommentById(Integer id);
	  
	
	
	//得到景点按照评分的排序的
	List<Sport> getSportAllOrderBySocre();
	
}
