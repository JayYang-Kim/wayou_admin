package com.sp.admin;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
			HttpSession session) {
			Map<String,Object> map = new HashMap<>();
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
	
/*	//이렇게 사용하세요
	@RequestMapping(value="/admin/hello")
	public String hello(){
		return ".admin.main.helloworld"; //관리자 메인으로 주소 변경하세요 용운님
		//return ".admin.폴더명.파일명"
	}*/
	
	@RequestMapping(value="/admin/sabun", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> findSeq(){
		Map<String, Object> model = new HashMap<>();
		int result=adminService.findSeq();
		Calendar cal = Calendar.getInstance();
		int year=cal.get(Calendar.YEAR);
		String answer=String.format("%04d", result);
		answer=year+answer;
		System.out.println(answer);
		
		model.put("adminId", answer);
		return model;
	}
	
	
	@RequestMapping(value="/admin/created", method=RequestMethod.GET)
	public String adminForm(
			Model model,
			HttpSession session,
			RedirectAttributes ra,
			HttpServletResponse resp){
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		if(info.getIdnCode() !=2) {
			ra.addFlashAttribute("state","등록 권한이 없습니다.");
			return "redirect:/main";
		}
		model.addAttribute("mode", "created");
		return ".insa.created"; 
	}
	
	@RequestMapping(value="/admin/created", method=RequestMethod.POST)
	public String adminSubmit(
			Admin dto, 
			Model model){

		int result=adminService.insertAdmin(dto);
		if(result==1) {
			
			model.addAttribute("message", "회원가입 완료 이메일짜라.");
			return ".main.main";
		} 
		
		model.addAttribute("mode", "created");
		model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
			
		return ".insa.created";
	}

}
