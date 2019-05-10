package com.sp.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("board.faqBoardService")
public class FaqBoardServiceImpl implements FaqService{
	@Autowired
	private CommonDAO dao;

	@Override
	public List<Faq> listBoard(Map<String, Object> map) {
		List<Faq> list = null;
		
		try {
			list=dao.selectList("faq.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("faq.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Faq readBoard(int num) {
		Faq dto = null;
		
		try {
			dto=dao.selectOne("faq.readBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int insertAnswer(Faq dto) {
		int result=0;
		try {
			result=dao.insertData("faq.insertBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int updateBoard(Faq dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBoard(int num) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	


}
