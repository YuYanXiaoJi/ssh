package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
 
import com.Dao.ArticleGreatDao;
import com.Entity.ArticleGreat;

@Service("articleGreatService")
public class ArticleGreatServiceImpl implements com.Service.ArticleGreatService {

	@Resource
	private ArticleGreatDao articleGreatDao;
	
	public List<ArticleGreat> checkIsGreat(Integer article_id, Integer user_id) {
		 
		return articleGreatDao.checkIsGreat(article_id, user_id);
	}

	public void deleteGreat(Integer userArticle_id, Integer user_id) {
		 articleGreatDao.deleteGreat(userArticle_id, user_id);
		
	}

	public void saveGreat(ArticleGreat articleGreat) {
		articleGreatDao.saveGreat(articleGreat);
	}

	public void deleteArticleToGreat(Integer userArticle_id) {
		 articleGreatDao.deleteArticleToGreat(userArticle_id);
		
	}

}
