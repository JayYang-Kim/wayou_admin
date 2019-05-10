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
	public int insertBoard(Qna dto) {
		int result=0;
		try {
			result=dao.insertData("tqna.insertBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Qna> listBoard(Map<String, Object> map) {
		List<Qna> list = null;
		
		try {
			list=dao.selectList("tqna.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("tqna.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Qna readBoard(int num) {
		Qna dto = null;
		
		try {
			dto=dao.selectOne("tqna.readBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateHitCount(int num) {
		int result=0;
		
		try {
			result=dao.updateData("tqna.updateHitCount", num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int updateBoard(Qna dto) {
		int result=0;
		
		try {
			result=dao.updateData("tqna.updateBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deleteBoard(int num) {
		int result=0;
		
		try {
			result=dao.deleteData("tqna.deleteBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int readHitCount(int num) {
		int result=0;
		
		try {
			result=dao.selectOne("tqna.readHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
