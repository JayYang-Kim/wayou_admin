package com.sp.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("board.faqService")
public class FaqServiceImpl implements FaqService{
	@Autowired
	private CommonDAO dao;

	@Override
	public List<Faq> listFaq(Map<String, Object> map) {
		List<Faq> list = null;
		
		try {
			list=dao.selectList("faq.listFaq", map);
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
	public Faq readBoard(Map<String, Object> map) {
		Faq dto = null;
		
		try {
			dto=dao.selectOne("faq.readBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int insertFaq(Faq dto) {
		int result=0;
		try {
			result=dao.insertData("faq.insertFaq", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int updatefaq(Faq dto) {
		int result=0;
		
		try{
			result=dao.selectOne("faq.updateFaq", dto);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deleteBoard(int num) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	


}
