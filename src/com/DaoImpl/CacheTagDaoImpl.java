package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.CacheTagDao;
import com.Entity.CacheTag;
@Repository("cacheTagDao")
public class CacheTagDaoImpl implements CacheTagDao {
	
	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	public void save(CacheTag cacheTag) {
		 getSession().saveOrUpdate(cacheTag);
	}

	@SuppressWarnings("unchecked")
	public List<CacheTag> getUserCacheTagList(Integer userId) {
		String hql = "from CacheTag where userId = ?0";
		return getSession().createQuery(hql).setInteger("0", userId).list();
	}

}
