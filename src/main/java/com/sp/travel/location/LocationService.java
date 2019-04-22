package com.sp.travel.location;

import java.util.List;
import java.util.Map;

public interface LocationService {
	public List<Location> locList() throws Exception;
	public int insertLocation(Location dto, String pathName) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Location> locationList(Map<String, Object> map) throws Exception;
	public Location readLocation(int locCode) throws Exception;
	public Location preReadLocation(Map<String, Object> map) throws Exception;
	public Location nextReadLocation(Map<String, Object> map) throws Exception;
	public int updateLocation(Location dto, String pathname) throws Exception;
	public int deleteLocation(int locCode, String pathname) throws Exception;
	
	public List<Location> listLocationLog(int locCode) throws Exception;
	public List<Location> allLocationLog(int locCode) throws Exception;
}
