package com.sp.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("admin.adminController")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@RequestMapping(value="/admin/login", method=RequestMethod.GET)
	public String login() {
		return "login/login";
	}
	
	@RequestMapping(value="/admin/login", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> loginSubmit(
			Admin admin,
			HttpSession session
			) {
			System.out.println("say hello~");
			Map<String,Object> map = new HashMap<>();
			System.out.println("hi:"+admin.getAdminId());
			Admin temp = adminService.readLoginInfo(admin.getAdminId());
			boolean isAdmin = false;
			if(temp != null && temp.getAdminPwd().equals(admin.getAdminPwd())){
				AdminSessionInfo info = new AdminSessionInfo();
				info.setAdminIdx(temp.getAdminIdx());
				info.setAdminId(temp.getAdminId());
				info.setAdminName(temp.getAdminName());
				info.setIdnCode(temp.getIdnCode());
				info.setDepartCode(temp.getDepartCode());
				session.setAttribute("admin", info);
				isAdmin = true;
			}
			String uri = (String)session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");
			
			map.put("isAdmin", isAdmin);
			map.put("uri", uri);
		return map;
	}
	
	@RequestMapping(value="/admin/logout")
	public String logout(HttpSession session){
		session.removeAttribute("admin");
		session.invalidate();
		return "redirect:/main"; //관리자 메인으로 주소 변경하세요 용운님
	}
	
	//이렇게 사용하세요
	@RequestMapping(value="/admin/hello")
	public String hello(){
		return ".admin.main.helloworld"; //관리자 메인으로 주소 변경하세요 용운님
		//return ".admin.폴더명.파일명"
	}
}
