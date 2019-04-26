package com.sp.travel.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("travel.user.userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private CommonDAO dao;

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("travel.user.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<User> listUser(Map<String, Object> map) throws Exception {
		List<User> list = null;
		
		try {
			list = dao.selectList("travel.user.listUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public User readUser(int userIdx) throws Exception {
		User dto = null;
		
		try {
			dto = dao.selectOne("travel.user.readUser", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public User preReadUser(Map<String, Object> map) throws Exception {
		User dto = null;
		
		try {
			dto = dao.selectOne("travel.user.preReadUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public User nextReadUser(Map<String, Object> map) throws Exception {
		User dto = null;
		
		try {
			dto = dao.selectOne("travel.user.nextReadUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int updateBlackCount(int userIdx) throws Exception {
		int result = 0;
		
		try {
			result = dao.updateData("travel.user.updateBlackCount", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int insertBlackCountLog(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.insertData("travel.user.insertBlackCountLog", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}
}
