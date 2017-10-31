package com.Service;

import java.util.List;

import com.Entity.CacheTag;

public interface CacheTagService {
	//保存cache
	 void save(CacheTag cacheTag);
	//得到user的已经有的cachetag
	 List<CacheTag> getUserCacheTagList(Integer userId);
}
