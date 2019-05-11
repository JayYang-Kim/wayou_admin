package com.sp.board;

import java.util.List;
import java.util.Map;

public interface QnaService {
	public int insertAnswer(Qna dto);
	public List<Qna> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Qna readBoard(int num);
	public int updateHitCount(int num);
	public int updateBoard(Qna dto);
	public int deleteBoard(int num);
	public int readHitCount(int num);
	
}
