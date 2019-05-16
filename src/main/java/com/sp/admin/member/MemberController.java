package com.sp.admin.member;

import java.net.URLDecoder;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller("admin.member.memberController")
public class MemberController {
	@Autowired
	private MemberService userService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/member/{tname}/list")
	public String list(@PathVariable String tname,
			@RequestParam(defaultValue="2") int enabled,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="userId") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		int dataCount = 0;
		int total_page = 0;
		int rows = 10;
		
		Map<String, Object> map = new HashMap<>();
		map.put("enabled", enabled);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		if(tname.equalsIgnoreCase("user")) {
			dataCount = userService.dataCount(map);
		} else if(tname.equalsIgnoreCase("black")) {
			dataCount = userService.dataCountBlack(map);
		}
		
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Member> list = null;
		
		if(tname.equalsIgnoreCase("user")) {
			list = userService.listUser(map);
		} else if(tname.equalsIgnoreCase("black")) {
			list = userService.listBlack(map);
		}
		
		int listNum, n = 0;
		for(Member dto : list) {
			listNum = dataCount - (start + n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String listUrl = null;
		String articleUrl = null;
		String paging = null;
		String query = null;
		
		if(tname.equalsIgnoreCase("user")) {
			listUrl = cp + "/member/"+ tname +"/list";
			articleUrl = cp + "/member/"+ tname +"/view?page=" + current_page;
			
			if(searchValue.length() != 0) {
				query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
				
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			
			paging = myUtil.paging(current_page, total_page, listUrl);
		} else if(tname.equalsIgnoreCase("black")) {
			listUrl = cp + "/member/"+ tname +"/list";
			articleUrl = cp + "/member/"+ tname +"/view?page=" + current_page;
			
			if(searchValue.length() != 0) {
				query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
				
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			
			paging = myUtil.paging(current_page, total_page, listUrl);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("enabled", enabled);
		
		return ".member."+ tname +".list";
	}
	
	@RequestMapping(value="/member/{tname}/view")
	public String view(@PathVariable String tname,
			@RequestParam int userIdx,
			@RequestParam(defaultValue="2") int enabled,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="userId") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		String query = "page=" + page + "&enabled=" + enabled;
		
		if(searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8"); 
		}
		
		Member dto = null;
		
		if(tname.equalsIgnoreCase("user")) {
			dto = userService.readUser(userIdx);
		} else if(tname.equalsIgnoreCase("black")) {
			dto = userService.readBlack(userIdx);
		}
		
		if(dto == null) {
			return "redirect:/member/"+ tname +"/list?" + query;
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("enabled", enabled);
		
		Member preReadUser = null;
		Member nextReadUser = null;
		
		if(tname.equalsIgnoreCase("user")) {
			preReadUser = userService.preReadUser(map);
			nextReadUser = userService.nextReadUser(map);
		} else if(tname.equalsIgnoreCase("black")) {
			preReadUser = userService.preReadBlack(map);
			nextReadUser = userService.nextReadBlack(map);
		}
		
		List<Member> listBlackCountLog = userService.listBlackCountLog(userIdx);
		List<Member> allBlackCountLog = userService.allBlackCountLog(userIdx);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadUser", preReadUser);
		model.addAttribute("nextReadUser", nextReadUser);
		model.addAttribute("listBlackCountLog", listBlackCountLog);
		model.addAttribute("allBlackCountLog", allBlackCountLog);
		model.addAttribute("query", query);
		
		return ".member."+ tname +".view";
	}
	
	@RequestMapping(value="/member/{tname}/updateBlackCount", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updBlackCount(@PathVariable String tname,
			@RequestParam int userIdx,
			@RequestParam int blackCount,
			HttpSession session) throws Exception {
		
		String msg = null;
		int result = 0;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userIdx", userIdx);
			map.put("blackCount", blackCount);
			
			AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
			
			System.out.println("userIdx : " + userIdx);
			System.out.println("blackCount : " + blackCount);
			
			result = userService.updateBlackCount(map, info.getAdminIdx());
			
			msg = "true";
		} catch (Exception e) {
			msg = "false";
			
			e.printStackTrace();
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("msg", msg);
		model.put("blackCount", result);
		
		return model;
	}
}
