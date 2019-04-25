package com.sp.travel.user;

import java.util.List;
import java.util.Map;

public interface UserService {
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<User> listUser(Map<String, Object> map) throws Exception;
	public User readUser(int userIdx) throws Exception;
	public User preReadUser(Map<String, Object> map) throws Exception;
	public User nextReadUser(Map<String, Object> map) throws Exception;
	
	public int updateBlackCount(int userIdx) throws Exception;
	public int insertBlackCountLog(Map<String, Object> map) throws Exception;
}
