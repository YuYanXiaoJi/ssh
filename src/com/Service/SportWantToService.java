package com.Service;

import java.util.List;

import com.Entity.SportWantTo;

public interface SportWantToService {
	//检查是否已点赞
	  List<SportWantTo> checkIsWant(Integer sport_id,Integer user_id);
	//删除点赞景点的信息
	  void deleteWant(Integer sport_id,Integer user_id);
	//保存用户的点赞对景点
	  void saveWant(SportWantTo sportWantTo);
	//得到一个sport的所有的点赞（为删除删除sport的时候）
	  List<SportWantTo> getOneSportAll(Integer sportId);
	 //删除一条信息（为了删除景点的时候）
	  void deleteSportWantTo(Integer id);
}
