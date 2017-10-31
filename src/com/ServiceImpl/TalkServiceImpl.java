package com.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Dao.TalkDao;
 
import com.Entity.Answer;
import com.Entity.AnswerGreat;
import com.Entity.Question;
import com.Service.TalkService;
@Service("talkService")
public class TalkServiceImpl implements TalkService {
	
	@Autowired
	private TalkDao talkDao;
	
	public void saveQuestion(Question question) {
		 talkDao.saveQuestion(question);

	}

	public List<Question> getQuestionAllByTime() {
		 
		return talkDao.getQuestionAllByTime();
	}

	public List<Question> getQuestionElite() {
		 
		return talkDao.getQuestionElite();
	}

	public Question getQuestionDetailById(Integer id) {
		 
		return talkDao.getQuestionDetailById(id);
	}

	public void saveAnswer(Answer answer) {
		talkDao.saveAnswer(answer);
	}

	public List<Answer> getAnswerAllToOneQuestion(Integer id) {
		 
		return talkDao.getAnswerAllToOneQuestion(id);
	}

	public Answer getOneFatherAnswer(Integer id) {
		 
		return talkDao.getOneFatherAnswer(id);
	}

	public List<Answer> getSonAllOfFather(Integer id) {
		 
		return talkDao.getSonAllOfFather(id);
	}

	public List<AnswerGreat> checkIsGreat(Integer user_id, Integer answer_id) {
		
		return talkDao.checkIsGreat(user_id, answer_id);
	}

	public void saveAnswerGreat(AnswerGreat answerGreat) {
		talkDao.saveAnswerGreat(answerGreat);
		
	}

	public void deleteAnswerGreat(Integer user_id, Integer answer_id) {
		talkDao.deleteAnswerGreat(user_id, answer_id);
		
	}

	public List<Answer> getAnswerExcludeSon(Integer id) {
		 
		return  talkDao.getAnswerExcludeSon(id);
	}

	public List<Answer> getBestAnswerTop() {
		 
		return talkDao.getBestAnswerTop();
	}

	public List<Answer> getBestAnswer() {
		
		return talkDao.getBestAnswerTop();
	}

	public List<Answer> getOneAnswerToOneQuestion(Integer user_id,
			Integer question_id) {
		
		return talkDao.getOneAnswerToOneQuestion(user_id, question_id);
	}

	public List<Answer> getOneUserOfAllAnswer(Integer user_id) {
		  return  talkDao.getOneUserOfAllAnswer(user_id);
	}

	public List<Question> getQuestionOrderByFocus() {
	  return  talkDao.getQuestionOrderByFocus();
	}

	public void deleteAnswerById(Integer id) {
		talkDao.deleteAnswerById(id);
	}

	public void deleteQuestion(Integer questionId) {
		talkDao.deleteQuestion(questionId);
	}

	public Answer getOneAnswerDetailById(Integer id) {
		 
		return talkDao.getOneAnswerDetailById(id);
	}
 

}
