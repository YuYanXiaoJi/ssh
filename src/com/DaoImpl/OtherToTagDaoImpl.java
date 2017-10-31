package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.OtherToTagDao;
import com.Entity.OtherToTag;
import com.Entity.Tag;
 
@Repository("otherToTagDao")
public class OtherToTagDaoImpl implements OtherToTagDao {
	
	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}


	public void saveTag(Tag tag) {
		getSession().saveOrUpdate(tag);
	}

	public void saveOtherToTag(OtherToTag otherToTag) {
		 getSession().saveOrUpdate(otherToTag);

	}


	public Tag getTagById(Integer id) {
		String hql = "from Tag where id = ?0";
		return (Tag) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}
 

	@SuppressWarnings("unchecked")
	public List<Tag> getTagAllDesc() {
		String hql = "from Tag  where tag <> 'undefined' order by tagCount desc ";
		return getSession().createQuery(hql).list();
	}

 
 

	/*@SuppressWarnings("unchecked")
	public List<OtherToTag> getOtherFromOtherToTagByTag_id1(String other, Integer tag_id) {
		String hql = "from OtherToTag where flag = ?0 and otherId = ?1";
		return (List<OtherToTag>) getSession().createQuery(hql).setString("0", other).setInteger("1", tag_id);
	}*/


	@SuppressWarnings("unchecked")
	public List<OtherToTag> getOtherToTagByOtherAll(Integer otherId, String flag) {
		String hql = "from OtherToTag where otherId = ?0 and flag = ?1";
		return getSession().createQuery(hql).setInteger("0", otherId).setString("1", flag).list();
	}


	public void deleteOtherToTag(OtherToTag otherToTag) {
		getSession().delete(otherToTag);
	}
	
	public void delteArticleToTag(Integer otherId, String flag) {
		String hql = "delete from OtherToTag where otherId = ?0 and flag = ?1";
		getSession().createQuery(hql).setInteger("0", otherId).setString("1", flag).executeUpdate();
		
	}


	@SuppressWarnings("unchecked")
	public List<OtherToTag> getOtherForRecommend(String flag, Integer tagId) {
		String hql = "from OtherToTag where flag  = ?0 and tag_id = ?1";
		return getSession().createQuery(hql).setString("0", flag).setInteger("1", tagId).list();
	}


	@SuppressWarnings("unchecked")
	public List<Tag> getTagIdByName(String tagName) {
		String hql = "from Tag where tag = ?0";
		return getSession().createQuery(hql).setString("0", tagName).list();
	}


	@SuppressWarnings("unchecked")
	public List<OtherToTag> getOtherAllByTagId(Integer tag_id) {
		String hql = "from OtherToTag where tag_id = ?0";
		return getSession().createQuery(hql).setInteger("0", tag_id).list();
	}


	
 
 
 

 

}
