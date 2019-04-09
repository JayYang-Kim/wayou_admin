package com.sp.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("admin.adminService")
public class AdminService {
	
	@Autowired
	private CommonDAO dao;
	
	public Admin readLoginInfo(String adminId) {
		Admin admin = null;
		try {
			admin = dao.selectOne("admin.readLoginInfo", adminId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return admin;
	}
	
	public int insertAdmin(Admin dto) {
		int result=0;
		
		try {
			if(dto.getEmail1() != null && dto.getEmail1().length()!=0 &&
					dto.getEmail2() != null && dto.getEmail2().length()!=0)
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());

			dao.insertData("admin.insertAdmin",dto);
			//dao.updateData("admin.insertAdmin12", dto);

			result=1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int findSeq() {
		int result=0;
		try {
			result=dao.selectOne("admin.findSeq");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public List<Admin> listAdmin(Map<String, Object> map) {
		List<Admin> listAdmin =null;
		
		try {
			listAdmin=dao.selectList("admin.listAdmin",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listAdmin;
	}
	
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("admin.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
