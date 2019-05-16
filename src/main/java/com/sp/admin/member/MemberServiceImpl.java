package com.sp.admin.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("admin.member.memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private CommonDAO dao;

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("member.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Member> listUser(Map<String, Object> map) throws Exception {
		List<Member> list = null;
		
		try {
			list = dao.selectList("member.listUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Member readUser(int userIdx) throws Exception {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.readUser", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Member preReadUser(Map<String, Object> map) throws Exception {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.preReadUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Member nextReadUser(Map<String, Object> map) throws Exception {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.nextReadUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public int dataCountBlack(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("member.dataCountBlack", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Member> listBlack(Map<String, Object> map) throws Exception {
		List<Member> list = null;
		
		try {
			list = dao.selectList("member.listBlack", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Member readBlack(int userIdx) throws Exception {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.readBlack", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Member preReadBlack(Map<String, Object> map) throws Exception {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.preReadBlack", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Member nextReadBlack(Map<String, Object> map) throws Exception {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.nextReadBlack", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int updateBlackCount(Map<String, Object> map, int adminIdx) throws Exception {
		int result = 0;
		
		try {
			dao.updateData("member.updateBlackCount", map);
			result = dao.selectOne("member.readBlackCount", map);
			
			Member dto = dao.selectOne("member.readUser", map);
			dto.setAdminIdx(adminIdx);
			
			dao.insertData("member.insertBlackCountLog", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public List<Member> listBlackCountLog(int userIdx) throws Exception {
		List<Member> list = null;
		
		try {
			list = dao.selectList("member.listBlackCountLog", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Member> allBlackCountLog(int userIdx) throws Exception {
		List<Member> list = null;
		
		try {
			list = dao.selectList("member.allBlackCountLog", userIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
