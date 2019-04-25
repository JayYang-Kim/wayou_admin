package com.sp.board;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller("board.noticeController")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;

	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/hotel/notice/list", method=RequestMethod.GET)
	public String listHotelNotice() {
		return ".hotel.notice.list";
	}
	
	@RequestMapping(value="/{tname}/notice/insertNotice", method=RequestMethod.GET)
	public String insertNoticeForm(
			@PathVariable String tname,
			Model model) {
		model.addAttribute("mode", "created");
		
		return "."+tname+".notice.insertNotice";
	}
	
	@RequestMapping(value="/{tname}/notice/insertNotice", method=RequestMethod.POST)
	public String insertNoticeSubmit(
			@PathVariable String tname,
			Notice dto,
			HttpSession session,
			Model model) {
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		
		dto.setAdminIdx(info.getAdminIdx());
		dto.setTname(tname);
		
		noticeService.insertNotice(dto);
		
		return "redirect:/"+tname+"/notice/list";
	}
}
