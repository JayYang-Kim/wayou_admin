package com.sp.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("ticket.QnAboardService")
public class QnaServiceImpl implements QnaService{
	@Autowired
	private CommonDAO dao;
	@Override
	public int insertAnswer(Qna dto) {
		int result=0;
		try {
			result=dao.insertData("qna.insertAnswer", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Qna> listBoard(Map<String, Object> map) {
		List<Qna> list = null;
		
		try {
			list=dao.selectList("qna.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("qna.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Qna readBoard(int num) {
		Qna dto = null;
		
		try {
			dto=dao.selectOne("qna.readBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateHitCount(int num) {
		int result=0;
		
		try {
			result=dao.updateData("qna.updateHitCount", num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int updateBoard(Qna dto) {
		int result=0;
		
		try {
			result=dao.updateData("qna.updateBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deleteBoard(int num) {
		int result=0;
		
		try {
			result=dao.deleteData("qna.deleteBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int readHitCount(int num) {
		int result=0;
		
		try {
			result=dao.selectOne("qna.readHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
