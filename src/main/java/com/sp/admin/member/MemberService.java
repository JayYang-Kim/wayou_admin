package com.sp.admin.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Member> listUser(Map<String, Object> map) throws Exception;
	public Member readUser(int userIdx) throws Exception;
	public Member preReadUser(Map<String, Object> map) throws Exception;
	public Member nextReadUser(Map<String, Object> map) throws Exception;
	
	public int dataCountBlack(Map<String, Object> map) throws Exception;
	public List<Member> listBlack(Map<String, Object> map) throws Exception;
	public Member readBlack(int userIdx) throws Exception;
	public Member preReadBlack(Map<String, Object> map) throws Exception;
	public Member nextReadBlack(Map<String, Object> map) throws Exception;
	
	public int updateBlackCount(Map<String, Object> map, int adminIdx) throws Exception;
	public List<Member> listBlackCountLog(int userIdx) throws Exception;
	public List<Member> allBlackCountLog(int userIdx) throws Exception;
}
