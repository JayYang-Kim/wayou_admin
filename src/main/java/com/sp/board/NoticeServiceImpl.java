package com.sp.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("board.noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertNotice(Notice dto) {
		int result=0;
		try {
			result=dao.insertData("notice.insertNotice", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list = null;
		
		try {
			list = dao.selectList("notice.listNotice",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("notice.noticeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


	@Override
	public Notice readNotice(Map<String, Object> map) {
		Notice dto=null;
		
		try{
			// 게시물 가져오기
			dto=dao.selectOne("notice.readNotice", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int updateHitCount(int num) {
		// TODO Auto-generated method stub
		return 0;
	}

}
