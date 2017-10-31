package com.Dao;

import java.util.List;

import com.Entity.User;
import com.Entity.UserArticle;
import com.Entity.UserFocus;
import com.Entity.UserUpdate;



public interface UserDao {

	  List<User> loginValid(String username,String password);
	  List<User> registValid(String username);
	  void saveUser(User user);
	  List<User> getUserById(Integer id);
	  List<User> getUserByName(String Username);
	
	//文章操作
	  void saveUserArticle(UserArticle userArticle);
	  //得到user的不是草稿的所有的文章
	 List<UserArticle> getUserArticleAll(String username);
	 //得到user的draft
	 List<UserArticle> getUserDraft(String username);
	 //删除文章
	 void deletUserArticle (Integer userArticle_id);
	//删除一级评论(通过文章id)
	 void deleteArticleComment(Integer userArticle_id);
	 //删除二级评论
	 void deleteArticleReply(Integer userArticle_id);
	//删除一级评论(通过id)
	 void deleteArticleCommentById(Integer id);
	 //删除二级评论
	 void deleteArticleReplyById(Integer id);
	
	//下面的是对于用户动态的记录
	void saveUserUpdate(UserUpdate userUpdate);
	//删除所有有关一个other的动态（比如admin删除了一个问题，这个问题下的回答 关注  动态都需要删除）
	void adminDeleteUpdate(String flag, Integer other_id);
	//如果用户取消了点赞等等  就删除用户的动态信息
	void deleteUserUpdate(String flag, Integer other_id, Integer owner_id);//因为不知道userUpdate的ID  否则直接deleteUserUpdate(UserUpdate userUpdate)
	
	//得到用户的所有动态
	List<UserUpdate> getUserUpdate(Integer user_id);
	//发表文章的动态
	 List<UserUpdate> getUserUpdateBlog(Integer user_id);
	//回答问题的动态
	 List<UserUpdate> getUserUpdateAnswer(Integer user_id);
	//得到用户的提出的问题的动态
	List<UserUpdate> getUserUpdateQuestion(Integer user_id);
	//得到关注的问题的动态
	List<UserUpdate> getUserUpdateFocusQuestion(Integer user_id);
	//得到following
	List<UserFocus>  getUserFocusFollowing(Integer user_id);
	//得到follower
	List<UserFocus> getUserFocusFollower(Integer targetUser_id);
	
	//保存用户1对用户2的关注
	void saveUserFocus(UserFocus userFocus);
	//取消用户1对用户2的关注
	void deletUserFocus(Integer user_id, Integer targetUser_id);
	//查看是否存在用户1 对用户2的关注
	List<UserFocus> checkUserFocus(Integer user_id, Integer targetUser_id);
	
	//得到比较多的用户关注的人
	List<User> getUserOrderByFollower();

}
