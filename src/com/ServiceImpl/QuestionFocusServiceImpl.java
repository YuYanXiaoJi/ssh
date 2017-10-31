package com.ServiceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.Dao.QuestionFocusDao;
import com.Entity.QuestionFocus;
import com.Service.QuestionFocusService;
@Service("questionFocusService")
public class QuestionFocusServiceImpl implements QuestionFocusService {
	
	@Resource 
	private QuestionFocusDao questionFocusDao;
	public void savaQuestionFocus(QuestionFocus questionFocus) {
		 questionFocusDao.savaQuestionFocus(questionFocus);

	}

	public void deleteQuestionFocus(Integer user_id, Integer question_id) {
		 questionFocusDao.deleteQuestionFocus(user_id, question_id);

	}

	public List<QuestionFocus> search(Integer user_id, Integer question_id) {
		 
		return questionFocusDao.search(user_id, question_id);
	}

	public List<QuestionFocus> getOneQuestionFocusAll(Integer question_id) {
		 return questionFocusDao.getOneQuestionFocusAll(question_id);
	}

	public void deleteQueestionFocusById(Integer id) {
		questionFocusDao.deleteQueestionFocusById(id);
	}

}
