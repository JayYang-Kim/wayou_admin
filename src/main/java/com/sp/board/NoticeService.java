package com.sp.board;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	public int insertNotice(Notice dto);
	public List<Notice> listNotice(Map<String , Object> map);
	public int dataCount(Map<String, Object> map);
	public Notice readNotice(int num);
	public int updateHitCount(int num);
}
