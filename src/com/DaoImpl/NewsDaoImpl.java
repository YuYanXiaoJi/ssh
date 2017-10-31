package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.NewsDao;
import com.Entity.News;

@Repository("newsDao")
public class NewsDaoImpl implements NewsDao {

	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	
	public void saveNews(News news) {
		getSession().saveOrUpdate(news);
	}


	@SuppressWarnings("unchecked")
	public List<News> getNewsAllRead(Integer id) {
		String hql = "from News where flag = 1 and targetUser.id = ?0";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}


	@SuppressWarnings("unchecked")
	public List<News> getNewsAllUnread(Integer id) {
		String hql = "from News where flag = 0 and targetUser.id = ?0";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}


	@SuppressWarnings("unchecked")
	public List<News> getNewsAll(Integer id) {
		 String hql = "from News where targetUser.id = ?0";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}


	public News getNewsDetail(Integer id) {
		 String hql = "from News where id = ?0";
		return (News) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}


 

}
