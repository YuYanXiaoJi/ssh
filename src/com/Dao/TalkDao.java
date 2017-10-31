package com.Dao;

import java.util.List;

import com.Entity.Answer;
import com.Entity.AnswerGreat;
import com.Entity.Question;
 

public interface TalkDao {
	  //保存新问题
	  void saveQuestion(Question question);
	//删除question
	  void deleteQuestion(Integer questionId);
	 //得到 得赞 最多系列的回答 然后得到此用户  秉烛夜谈 jsp  展示
	  List<Answer> getBestAnswerTop();
	  //得到一级回答（不含回复）
	  List<Answer> getAnswerExcludeSon(Integer id);
	  //最新问题
	  List<Question> getQuestionAllByTime();
	//热门的（浏览量最多的）
	  List<Question> getQuestionElite();
	//用户推荐  得到相关的cacheTag的question
	 //即得到questionＤｅｔａｉｌ就可  ruo没有登入 或者还没有cachetag
	  List<Question> getQuestionOrderByFocus();
	
	//得到一个问题的详情
	  Question getQuestionDetailById(Integer id);
	//保存一个回复
	  void saveAnswer(Answer answer);
	  //删除一个回答
	  void deleteAnswerById(Integer id);
	//得到一个问题的所有答案
	  List<Answer> getAnswerAllToOneQuestion(Integer id);
	  //得到一条具体的answer  为了admin 删除
	  Answer getOneAnswerDetailById(Integer id);
	 
	  //得到某个人的回答对具体的一个问题
	  List<Answer> getOneAnswerToOneQuestion(Integer user_id, Integer question_id);
	  
	//得到一个father（为了展现其son）
	  Answer getOneFatherAnswer(Integer id);
	//得到其中的一个father的所有son
	  List<Answer> getSonAllOfFather(Integer id);
	//检查是否点过赞
	  List<AnswerGreat> checkIsGreat(Integer user_id, Integer answer_id);
	//保存点赞
	  void saveAnswerGreat(AnswerGreat answerGreat);
	//删除点赞
	  void deleteAnswerGreat(Integer user_id,Integer answer_id);

	  //个人主页显示   得到要给用户的所有回答
	  List<Answer> getOneUserOfAllAnswer(Integer user_id);
	  
}
