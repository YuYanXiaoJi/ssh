package com.Action;

 

import java.util.HashMap;
import java.util.List;
import java.util.Map;
 

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.Entity.CacheTag;
import com.Entity.User;
import com.Service.CacheTagService;
import com.Service.UserService;
 
@Controller("cacheTagAction")
@Scope("prototype")
public class CacheTagAction  {
 
	@Resource
	private UserService userService;
	@Resource
	private CacheTagService cacheTagService;
	
	//进行用户cache保存
	void saveCacheTag(String tagId){
		//tagId 每一篇文章的id 如  3/4/12
		String []tempTagId = tagId.split("/");
		
		String name = (String)ServletActionContext.getRequest().getSession().getAttribute("name");
		if(name == null) return;
		User user = userService.getUserByName(name);
		//得到原有的这个作者的cacheTag
		List<CacheTag> cacheTagList = cacheTagService.getUserCacheTagList(user.getId());
		
		/*new 5条  old 5条
		 * 会有这样的情况：1.new没有满 old也必定没有满  直接插入  2.new满了 old没满  需要将一条new 变成old 再插入数据
		 * 			  3.new满了old也满了  将一条old信息   去掉（即update）成新的这条
		 * 计数相加原则：如果已经存在这条信息  1.再new中 --->count加一   2.在old中--->flag变成new count不加一 查看是不是需要去掉old降级一个new等等
		 */
		
		//是否已经存在map<tagid,new/old>
		Map<Integer, CacheTag> mapNew = new HashMap<Integer, CacheTag>();
		Map<Integer, CacheTag> mapOld = new HashMap<Integer, CacheTag>();
		
		for(CacheTag var : cacheTagList) {
			if(var.getFlag().equals("new")) {
				mapNew.put(var.getTagId(), var);
			}else {
				mapOld.put(var.getTagId(), var);
			}
		}
		
		for(int i = 0; i < tempTagId.length; i++) {
			
			Integer tag_id = Integer.parseInt(tempTagId[i]);
			
			if(mapNew.containsKey(tag_id)) {
				CacheTag tempCacheTag = mapNew.get(tag_id);
				tempCacheTag.setCount(tempCacheTag.getCount() + 1);
				cacheTagService.save(tempCacheTag);
			}else if(mapOld.containsKey(Integer.parseInt(tempTagId[i]))) {
				//有这条记录 不过是old 需要变成new
				CacheTag tempCacheTag = mapOld.get(tag_id);
				tempCacheTag.setFlag("new");
				
				if(mapNew.size() < 5){ //直接从old 变成  new（条数max-5） 
					mapNew.put(tag_id, tempCacheTag);
					mapOld.remove(tag_id);
					cacheTagService.save(tempCacheTag);
				} else {//需要从new中找到一条降级为old
					int count = Integer.MAX_VALUE;
					CacheTag minCacheTag = new CacheTag();
					for(Integer var : mapNew.keySet()) {
						if(mapNew.get(var).getCount() <= count) {
							minCacheTag = mapNew.get(var);  //需腰降级的new
						}
					}
					if(mapOld.size() < 5){ //将直接降级bian old
						minCacheTag.setFlag("old");
						cacheTagService.save(minCacheTag);//保存降级的new
						cacheTagService.save(tempCacheTag);//保存升级的old
						mapOld.put(minCacheTag.getTagId(), minCacheTag);
						mapNew.remove(minCacheTag.getId());
						mapNew.put(tag_id, tempCacheTag);
						mapOld.remove(tag_id);
					}else {
						//升级的old和降级的new互相换就可以（old 满了）
					 
						mapNew.remove(minCacheTag.getTagId());
						mapOld.remove(tag_id);//移除升级的old 的ID
						
						minCacheTag.setFlag("old");
						cacheTagService.save(minCacheTag);//保存降级的new
						
						cacheTagService.save(tempCacheTag);//保存升级的old
 
						mapOld.put(minCacheTag.getTagId(), minCacheTag);
						mapNew.put(tag_id, tempCacheTag);
					}
				}
				
			}else {
				//如果之前不存在这个tag
				//new 是否满了
				if(mapNew.size() < 5) {
					CacheTag tempCacheTag = new CacheTag(tag_id, user.getId(), 0, "new");
					mapNew.put(tag_id, tempCacheTag);
					cacheTagService.save(tempCacheTag);
				}else {
					//将new中的一个转变成old
					//找到点击量最小的new变成old
					int count = Integer.MAX_VALUE;
					CacheTag minCacheTag = new CacheTag();
					for(Integer var : mapNew.keySet()) {
						if(mapNew.get(var).getCount() <= count) {
							minCacheTag = mapNew.get(var);//需要降级的new
						}
					}
 
					 if((mapOld.size()) < 5){
						//保存新的这个new  如果old 没满
						 CacheTag tempCacheTag = new CacheTag(tag_id, user.getId(), 0, "new");
						 
						 mapNew.put(tag_id, tempCacheTag);
						 mapNew.remove(minCacheTag.getTagId());
						 mapOld.put(minCacheTag.getTagId(), minCacheTag);
						 minCacheTag.setFlag("old");

						 cacheTagService.save(minCacheTag);//保存降级的new

						 cacheTagService.save(tempCacheTag);//保存新的new
					 }else {
						 //找到需要去掉的这个old (内容替换成 新的这个new)
						 	count = Integer.MAX_VALUE;
						 	CacheTag minCacheTag2 = new CacheTag();
							for(Integer var : mapOld.keySet()) {
								if(mapOld.get(var).getCount() <= count) {
									minCacheTag2 = mapOld.get(var);//找到需要淘汰的old
								}
							}
							
							mapOld.remove(minCacheTag2.getTagId());
 
							minCacheTag2.setFlag("new");
							minCacheTag2.setCount(0);
							minCacheTag2.setTagId(tag_id);

							cacheTagService.save(minCacheTag2);//保存新的这个new
							minCacheTag.setFlag("old");

							cacheTagService.save(minCacheTag);//需要降级的new
							
							mapNew.remove(minCacheTag.getTagId());
							mapNew.put(tag_id, minCacheTag2);
							mapOld.put(minCacheTag.getTagId(), minCacheTag);
					 }
					
				}

			}
		}

	}
}
