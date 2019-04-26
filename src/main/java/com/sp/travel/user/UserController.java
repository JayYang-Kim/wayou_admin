package com.sp.travel.user;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller("travel.user.userController")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/travel/admin/user/list")
	public String list(@RequestParam(defaultValue="2") int enabled,
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
		
		dataCount = userService.dataCount(map);
		
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
		
		List<User> list = userService.listUser(map);
		
		int listNum, n = 0;
		for(User dto : list) {
			listNum = dataCount - (start + n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String listUrl = cp + "/travel/admin/user/list";
		String articleUrl = cp + "/travel/admin/user/view?page=" + current_page;
		
		if(searchValue.length() != 0) {
			String query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("enabled", enabled);
		
		return ".travel.user.list";
	}
	
	@RequestMapping(value="/travel/admin/user/view")
	public String view(@RequestParam int userIdx,
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
		
		User dto = userService.readUser(userIdx);
		
		if(dto == null) {
			return "redirect:/travel/admin/user/list?" + query;
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("enabled", enabled);
		
		User preReadUser = userService.preReadUser(map);
		User nextReadUser = userService.nextReadUser(map);
		
		List<User> listBlackCountLog = userService.listBlackCountLog(userIdx);
		List<User> allBlackCountLog = userService.allBlackCountLog(userIdx);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadUser", preReadUser);
		model.addAttribute("nextReadUser", nextReadUser);
		model.addAttribute("listBlackCountLog", listBlackCountLog);
		model.addAttribute("allBlackCountLog", allBlackCountLog);
		model.addAttribute("query", query);
		
		return ".travel.user.view";
	}
	
	@RequestMapping(value="/travel/admin/user/updateBlackCount", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updBlackCount(@RequestParam int userIdx,
			@RequestParam int blackCount,
			HttpSession session) throws Exception {
		
		String msg = null;
		int result = 0;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userIdx", userIdx);
			map.put("blackCount", blackCount);
			
			AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
			
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
