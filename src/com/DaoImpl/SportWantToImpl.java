package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.SportWantToDao;
import com.Entity.SportWantTo;
@Repository("sportWantToDao")
public class SportWantToImpl implements SportWantToDao {

	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
 
	@SuppressWarnings("unchecked")
	public List<SportWantTo> checkIsWant(Integer sport_id, Integer user_id) {
		String hql = "from SportWantTo where  sport.id = ?0 and user.id = ?1";
		return getSession().createQuery(hql).setInteger("0", sport_id).setInteger("1", user_id).list();
	}

	public void deleteWant(Integer sport_id, Integer user_id) {
		String hql = "delete from SportWantTo where sport.id = ?0 and user.id = ?1";
		getSession().createQuery(hql).setInteger("0", sport_id).setInteger("1", user_id).executeUpdate();

	}

	public void saveWant(SportWantTo sportWantTo) {
		getSession().saveOrUpdate(sportWantTo);

	}

	@SuppressWarnings("unchecked")
	public List<SportWantTo> getOneSportAll(Integer sportId) {
		String hql = "from SportWantTo where sport.id = ?0";
		return getSession().createQuery(hql).setInteger("0", sportId).list();
	}

	public void deleteSportWantTo(Integer id) {
		String hql = "delete from SportWantTo where id = ?0";
		getSession().createQuery(hql).setInteger("0", id).executeUpdate();
	}

}
