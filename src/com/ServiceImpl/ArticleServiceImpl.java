package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.Dao.ArticleDao;
import com.Entity.UserArticle;
import com.Entity.UserArticleComment;
import com.Entity.UserArticleReply;
import com.Service.ArticleService;
@Service("articleService")
public class ArticleServiceImpl implements ArticleService {
	@Resource
	private ArticleDao articleDao;
	
	
	public List<UserArticle> getArticleAllByPageView() {
		 
		return articleDao.getArticleAllByPageView();
	}
	
	public List<UserArticle> getArticleAllByTime() {
		 
		return articleDao.getArticleAllByTime();
	}

	public List<UserArticle> getArticleAllByGreatCount() {
		 
		return articleDao.getArticleAllByGreatCount();
	}

	public UserArticle getArticleDetail(Integer id) {
		 
		return articleDao.getArticleDetail(id);
	}

	 

	public void saveUserArticleComment(UserArticleComment userArticleComment) {
		articleDao.saveUserArticleComment(userArticleComment);
		
	}

	public List<UserArticleComment> getUserArticleComment(Integer id) {
		 
		return  articleDao.getUserArticleComment(id);
	}

	public List<UserArticleReply> getUserArticleReply(Integer id) {
		 
		return articleDao.getUserArticleReply(id);
	}

	public void saveUserArticleReply(UserArticleReply userArticleReply) {
		articleDao.saveUserArticleReply(userArticleReply);
		
	}

	public List<UserArticle> getUserArticleOrderByScore() {
		 
		return articleDao.getUserArticleOrderByScore();
	}

	public List<UserArticle> getArticleAllByUserId(Integer user_id) {
		 
		return articleDao.getArticleAllByUserId(user_id);
	}

	public List<UserArticle> getUserOtherArticle(Integer user_id,
			Integer article_id) {
		 
		return articleDao.getUserOtherArticle(user_id, article_id);
	}

	public List<UserArticle> getExaminationAdopt() {
		 
		return articleDao.getExaminationAdopt();
	}

	public List<UserArticle> getExaminationLoading() {
		 
		return articleDao.getExaminationLoading();
	}

	public UserArticleComment getUserArticleCommentById(Integer id) {
		return articleDao.getUserArticleCommentById(id);
	}
 
 
 
}
