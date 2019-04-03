package com.sp.member;

import org.springframework.stereotype.Service;

@Service("member.memberService")
public class MemberService {
	
	/*@Autowired
	private CommonDAO dao;
	
	public User readLoginInfo(String userId) {
		User user = null;
		try {
			 user = dao.selectOne("member.readLoginInfo", userId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}*/
}
