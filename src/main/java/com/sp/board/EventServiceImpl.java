package com.sp.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("board.eventService")
public class EventServiceImpl implements EventService{
	@Autowired
	private CommonDAO  dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertEvent(Event dto, String pathname) {
		int result=0;
		try{
			
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			
			result=dao.insertData("event.insertEvent", dto);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list=null;
		
		try{
			list=dao.selectList("event.listEvent", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try{
			result=dao.selectOne("event.eventCount", map);			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Event readEvent(Map<String, Object> map) {
		Event dto=null;
		
		try{
			// 게시물 가져오기
			dto=dao.selectOne("event.readEvent", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	
	@Override
	public Event preReadBoard(Map<String, Object> map) {
		Event dto=null;
		
		try{
			dto=dao.selectOne("bbs.preReadBoard", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;

	}

	@Override
	public Event nextReadBoard(Map<String, Object> map) {
		Event dto=null;
		
		try{
			dto=dao.selectOne("bbs.nextReadBoard", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public int updateBoard(Event dto, String pathname) {
		int result=0;

		try{
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename != null) {
				if(dto.getSaveFilename()!=null && dto.getSaveFilename().length()!=0)
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			
			dao.updateData("bbs.updateBoard", dto);
			result=1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int deleteBoard(int num, String pathname, String saveFilename) {
		int result=0;

		try{
			if(saveFilename!=null)
				fileManager.doFileDelete(saveFilename, pathname);
			
			dao.deleteData("bbs.deleteBoard", num);
			result=1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<EventReply> listReply(Map<String, Object> map) {
		List<EventReply> list=null;
		try {
			list=dao.selectList("event.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("event.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int deleteReply(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("event.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<EventReply> listReplyAnswer(int answer) {
		List<EventReply> list=null;
		try {
			list=dao.selectList("event.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result=0;
		try {
			result=dao.selectOne("event.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertReplyLike(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.insertData("event.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		Map<String, Object> countMap=null;
		try {
			countMap=dao.selectOne("event.replyLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countMap;
	}

	@Override
	public int insertBoardLike(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.insertData("event.insertEventLike", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int boardLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("event.EventLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	@Override
	public Event updateReadEvent(int num) {
		Event dto=null;
		
		try{
			dto=dao.selectOne("event.readEvent", num);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
	@Override
	public Event deleteReadEvent(int num) {
		Event dto=null;
		
		try{
			dto=dao.selectOne("event.readEvent", num);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}
