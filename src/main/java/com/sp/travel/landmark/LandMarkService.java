package com.sp.travel.landmark;

import java.util.List;
import java.util.Map;

public interface LandMarkService {
	public List<LandMark> listLocation() throws Exception;
	public List<LandMark> listTag() throws Exception;
	public int insertLandMark(LandMark dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<LandMark> listLandMark(Map<String, Object> map) throws Exception;
	public LandMark readLandMark(int landCode) throws Exception;
	public LandMark preReadLandMark(Map<String, Object> map) throws Exception;
	public LandMark nextReadLandMark(Map<String, Object> map) throws Exception;
	public int updateLandMark(LandMark dto, String pathname) throws Exception;
	public int deleteLandMark(int landCode, String pathname) throws Exception;
	
	public int insertFile(LandMark dto) throws Exception;
	public List<LandMark> listFile(int num) throws Exception;
	public LandMark readFile(int fileNum) throws Exception;
	public int deleteFile(Map<String, Object> map) throws Exception;
	
	public List<LandMark> listLandMarkLog(int landCode) throws Exception;
	public List<LandMark> allLandMarkLog(int landCode) throws Exception;
}
