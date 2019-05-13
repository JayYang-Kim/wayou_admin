package com.sp.board;

import java.util.List;
import java.util.Map;

public interface FaqService {
	public List<Faq> listFaq(Map<String, Object> map);
	public int insertFaq(Faq dto);
	public int updateBoard(Faq dto);
	public int deleteBoard(int num);
	public int dataCount(Map<String, Object> map);
	public Faq readBoard(int num);
}
