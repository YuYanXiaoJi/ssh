package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.ArticleGreatDao;
import com.Entity.ArticleGreat;

@Repository("articleGreatDao")
public class ArticleGreatImpl implements ArticleGreatDao {

	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<ArticleGreat> checkIsGreat(Integer article_id, Integer user_id) {
		String hql = "from ArticleGreat where  userArticle.id = ?0 and user.id = ?1";
		return getSession().createQuery(hql).setInteger("0", article_id).setInteger("1", user_id).list();
	}

	public void deleteGreat(Integer userArticle_id, Integer user_id) {
		String hql = "delete from ArticleGreat where userArticle.id = ?0 and user.id = ?1";
		getSession().createQuery(hql).setInteger("0", userArticle_id).setInteger("1", user_id).executeUpdate();
	}
	
	public  void  deleteArticleToGreat(Integer userArticle_id) {
		String hql = "delete from ArticleGreat where userArticle.id = ?0";
		getSession().createQuery(hql).setInteger("0", userArticle_id).executeUpdate();
	}

	public void saveGreat(ArticleGreat articleGreat) {
		getSession().saveOrUpdate(articleGreat);
	}

}
