package com.sp.work;

import java.util.List;
import java.util.Map;

public interface WorkService {
	public int insertWork (Work dto) throws Exception;
	public Work readAdmin (int AdminIdx) throws Exception;
	public int searchWork (int AdminIdx) throws Exception;
	public List<Work> listWork (Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
}
