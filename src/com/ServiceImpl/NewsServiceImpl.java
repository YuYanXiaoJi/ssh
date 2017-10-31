package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
 
import com.Dao.NewsDao;
import com.Entity.News;
import com.Service.NewsService;
@Service("newsService")
public class NewsServiceImpl implements NewsService {

	@Resource
	private NewsDao newsDao;
	
	public void saveNews(News news) {
		 newsDao.saveNews(news);
	}

	public List<News> getNewsAllRead(Integer id) {
		 
		return newsDao.getNewsAllRead(id);
	}

	public List<News> getNewsAllUnread(Integer id) {
		 
		return newsDao.getNewsAllUnread(id);
	}

	public List<News> getNewsAll(Integer id) {
		 
		return  newsDao.getNewsAll(id);
	}

	public News getNewsDetail(Integer id) {
	 
		return newsDao.getNewsDetail(id);
	}

}
