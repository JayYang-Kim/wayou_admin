package com.sp.board;

import java.util.List;
import java.util.Map;

public interface FaqService {
	public List<Faq> listBoard(Map<String, Object> map);
	public int insertAnswer(Faq dto);
	public int updateBoard(Faq dto);
	public int deleteBoard(int num);
	public int dataCount(Map<String, Object> map);
	public Faq readBoard(int num);
}
