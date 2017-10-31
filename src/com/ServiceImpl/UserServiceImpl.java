package com.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.Dao.UserDao;
import com.Entity.User;
import com.Entity.UserArticle;
import com.Entity.UserFocus;
import com.Entity.UserUpdate;
import com.Service.UserService;


@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	
	public User getUserById(Integer id) {
		
		List<User> L =userDao.getUserById(id);
		if(L.size()>0)
		return L.get(0);
		return null;
	}

	
	public User getUserByName(String Username) {
		
		List<User> L =userDao.getUserByName(Username);
		if(L.size()>0)
		return L.get(0);
		return null;
	}

	
	public void saveUser(User user) {
		userDao.saveUser(user);
		
	}
 

	
	public List<User> loginValid(String username, String password) {
		return userDao.loginValid(username, password);
	}


	public List<User> registValid(String username) {
		return userDao.registValid(username);
	}
 

	public void saveUserArticle(UserArticle userArticle) {
		 
		userDao.saveUserArticle(userArticle);
	}


	public List<UserArticle> getUserArticleAll(String username) {
		 
		return userDao.getUserArticleAll(username);
	}


	public void saveUserUpdate(UserUpdate userUpdate) {
		userDao.saveUserUpdate(userUpdate);
		
	}


	public void deleteUserUpdate(String flag, Integer other_id, Integer owner_id) {
		 userDao.deleteUserUpdate(flag, other_id, owner_id);
		
	}


	public List<UserUpdate> getUserUpdate(Integer user_id) {
		return userDao.getUserUpdate(user_id);
	}


	public List<UserUpdate> getUserUpdateQuestion(Integer user_id) {
		 
		return userDao.getUserUpdateQuestion(user_id);
	}


	public List<UserUpdate> getUserUpdateBlog(Integer user_id) {
		 
		return userDao.getUserUpdateBlog(user_id);
	}


	public List<UserUpdate> getUserUpdateAnswer(Integer user_id) {
		 
		return  userDao.getUserUpdateAnswer(user_id);
	}


	public void saveUserFocus(UserFocus userFocus) {
		userDao.saveUserFocus(userFocus);
		
	}


	public void deletUserFocus(Integer user_id, Integer targetUser_id) {
		userDao.deletUserFocus(user_id, targetUser_id);
		
	}


	public List<UserUpdate> getUserUpdateFocusQuestion(Integer user_id) {
		
		return userDao.getUserUpdateFocusQuestion(user_id);
	}


	public List<UserFocus> getUserFocusFollowing(Integer user_id) {
		 
		return userDao.getUserFocusFollowing(user_id);
	}


	public List<UserFocus> getUserFocusFollower(Integer targetUser_id) {
		 
		return userDao.getUserFocusFollower(targetUser_id);
	}


	public List<UserFocus> checkUserFocus(Integer user_id, Integer targetUser_id) {
		 
		return userDao.checkUserFocus(user_id, targetUser_id);
	}


	public List<UserArticle> getUserDraft(String username) {
		 
		return userDao.getUserDraft(username);
	}


	public void deletUserArticle(Integer userArticle_id) {
		 userDao.deletUserArticle(userArticle_id);
		
	}


	public List<User> getUserOrderByFollower() {
		return userDao.getUserOrderByFollower();
	}
 
	public void deleteArticleComment(Integer userArticle_id) {
		userDao.deleteArticleComment(userArticle_id);
	}
 
	public void deleteArticleReply(Integer userArticle_id) {
		userDao.deleteArticleReply(userArticle_id);
	}


	public void adminDeleteUpdate(String flag, Integer other_id) {
		 userDao.adminDeleteUpdate(flag, other_id);
	}


	public void deleteArticleCommentById(Integer id) {
		userDao.deleteArticleCommentById(id);
	}


	public void deleteArticleReplyById(Integer id) {
		userDao.deleteArticleReplyById(id);
	}
 
	

}
