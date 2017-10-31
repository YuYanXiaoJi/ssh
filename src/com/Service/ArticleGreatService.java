package com.Service;

import java.util.List;

import com.Entity.ArticleGreat;

public interface ArticleGreatService {
	//检查是否已点赞
		  List<ArticleGreat> checkIsGreat(Integer article_id,Integer user_id);
		//删除点赞信息 dui具体某个人
		  void deleteGreat(Integer userArticle_id,Integer user_id);
		//保存点赞信息
		  void saveGreat(ArticleGreat articleGreat);
		//当删除文章的时候 删除点赞的关系
		  void deleteArticleToGreat(Integer userArticle_id);
}
