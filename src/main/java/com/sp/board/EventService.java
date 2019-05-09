package com.sp.board;

import java.util.List;
import java.util.Map;

public interface EventService {
	public int insertEvent(Event dto, String pathname);
	public List<Event> listEvent(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Event readEvent(Map<String, Object> map);
	public Event updateReadEvent(int num);
	public Event deleteReadEvent(int num);
	
	public Event preReadBoard(Map<String, Object> map);
	public Event nextReadBoard(Map<String, Object> map);
	public int updateBoard(Event dto, String pathname);
	public int deleteBoard(int num, String pathname, String saveFilename);
	
	public int insertBoardLike(Map<String, Object> map);
	public int boardLikeCount(int num);
	
	
	public List<EventReply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public int deleteReply(Map<String, Object> map);
	
	public List<EventReply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	public int insertReplyLike(Map<String, Object> map);
	public Map<String, Object> replyLikeCount(Map<String, Object> map);
	
}


