package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.Dao.SportDao;
import com.Entity.Category1;
import com.Entity.Category2;
import com.Entity.Question;
import com.Entity.Sport;
import com.Entity.SportComment;
import com.Entity.SportReply;
import com.Entity.UserArticle;
import com.Service.SportService;

@Service("sportService")
public class SportServiceImpl implements SportService {
	@Resource
	private SportDao sportDao;
	
	public void saveSport(Sport sport) {
		
		sportDao.saveSport(sport);
	}

	public List<Sport> getSportAll(String category1, String category2, String category3) {
		 
		return sportDao.getSportAll(  category1,   category2,   category3);
	}
	
	public List<Sport> getSportAllByTime() {
		return sportDao.getSportAllByTime();
	}
 

	public Sport getSportDetail(Integer id) {
		 
		return sportDao.getSportDetail(id);
	}
	
	public List<Sport> searchSportByDefault(String h) {
		 
		return sportDao.searchSportByDefault(h);
	}
	
	public List<UserArticle> searchUserArticle(String h) {
		 
		return sportDao.searchUserArticle(h);
	}
	
	public List<Question> searchQuestion(String h) {
		 
		return sportDao.searchQuestion(h);
	}
	

	public Category1 getCategory1Id(String name) {
		 
		return sportDao.getCategory1Id(name);
	}

	public Category2 getCategory2Id(String name) {
		 
		return sportDao.getCategory2Id(name);
	}

	public void saveSportComment(SportComment sportComment) {
	
		sportDao.saveSportComment(sportComment);
	}

	public List<SportComment> getSportComment(Integer id) {
		 
		return sportDao.getSportComment(id);
	}

	public List<SportReply> getSportReply(Integer id) {
		 
		return sportDao.getSportReply(id);
	}

	public void saveSportReply(SportReply sportReply) {
		 sportDao.saveSportReply(sportReply);
	}
 

	public List<Sport> getSportAllOrderBySocre() {
		return sportDao.getSportAllOrderBySocre();
	}

	public void deleteSportComment(Integer id) {
		sportDao.deleteSportComment(id);
	}

	public void deleteSportReply(Integer id) {
		sportDao.deleteSportReply(id);
	}

	public void deleteSport(Integer sportId) {
		sportDao.deleteSport(sportId);
	}

	public SportComment getSportCommentById(Integer id) {
		return sportDao.getSportCommentById(id);
	}

	

 

	
 

}
