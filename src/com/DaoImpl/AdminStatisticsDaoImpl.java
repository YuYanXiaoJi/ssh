package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.AdminStatisticsDao;
import com.Entity.PageView;
import com.Entity.SpecialScheme;
import com.Entity.SpecialSchemeUser;
import com.Entity.User;

@Repository("adminStatisticsDao")
public class AdminStatisticsDaoImpl implements AdminStatisticsDao {
	
	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<PageView> getAllOrderByTime() {
		String hql = "from PageView order by time desc";
		return getSession().createQuery(hql).list();
	}

	public void savePageView(PageView pageView) {
		 getSession().saveOrUpdate(pageView);
	}

	@SuppressWarnings("unchecked")
	public List<User> adminGetUserAll() {
		String hql = "from User where managerOrNot = 'false' ";
		return getSession().createQuery(hql).list();
	}

	public void saveSpecialScheme(SpecialScheme specailScheme) {
		getSession().saveOrUpdate(specailScheme);
		
	}

	@SuppressWarnings("unchecked")
	public List<SpecialScheme> getSchenmeListAll() {
		String hql = "from SpecialScheme order by time";
		return getSession().createQuery(hql).list();
	}

	public SpecialScheme getSpecialSchemeDetail(Integer id) {
		String hql = "from SpecialScheme where id = ?0";
		return (SpecialScheme) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}

	public void saveSpecialSchemeUser(SpecialSchemeUser specialSchemeUser) {
		getSession().saveOrUpdate(specialSchemeUser);
	}

	@SuppressWarnings("unchecked")
	public List<SpecialSchemeUser> getSchemeUserAll() {
		String hql = " from SpecialSchemeUser";
		return getSession().createQuery(hql).list();
	}

}
