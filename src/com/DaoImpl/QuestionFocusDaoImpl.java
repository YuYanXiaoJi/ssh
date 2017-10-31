package com.DaoImpl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.Dao.QuestionFocusDao;
 
import com.Entity.QuestionFocus;
 

@Repository("questionFocusDao")
public class QuestionFocusDaoImpl implements QuestionFocusDao {

	@Resource
	private SessionFactory sessionFactory;
 
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	public void savaQuestionFocus(QuestionFocus questionFocus) {
		getSession().saveOrUpdate(questionFocus);
	}

	public void deleteQuestionFocus(Integer user_id, Integer question_id) {
		String hql = "delete from QuestionFocus where user.id = ?0 and question.id = ?1";
		getSession().createQuery(hql).setInteger("0", user_id).setInteger("1", question_id).executeUpdate();

	}

	@SuppressWarnings("unchecked")
	public List<QuestionFocus> search(Integer user_id, Integer question_id) {
		String hql = "from QuestionFocus where user.id = ?0 and question.id = ?1";
		return getSession().createQuery(hql).setInteger("0", user_id).setInteger("1", question_id).list();
	}

	@SuppressWarnings("unchecked")
	public List<QuestionFocus> getOneQuestionFocusAll(Integer question_id) {
		String hql = "from QuestionFocus where question.id = ?0";
		return getSession().createQuery(hql).setInteger("0",question_id).list();
	}

	public void deleteQueestionFocusById(Integer id) {
		 String hql = "delete QuestionFocus where id = ?0";
		 getSession().createQuery(hql).setInteger("0", id).executeUpdate();
	}

}
