package com.Service;

import java.util.List;

import com.Entity.QuestionFocus;

public interface QuestionFocusService {
	 //关注问题
	 void savaQuestionFocus(QuestionFocus questionFocus);
	 //取消关注问题
	 void deleteQuestionFocus(Integer user_id, Integer question_id);
	//查看时候已经关注了该问题
	 List<QuestionFocus> search(Integer user_id, Integer question_id);
	 //得到某个问题的所有关注
	 List<QuestionFocus> getOneQuestionFocusAll(Integer question_id);
	 //删除某一个关注  根据ID
	 void deleteQueestionFocusById(Integer id);
}
