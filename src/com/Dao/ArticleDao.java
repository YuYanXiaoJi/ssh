package com.Dao;

import java.util.List;
 
import com.Entity.UserArticle;
import com.Entity.UserArticleComment;
import com.Entity.UserArticleReply;

public interface ArticleDao {
	//按浏览量排序
	 List<UserArticle> getArticleAllByPageView();
	//按时间
	 List<UserArticle> getArticleAllByTime();
	//按点赞量
	 List<UserArticle> getArticleAllByGreatCount();
	
	 //得到一个作者的所有文章
	 List<UserArticle> getArticleAllByUserId(Integer user_id);
	 //得到use其他文章
	 List<UserArticle> getUserOtherArticle(Integer user_id, Integer article_id);
	 
	//得到一片文章详细
	 UserArticle getArticleDetail(Integer id);
	 
	 //得到通过审核的和没有审核article
	 List<UserArticle> getExaminationAdopt();
	 List<UserArticle> getExaminationLoading();
	 
 
	//保存评论
	 void saveUserArticleComment(UserArticleComment userArticleComment); 
	 //得到一级评论
	 List<UserArticleComment> getUserArticleComment(Integer id);
	 //得到二级评论
	 List<UserArticleReply> getUserArticleReply(Integer id);
	 //保存二级评论
	 void saveUserArticleReply(UserArticleReply userArticleReply);
	 //得到一级评论 （admin删除内容）
	 UserArticleComment getUserArticleCommentById(Integer id);
	 
	
	//得到按综合得分的top3
	 List<UserArticle> getUserArticleOrderByScore();
 
}
