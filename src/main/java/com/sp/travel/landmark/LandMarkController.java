package com.sp.travel.landmark;

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
import com.sp.common.FileManager;
import com.sp.common.MyUtil;

@Controller("travel.landmark.controller")
public class LandMarkController {
	
	@Autowired
	private LandMarkService landmarkService;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/travel/admin/landmark/list")
	public String list(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="locName") String searchKey,
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
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		dataCount = landmarkService.dataCount(map);
		
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
		
		List<LandMark> list = landmarkService.listLandMark(map);
		
		int listNum, n = 0;
		for(LandMark dto : list) {
			listNum = dataCount - (start + n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String listUrl = cp + "/travel/admin/landmark/list";
		String articleUrl = cp + "/travel/admin/landmark/view?page=" + current_page;
		
		if(searchValue.length() != 0) {
			String query = "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		return ".travel.landmark.list";
	}
	
	@RequestMapping(value="/travel/admin/landmark/add", method = RequestMethod.GET)
	public String add(Model model) throws Exception {
		List<LandMark> listLocation = landmarkService.listLocation();
		List<LandMark> listTag = landmarkService.listTag();
		
		model.addAttribute("listLocation", listLocation);
		model.addAttribute("listTag", listTag);
		model.addAttribute("mode", "add");
		
		return ".travel.landmark.add";
	}
	
	@RequestMapping(value="/travel/admin/landmark/add", method = RequestMethod.POST)
	public String add(LandMark dto,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			return "redirect:/travel/admin/landmark/list";
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";	
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		dto.setAdminIdx(info.getAdminIdx());
		
		try {
			landmarkService.insertLandMark(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/travel/admin/landmark/list";
	}
}
