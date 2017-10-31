package com.DaoImpl;

 
import java.util.List;
 
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import com.Dao.UserDao;
import com.Entity.User;
import com.Entity.UserArticle;
import com.Entity.UserFocus;
import com.Entity.UserUpdate;
 
@Repository("userDao")
public class UserDaoImpl  implements UserDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	public Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings({ "unchecked" })
	public List<User> getUserById(Integer id) {
		String hql="  from User u where u.id=?0";
		
		List<User> list =  getSession().createQuery(hql).setInteger("0", id).list();
		
		return  list ;
	}
	
	public List<User> getUserByName(String Username) {

		String hql=" from User u where u.username=?0";
		
		@SuppressWarnings("unchecked")
		List<User> list =  getSession().createQuery(hql).setString("0", Username).list();
		return  list;
		
	}

	public void saveUser(User user) {
		getSession().saveOrUpdate(user);
		
	}
  
	@SuppressWarnings("unchecked")
	public List<User> loginValid(String username, String password) {
		String hql = "";
		if(username.equals("admin")) {
			hql="from User u where u.username=?0 and u.password=?1  ";
			List<User> list =  getSession().createQuery(hql).setString("0", username).setString("1",password).list();
			return  list;
		} else {
			hql="from User u where u.username=?0 and u.password=?1 and isForbidden = 'false' ";
			List<User> list =  getSession().createQuery(hql).setString("0", username).setString("1",password).list();
			return  list;
		}
		
	}

	@SuppressWarnings("unchecked")
	public List<User> registValid(String username) {
		String hql="from User u where u.username=?0 ";
		List<User> list =  getSession().createQuery(hql).setString("0", username).list();
		return  list;
	}
 
	public void saveUserArticle(UserArticle userArticle) {
		 
		getSession().saveOrUpdate(userArticle);
	}

	@SuppressWarnings("unchecked")
	public List<UserArticle> getUserArticleAll(String username) {
		 String hql = "from UserArticle where user.username = ?0  and isDraft = 'false'  order by time desc";
		return  getSession().createQuery(hql).setString("0", username).list() ;
	}
	
	@SuppressWarnings("unchecked")
	public List<UserArticle> getUserDraft(String username) {
		String hql = "from UserArticle where user.username = ?0 and isDraft = 'true' ";
		return  getSession().createQuery(hql).setString("0", username).list() ;
	}
	
	
	public void saveUserUpdate(UserUpdate userUpdate) {
		getSession().saveOrUpdate(userUpdate);
		
	}

	public void deleteUserUpdate(String flag, Integer other_id, Integer owner_id) {
		String hql = "delete from UserUpdate where flag = ?0 and other_id = ?1 and owner.id = ?2";
		getSession().createQuery(hql).setString("0", flag).setInteger("1", other_id).setInteger("2", owner_id).executeUpdate();
		
	}

	@SuppressWarnings("unchecked")
	public List<UserUpdate> getUserUpdate(Integer user_id) {
		String hql = " from UserUpdate where owner.id = ?0 order by time desc";
		return getSession().createQuery(hql).setInteger("0", user_id).list();
	}

	@SuppressWarnings("unchecked")
	public List<UserUpdate> getUserUpdateQuestion(Integer user_id) {
		String hql = " from UserUpdate where owner.id = ?0 and flag = '提出了问题'  order by time desc";
		return getSession().createQuery(hql).setInteger("0", user_id).list();
	}

	@SuppressWarnings("unchecked")
	public List<UserUpdate> getUserUpdateBlog(Integer user_id) {
		 
		String hql = " from UserUpdate where owner.id = ?0 and flag = '发表了游记'  order by time desc";
		return getSession().createQuery(hql).setInteger("0", user_id).list();
	}

	@SuppressWarnings("unchecked")
	public List<UserUpdate> getUserUpdateAnswer(Integer user_id) {
		String hql = " from UserUpdate where owner.id = ?0 and flag = '回答了问题'  order by time desc";
		return getSession().createQuery(hql).setInteger("0", user_id).list();
	}

	public void saveUserFocus(UserFocus userFocus) {
		getSession().save(userFocus);
		
	}

	public void deletUserFocus(Integer user_id, Integer targetUser_id) {
		String hql = "delete from UserFocus where user.id = ?0 and targetUser.id = ?1";
		getSession().createQuery(hql).setInteger("0", user_id).setInteger("1", targetUser_id).executeUpdate();
		
	}

	@SuppressWarnings("unchecked")
	public List<UserUpdate> getUserUpdateFocusQuestion(Integer user_id) {
		String hql = "from UserUpdate where owner.id = ?0 and flag = '关注了问题' order by time desc";
		return getSession().createQuery(hql).setInteger("0", user_id).list();
	}

	@SuppressWarnings("unchecked")
	public List<UserFocus> getUserFocusFollowing(Integer user_id) {
		String hql = "from UserFocus where user.id = ?0 ";
		return getSession().createQuery(hql).setInteger("0", user_id).list();
	}

	@SuppressWarnings("unchecked")
	public List<UserFocus> getUserFocusFollower(Integer targetUser_id) {
		String hql = "from UserFocus where targetUser.id = ?0";
		return getSession().createQuery(hql).setInteger("0", targetUser_id).list();
	}

	@SuppressWarnings("unchecked")
	public List<UserFocus> checkUserFocus(Integer user_id, Integer targetUser_id) {
		String hql = "from UserFocus where user.id = ?0 and targetUser.id = ?1";
		return getSession().createQuery(hql).setInteger("0", user_id).setInteger("1", targetUser_id).list();
	}

	public void deletUserArticle(Integer userArticle_id) {
		 String hql = "delete from UserArticle where id = ?0";
		getSession().createQuery(hql).setInteger("0", userArticle_id).executeUpdate();
	}
	
	public void deleteArticleComment(Integer userArticle_id) {
		String hql = "delete from UserArticleComment where userArticle_id = ?0";
		getSession().createQuery(hql).setInteger("0", userArticle_id).executeUpdate();
	}

	public void deleteArticleReply(Integer userArticle_id) {
		String hql = "delete from UserArticleReply where userArticle_id = ?0";
		getSession().createQuery(hql).setInteger("0", userArticle_id).executeUpdate();
	}

	@SuppressWarnings("unchecked")
	public List<User> getUserOrderByFollower() {
		String hql = "from User where managerOrNot = 'false' order by followerCount desc";
		return  getSession().createQuery(hql).list();
	}

	public void adminDeleteUpdate(String flag, Integer other_id) {
		 String hql = "delete from UserUpdate where flag = ?0 and other_id = ?1";
		 getSession().createQuery(hql).setString("0", flag).setInteger("1", other_id).executeUpdate();
	}

	public void deleteArticleCommentById(Integer id) {
		String hql = "delete from UserArticleComment where id = ?0";
		getSession().createQuery(hql).setInteger("0", id).executeUpdate();
	}

	public void deleteArticleReplyById(Integer id) {
		String hql = "delete from UserArticleReply where id = ?0";
		getSession().createQuery(hql).setInteger("0", id).executeUpdate();
		
	}

	
 
}
