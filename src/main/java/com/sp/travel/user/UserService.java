package com.sp.travel.user;

import java.util.List;
import java.util.Map;

public interface UserService {
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<User> listUser(Map<String, Object> map) throws Exception;
	public User readUser(int userIdx) throws Exception;
	public User preReadUser(Map<String, Object> map) throws Exception;
	public User nextReadUser(Map<String, Object> map) throws Exception;
	
	public int dataCountBlack(Map<String, Object> map) throws Exception;
	public List<User> listBlack(Map<String, Object> map) throws Exception;
	public User readBlack(int userIdx) throws Exception;
	public User preReadBlack(Map<String, Object> map) throws Exception;
	public User nextReadBlack(Map<String, Object> map) throws Exception;
	
	public int updateBlackCount(Map<String, Object> map, int adminIdx) throws Exception;
	public List<User> listBlackCountLog(int userIdx) throws Exception;
	public List<User> allBlackCountLog(int userIdx) throws Exception;
}
