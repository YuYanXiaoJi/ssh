package com.Dao;


 
import java.util.List;

import com.Entity.QuestionFocus;
 

public interface QuestionFocusDao {
		//关注问题
		void savaQuestionFocus(QuestionFocus questionFocus);
		//取消关注问题
		void deleteQuestionFocus(Integer user_id, Integer question_id);
		//查看时候已经关注了该问题
		List<QuestionFocus> search(Integer user_id, Integer question_id);
		 List<QuestionFocus> getOneQuestionFocusAll(Integer question_id);
		 //删除某一个关注  根据ID
		 void deleteQueestionFocusById(Integer id);
}
