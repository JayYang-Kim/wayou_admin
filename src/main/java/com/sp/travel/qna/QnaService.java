package com.sp.travel.qna;

import java.util.List;
import java.util.Map;

public interface QnaService {
	
	public int qnaCount(Map<String,Object> map);
	public List<TQuestion> qnaList(Map<String,Object> map);
	public List<Answer> answerList(Map<String,Object> map);
	
	public void insertAnswer(Answer answer);
	public void deleteAnswer(int answerCode);
}
