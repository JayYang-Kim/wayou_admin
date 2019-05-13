package com.sp.travel.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("travelQna.qnaService")
public class QnaServiceImpl implements QnaService{

	
	@Autowired
	private SqlSession sqlsession;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public List<TQuestion> qnaList(Map<String,Object> map) {
		System.out.println("service에서 : "+map);
		List<TQuestion> list = null;
		try {
			list = sqlsession.selectList("travelQna.qnaList",map);
		}catch (Exception e) {
			logger.error(e.toString());
		}
		return list;
	}

	@Override
	public List<Answer> answerList(Map<String,Object> map) {
		List<Answer> list = null;
		try {
			list = sqlsession.selectList("travelQna.answerList",map);
		}catch (Exception e) {
			logger.error(e.toString());
		}
		return list;
	}


	@Override
	public void insertAnswer(Answer answer) {
		try {
			sqlsession.insert("travelQna.insertAnswer", answer);
		}catch (Exception e) {
			logger.error(e.toString());
		}
	}

	@Override
	public void deleteAnswer(int answerCode) {
		try {
			sqlsession.delete("travelQna.deleteAnswer", answerCode);
		}catch (Exception e) {
			logger.error(e.toString());
		}
	}

	@Override
	public int qnaCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = sqlsession.selectOne("travelQna.qnaCount",map);
		}catch (Exception e) {
			logger.error(e.toString());
		}
		return result;
	}
	
	
	
}
