package com.sp.member;

import org.springframework.stereotype.Controller;

@Controller("member.memberController")
public class MemberController {
	
/*	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public String loginForm() {
		return ".member.login";
	}
	
	//로그인이 갑자기 안된다 무슨 일 일까
	@RequestMapping(value="/member/login", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> loginSubmit(
			User user,
			HttpSession session
			) {
			System.out.println("hi");
			Map<String,Object> map = new HashMap<>();
			User temp = memberService.readLoginInfo(user.getUserId());
			boolean isUser = false;
			if(temp != null && temp.getUserPwd().equals(user.getUserPwd())){
				AdminSessionInfo info = new AdminSessionInfo();
				info.setRoleCode(temp.getRoleCode());
				info.setUserId(temp.getUserId());
				info.setUserIdx(temp.getUserIdx());
				info.setUserName(temp.getUserName());
				session.setAttribute("member", info);
				isUser = true;
			}
			String uri = (String)session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");
			map.put("isUser", isUser);
			map.put("uri", uri);
		return map;
	}
	
	@RequestMapping(value="/member/logout")
	public String logout(HttpSession session){
		session.removeAttribute("member");
		session.invalidate();
		return "redirect:/main";
	}*/
}
