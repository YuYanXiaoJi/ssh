package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
 
import com.Dao.OtherToTagDao;
import com.Entity.OtherToTag;
import com.Entity.Tag;
import com.Service.OtherToTagService;
@Service("otherToTagService")
public class OtherToTagServiceImpl implements OtherToTagService {

	@Resource
	private OtherToTagDao otherToTagDao;
	

	public Tag getTagById(Integer id) {
		return otherToTagDao.getTagById(id);
	}

	public List<Tag> getTagAllDesc() {
		 
		return otherToTagDao.getTagAllDesc();
	}

	public void saveTag(Tag tag) {
		 otherToTagDao.saveTag(tag);
		
	}

	public void saveOtherToTag(OtherToTag otherToTag) {
		otherToTagDao.saveOtherToTag(otherToTag);
		
	}
 

	public List<Tag> getTagIdByName(String tag_name) {
		 
		return otherToTagDao.getTagIdByName(tag_name);
	}

	public List<OtherToTag> getOtherToTagByOtherAll(Integer otherId, String flag) {
		
		return otherToTagDao.getOtherToTagByOtherAll(otherId, flag);
	}

	public void deleteOtherToTag(OtherToTag otherToTag) {
		otherToTagDao.deleteOtherToTag(otherToTag);
	}
	
	public void delteArticleToTag(Integer otherId , String flag) {
		otherToTagDao.delteArticleToTag(otherId, flag);
	}

	public List<OtherToTag> getOtherForRecommend(String flag, Integer tagId) {
		return otherToTagDao.getOtherForRecommend(flag, tagId);
	}

	public List<OtherToTag> getOtherAllByTagId(Integer tag_id) {
		 return otherToTagDao.getOtherAllByTagId(tag_id);
	}
	
	 

}
