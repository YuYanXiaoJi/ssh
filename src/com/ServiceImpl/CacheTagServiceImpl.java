package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.Dao.CacheTagDao;
import com.Entity.CacheTag;
import com.Service.CacheTagService;
@Service("cacheTagService")
public class CacheTagServiceImpl implements CacheTagService {

	@Resource
	private CacheTagDao cacheTagDao;
		
	public void save(CacheTag cacheTag) {
		 cacheTagDao.save(cacheTag);
	}

	public List<CacheTag> getUserCacheTagList(Integer userId) { 
		return cacheTagDao.getUserCacheTagList(userId);
	}

}
