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
	public int dataCountBlack(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("travel.user.dataCountBlack", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<User> listBlack(Map<String, Object> map) throws Exception {
		List<User> list = null;
		
		try {
			list = dao.selectList("travel.user.listBlack", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public User readBlack(int userIdx) throws Exception {
		User dto = null;
		
		try {
			dto = dao.selectOne("travel.user.readBlack", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public User preReadBlack(Map<String, Object> map) throws Exception {
		User dto = null;
		
		try {
			dto = dao.selectOne("travel.user.preReadBlack", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public User nextReadBlack(Map<String, Object> map) throws Exception {
		User dto = null;
		
		try {
			dto = dao.selectOne("travel.user.nextReadBlack", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int updateBlackCount(Map<String, Object> map, int adminIdx) throws Exception {
		int result = 0;
		
		try {
			dao.updateData("travel.user.updateBlackCount", map);
			result = dao.selectOne("travel.user.readBlackCount", map);
			
			User dto = dao.selectOne("travel.user.readUser", map);
			dto.setAdminIdx(adminIdx);
			
			dao.insertData("travel.user.insertBlackCountLog", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public List<User> listBlackCountLog(int userIdx) throws Exception {
		List<User> list = null;
		
		try {
			list = dao.selectList("travel.user.listBlackCountLog", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<User> allBlackCountLog(int userIdx) throws Exception {
		List<User> list = null;
		
		try {
			list = dao.selectList("travel.user.allBlackCountLog", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
