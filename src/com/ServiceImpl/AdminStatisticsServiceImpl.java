package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.Dao.AdminStatisticsDao;
import com.Entity.PageView;
import com.Entity.SpecialScheme;
import com.Entity.SpecialSchemeUser;
import com.Entity.User;
import com.Service.AdminStatisticsService;

@Service("adminStatisticsService")
public class AdminStatisticsServiceImpl implements AdminStatisticsService {
	
	@Resource
	private AdminStatisticsDao adminStatisticsDao; 
		
	public List<PageView> getAllOrderByTime() {
		 return adminStatisticsDao.getAllOrderByTime();
	}

	public void savePageView(PageView pageView) {
		 adminStatisticsDao.savePageView(pageView);
	}

	public List<User> adminGetUserAll() {
		return adminStatisticsDao.adminGetUserAll();
	}

	public void saveSpecialScheme(SpecialScheme specialScheme) {
		adminStatisticsDao.saveSpecialScheme(specialScheme);
		
	}

	public List<SpecialScheme> getSchenmeListAll() {
		 return adminStatisticsDao.getSchenmeListAll();
	}

	public SpecialScheme getSpecialSchemeDetail(Integer id) {
		 return adminStatisticsDao.getSpecialSchemeDetail(id);
	}

	public void saveSpecialSchemeUser(SpecialSchemeUser specialSchemeUser) {
		adminStatisticsDao.saveSpecialSchemeUser(specialSchemeUser);
	}

	public List<SpecialSchemeUser> getSchemeUserAll() {
		 return adminStatisticsDao.getSchemeUserAll();
	}

}
