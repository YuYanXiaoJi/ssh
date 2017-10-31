package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
 
import com.Dao.SportWantToDao;
import com.Entity.SportWantTo;
import com.Service.SportWantToService;

@Service("sportWantToService")
public class SportWantToServiceImpl implements SportWantToService {

	@Resource
	private SportWantToDao sportWantToDao;
	
	public List<SportWantTo> checkIsWant(Integer sport_id, Integer user_id) {
		 
		return sportWantToDao.checkIsWant(sport_id, user_id);
	}

	public void deleteWant(Integer sport_id, Integer user_id) {
		 sportWantToDao.deleteWant(sport_id, user_id);
	}

	public void saveWant(SportWantTo sportWantTo) {
		sportWantToDao.saveWant(sportWantTo);

	}

	public List<SportWantTo> getOneSportAll(Integer sportId) {
	 
		return  sportWantToDao.getOneSportAll(sportId);
	}

	public void deleteSportWantTo(Integer id) {
		sportWantToDao.deleteSportWantTo(id);
	}

}
