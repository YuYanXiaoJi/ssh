package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.ArticleDao;
import com.Entity.UserArticle;
import com.Entity.UserArticleComment;
import com.Entity.UserArticleReply;

@Repository("articleDao")
public class ArticleDaoImpl implements ArticleDao {

	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	
	@SuppressWarnings("unchecked")//‰Ø¿¿¡ø
	public List<UserArticle> getArticleAllByPageView() {
		String hql = "from UserArticle where  isExamination = 'true' order by score desc  ";
		return getSession().createQuery(hql).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<UserArticle> getArticleAllByTime() {
		String hql = "from UserArticle where   isExamination = 'true' order by time desc  " ;
		return getSession().createQuery(hql).list();
	}


	@SuppressWarnings("unchecked") //µ„‘ﬁ¡ø
	public List<UserArticle> getArticleAllByGreatCount() {
		String hql = "from UserArticle  where isExamination = 'true' order by greatCount desc ";
		return getSession().createQuery(hql).list();
	}

	

	public UserArticle getArticleDetail(Integer id) {
		 String hql = "from UserArticle where id = ?0 ";
		return (UserArticle) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}
 
	public void saveUserArticleComment(UserArticleComment userArticleComment) {
		 getSession().saveOrUpdate(userArticleComment);
		
	}


	@SuppressWarnings("unchecked")
	public List<UserArticleComment> getUserArticleComment(Integer id) {
		String hql = "from UserArticleComment where userArticle.id = ?0";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}


	 
	@SuppressWarnings("unchecked")
	public List<UserArticleReply> getUserArticleReply(Integer id) {
		String hql = "from UserArticleReply where userArticle.id = ?0";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}


	public void saveUserArticleReply(UserArticleReply userArticleReply) {
		 getSession().saveOrUpdate(userArticleReply);
		
	}

	@SuppressWarnings("unchecked")
	public List<UserArticle> getUserArticleOrderByScore() {
		String hql = "from UserArticle where isExamination = 'true'  order by score desc ";
		return getSession().createQuery(hql).list();
	}


	@SuppressWarnings("unchecked")
	public List<UserArticle> getArticleAllByUserId(Integer user_id) {
		 String hql = "from UserArticle where user.id = ?0";
		return getSession().createQuery(hql).setInteger("0", user_id).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<UserArticle> getUserOtherArticle(Integer user_id,
			Integer article_id) {
		 String hql = "from UserArticle where user.id = ?0 and id <> ?1 and isDraft = 'false' ";
		 return getSession().createQuery(hql).setInteger("0", user_id).setInteger("1", article_id).list();
	}


	@SuppressWarnings("unchecked")
	public List<UserArticle> getExaminationAdopt() {
		 String hql = "from UserArticle where isExamination  = 'true' order by commentCount desc ";
		return getSession().createQuery(hql).list();
	}


	@SuppressWarnings("unchecked")
	public List<UserArticle> getExaminationLoading() {
		 String hql = "from UserArticle where isExamination = 'false' order by time desc";
		return getSession().createQuery(hql).list();
	}


	public UserArticleComment getUserArticleCommentById(Integer id) {
		String hql = "from UserArticleComment where id = ?0";
		return (UserArticleComment) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}

 
 
}
