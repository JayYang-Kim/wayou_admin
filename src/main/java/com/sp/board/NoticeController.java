package com.sp.board;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller("board.noticeController")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;

	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/{tname}/notice/list", method=RequestMethod.GET)
	public String listHotelNotice(
			@PathVariable String tname,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="subject") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {

		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue=URLDecoder.decode(searchValue, "UTF-8");
		}
		int rows=10;
		int total_page=0;
		int noticeCount=0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("tname", tname);
		
		noticeCount=noticeService.dataCount(map);
		if(noticeCount!=0) {
			total_page=myUtil.pageCount(rows, noticeCount);
		}
		
		if(current_page>total_page) {
			current_page=total_page;
		}
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		map.put("tname", tname);
		List<Notice> list = noticeService.listNotice(map);

		String paging = myUtil.paging(current_page, total_page);
		model.addAttribute("list", list);
		model.addAttribute("noticeCount", noticeCount);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue",searchValue);
		
		return "."+tname+".notice.list";
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
