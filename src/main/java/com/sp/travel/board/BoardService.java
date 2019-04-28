package com.sp.travel.board;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public int insertNotice(Board dto, String pathname) throws Exception;
	public int dataCountNotice(Map<String, Object> map) throws Exception;
	public List<Board> listNotice(Map<String, Object> map) throws Exception;
	public Board readNotice(int notiCode) throws Exception;
	public Board preReadNotice(Map<String, Object> map) throws Exception;
	public Board nextReadNotice(Map<String, Object> map) throws Exception;
	public int updateNotice(Board dto, String pathname) throws Exception;
	public int deleteNotice(int notiCode, String pathname) throws Exception;
	
	public int insertNoticeFile(Board dto) throws Exception;
	public List<Board> listNoticeFile(int notiCode) throws Exception;
	public Board readNoticeFile(int fileCode) throws Exception;
	public int deleteNoticeFile(int fileCode) throws Exception;
	public int deleteAllNoticeFile(int notiCode) throws Exception;
}
