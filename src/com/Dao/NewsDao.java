package com.Dao;

import java.util.List;

import com.Entity.News;

public interface NewsDao {
	public void saveNews(News news);
	
	public List<News> getNewsAllRead(Integer id);
	public List<News> getNewsAllUnread(Integer id);
	
	public List<News> getNewsAll(Integer id);
	
	public News getNewsDetail(Integer id); 
}
