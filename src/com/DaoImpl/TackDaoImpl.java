package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.TalkDao;
import com.Entity.Answer;
import com.Entity.AnswerGreat;
import com.Entity.Question;
@Repository("talkDao")
public class TackDaoImpl implements TalkDao {

	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	public void saveQuestion(Question question) {
		 getSession().saveOrUpdate(question);
	}

	@SuppressWarnings("unchecked")
	public List<Question> getQuestionAllByTime() {
		String hql = "from Question order by time desc";
		return getSession().createQuery(hql).list();
	}

	@SuppressWarnings("unchecked")
	public List<Question> getQuestionElite() {
		 String hql = "from Question order by pageView desc";
		return getSession().createQuery(hql).list();
	}
	
	 
	@SuppressWarnings("unchecked")
	public List<Question> getQuestionOrderByFocus() {
		String hql = "from Question order by focusCount desc";
		return getSession().createQuery(hql).list();
	}

 
	public Question getQuestionDetailById(Integer id) {
		String hql = "from Question where id = ?0";
		return (Question) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}

	public void saveAnswer(Answer answer) {
		getSession().saveOrUpdate(answer);
		
	}

	@SuppressWarnings("unchecked")
	public List<Answer> getAnswerAllToOneQuestion(Integer id) {
		String hql = "from Answer where question_id = ?0 order by greatCount desc ";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Answer> getOneAnswerToOneQuestion(Integer user_id,
			Integer question_id) {
		String hql = "from Answer where user.id = ?0 and question_id = ?1";
		return getSession().createQuery(hql).setInteger("0", user_id).setInteger("1", question_id).list();
	}
	

	public Answer getOneFatherAnswer(Integer id) {
		String hql = "from Answer where id = ?0";
		return (Answer) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}

	@SuppressWarnings("unchecked")
	public List<Answer> getSonAllOfFather(Integer id) {
		String hql = "from Answer where father_id = ?0 and flag = 1";
		return getSession().createQuery(hql).setInteger("0", id).list();
	}

	@SuppressWarnings("unchecked")
	public List<AnswerGreat> checkIsGreat(Integer user_id, Integer answer_id) {
		String hql = "from AnswerGreat where user.id = ?0 and answer.id = ?1";
		return getSession().createQuery(hql).setInteger("0", user_id).setInteger("1", answer_id).list();
	}

	public void saveAnswerGreat(AnswerGreat answerGreat) {
		getSession().saveOrUpdate(answerGreat);
		
	}

	public void deleteAnswerGreat(Integer user_id, Integer answer_id) {
		 String hql = "delete from AnswerGreat where user.id = ?0 and answer.id = ?1";
		 getSession().createQuery(hql).setInteger("0", user_id).setInteger("1", answer_id).executeUpdate();
		
	}

	@SuppressWarnings("unchecked")
	public List<Answer> getAnswerExcludeSon(Integer id) {
		String hql = "from Answer where question_id = ?0 and flag = ?1 order by greatCount desc ";
		return getSession().createQuery(hql).setInteger("0", id).setInteger("1", 0).list();
	}

	@SuppressWarnings("unchecked")
	public List<Answer> getBestAnswerTop() {
		String hql = "from Answer   where flag = 0 order by greatCount desc";
		return getSession().createQuery(hql).list();
	}

	@SuppressWarnings("unchecked")
	public List<Answer> getOneUserOfAllAnswer(Integer user_id) {
		String hql = "from Answer where user.id = ?0 and flag = 0 order by time desc";
		return getSession().createQuery(hql).setInteger("0", user_id).list();
	}

	public void deleteAnswerById(Integer id) {
		String hql = "delete from Answer where id = ?0";
		getSession().createQuery(hql).setInteger("0", id).executeUpdate();
		
	}

	public void deleteQuestion(Integer questionId) {
		String hql = "delete from Question where id = ?0";
		getSession().createQuery(hql).setInteger("0", questionId).executeUpdate();
	}

	public Answer getOneAnswerDetailById(Integer id) {
		String hql = "from Answer where id = ?0";
		return (Answer) getSession().createQuery(hql).setInteger("0", id).list().get(0);
	}
 

}
