package com.Service;

import java.util.List;

import com.Entity.PageView;
import com.Entity.SpecialScheme;
import com.Entity.SpecialSchemeUser;
import com.Entity.User;

public interface AdminStatisticsService {
	//得到每日新增信息
	 List<PageView> getAllOrderByTime();
	 //保存每天的新增信息
     void savePageView(PageView pageView);
   //admin 获得user  列表
 	List<User> adminGetUserAll();
 	//保存特别策划
 	void saveSpecialScheme(SpecialScheme specailScheme);
	//得到所有的
	List<SpecialScheme> getSchenmeListAll();
	//得到一条的detail
	SpecialScheme getSpecialSchemeDetail(Integer id);
	//保存用户报名
	 void saveSpecialSchemeUser(SpecialSchemeUser specialSchemeUser);
	//得到用户报名情况
	 List<SpecialSchemeUser> getSchemeUserAll();
}
