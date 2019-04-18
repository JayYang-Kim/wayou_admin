package com.sp.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.sp.admin.Admin;
import com.sp.admin.AdminService;
import com.sp.admin.AdminSessionInfo;

public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	@Autowired
	private AdminService adminService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		
		// 로그인 정보 저장
		Admin dto = adminService.readLoginInfo(authentication.getName());
		
		AdminSessionInfo info = new AdminSessionInfo();
		info.setAdminIdx(dto.getAdminIdx());
		info.setAdminId(dto.getAdminId());
		info.setAdminName(dto.getAdminName());
		info.setIdnCode(dto.getIdnCode());
		info.setDepartCode(dto.getDepartCode());
		
		HttpSession session = request.getSession();
		session.setAttribute("admin", info);
		
		super.onAuthenticationSuccess(request, response, authentication);
	}

}
