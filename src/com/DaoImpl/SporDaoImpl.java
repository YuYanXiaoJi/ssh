package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.SportDao;
import com.Entity.Category1;
import com.Entity.Category2;
import com.Entity.Question;
import com.Entity.Sport;
import com.Entity.SportComment;
import com.Entity.SportReply;
import com.Entity.UserArticle;

@Repository("sportDao")
public class SporDaoImpl implements SportDao {
	@Resource
	private SessionFactory sessionFactory;
	
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	public void saveSport(Sport sport) {
		getSession().saveOrUpdate(sport);
	}

	@SuppressWarnings("unchecked")
	public List<Sport> getSportAll(String category1, String category2, String category3) {
		 String hql = "";
		 if (category1.equals("全部地区") && !category2.equals("全部类别")) {
			 hql="from Sport where category2.name = ?0 order by " + category3 + " desc"; 
			 return getSession().createQuery(hql).setString("0", category2).list();
		 } else if(!category1.equals("全部地区") && category2.equals("全部类别")) {
			 hql="from Sport where category1.name = ?0 order by " + category3 + " desc"; 
			 return getSession().createQuery(hql).setString("0", category1).list();
		 } else if (category1.equals("全部地区") && category2.equals("全部类别")) {
			 hql="from Sport   order by " + category3 + " desc"; 
			 return getSession().createQuery(hql).list();
		 } else {
			 hql="from Sport where category1.name = ?0 and category2.name = ?1 order by " + category3 + " desc";
			 return getSession().createQuery(hql).setString("0", category1).setString("1", category2).list();
		 }
		    
	}
	
	@SuppressWarnings("unchecked")
	public List<Sport> getSportAllByTime() {
		String hql = "from Sport order by commentCount desc";
		return getSession().createQuery(hql).list();
	}

	public Sport getSportDetail(Integer id) {
		 String hql="from Sport where id=?0"; 
		return (Sport) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}

	@SuppressWarnings("unchecked")
	public List<Sport> searchSportByDefault(String h) {
		String hql = "from Sport where content like " + h + " order by pageViewCount";
		return getSession().createQuery(hql).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<UserArticle> searchUserArticle(String h) {
		String hql = "from UserArticle where content like " + h + "order by wantCount";
		return getSession().createQuery(hql).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Question> searchQuestion(String h) {
		String hql = "from Question where content like " + h + "order by pageView";
		return getSession().createQuery(hql).list();
	}
	

	public Category1 getCategory1Id(String name) {
		String hql = "from Category1 where name = ?0";
		Category1 c1 = (Category1) getSession().createQuery(hql).setString("0", name).list().get(0);
		return c1;
	}

	public Category2 getCategory2Id(String name) {
		String hql = "from Category2 where name = ?0";
		Category2 c2 = (Category2) getSession().createQuery(hql).setString("0", name).list().get(0);
		return c2;
	}

	public void saveSportComment(SportComment sportComment) {
		
		getSession().saveOrUpdate(sportComment);
	}

	@SuppressWarnings("unchecked")
	public List<SportComment> getSportComment(Integer id) {
		 String hql = "from SportComment where sport.id = ?0";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}

	@SuppressWarnings("unchecked")
	public List<SportReply> getSportReply(Integer id) {
		 String hql = "from SportReply where sport.id = ?0";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}

	public void saveSportReply(SportReply sportReply) {
		
		getSession().saveOrUpdate(sportReply);
	}

	@SuppressWarnings("unchecked")
	public List<Sport> getSportAllOrderBySocre() {
	   String hql = "from Sport order by score desc";
		return getSession().createQuery(hql).list();
	}

	public void deleteSportComment(Integer id) {
		String hql = "delete from SportComment where id = ?0";
		getSession().createQuery(hql).setInteger("0", id).executeUpdate();
	}

	public void deleteSportReply(Integer id) {
		String hql = "delete from SportReply where id = ?0";
		 getSession().createQuery(hql).setInteger("0", id).executeUpdate();
	}

	public void deleteSport(Integer sportId) {
		String hql = "delete from Sport where id = ?0";
		getSession().createQuery(hql).setInteger("0", sportId).executeUpdate();
		
	}

	public SportComment getSportCommentById(Integer id) {
		String hql = "from SportComment where id = ?0";
		return (SportComment) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}
 

	

}
