package com.sp.travel.location;

import java.io.File;
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

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller("travel.party.controller")
public class LocationController {
	
	@Autowired
	private LocationService locationService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/travel/admin/location/list")
	public String main(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="1") int enable,
			@RequestParam(defaultValue="location") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		int total_page = 0;
		int dataCount = 0;
		int rows = 10;
		
		Map<String, Object> map = new HashMap<>();
		map.put("enable", enable);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		dataCount = locationService.dataCount(map);
		
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
		
		List<Location> list = locationService.locationList(map);
		
		int listNum, n = 0;
		for(Location dto : list) {
			listNum = dataCount - (start + n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp + "/travel/admin/location/list";
		String articleUrl = cp + "/travel/admin/location/view?page=" + current_page + "&enable=" + enable;
		
		if(searchValue.length()!=0) {
			query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("enable", enable);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		return ".travel.location.list";
	}
	
	@RequestMapping(value="/travel/admin/location/add", method = RequestMethod.GET)
	public String addLocation(Model model) throws Exception {
		List<Location> listLoc = null;
		
		listLoc = locationService.locList();
		
		if(listLoc == null) {
			return "redirect:/travel/admin/location/list";
		}
		
		model.addAttribute("listLoc", listLoc);
		model.addAttribute("mode", "add");
		
		return ".travel.location.add";
	}
	
	@RequestMapping(value="/travel/admin/location/add", method = RequestMethod.POST)
	public String addLocation_submit(Location dto,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			return "redirect:/travel/admin/location/list";
		}
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		
		if(info == null) {
			return "redirect:/travel/admin/location/list";
		}
		
		dto.setAdminIdx(info.getAdminIdx());
		
		String root = session.getServletContext().getRealPath("/");
		String pathName = root + "uploads" + File.separator + "photo";
		
		try {
			locationService.insertLocation(dto, pathName);
		} catch (Exception e) {
			return "redirect:/travel/admin/location/add";
		}
		
		return "redirect:/travel/admin/location/list";
	}
	
	@RequestMapping(value="/travel/admin/location/view")
	public String readLocation(@RequestParam int locCode,
			@RequestParam int page,
			@RequestParam(defaultValue="1") int enable,
			@RequestParam(defaultValue="location") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		String query = "?page=" + page + "&enable=" + enable;
		if(searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		Location dto = locationService.readLocation(locCode);
		
		if(dto == null) {
			return "redirect:/travel/admin/location/list" + query;
		}
		
		dto.setMemo(myUtil.htmlSymbols(dto.getMemo()));
		
		List<Location> listLocationLog = locationService.listLocationLog(locCode);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listLocationLog", listLocationLog);
		model.addAttribute("query", query);
		
		return ".travel.location.view";
	}
}
