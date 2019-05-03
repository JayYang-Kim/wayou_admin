package com.sp.work;

import java.util.List;
import java.util.Map;

public interface WorkService {
	public int insertWork (Work dto) throws Exception;
	public Work readAdmin (int adminIdx) throws Exception;
	public int searchWork (int adminIdx) throws Exception;
	public List<Work> listWork (Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public Work articleWork (int diaryCode) throws Exception;
	public String todayDiary () throws Exception;
	public int updateWork (Work dto) throws Exception;
	public int searchDiary (int adminIdx) throws Exception;
	public Work preArticleWork(Map<String, Object> map) throws Exception;
	public Work nextArticleWork(Map<String, Object> map) throws Exception;
	public int deleteWork (int diaryCode) throws Exception;
	
}
