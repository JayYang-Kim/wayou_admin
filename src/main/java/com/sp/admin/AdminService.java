package com.sp.admin;

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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return admin;
	}
}
