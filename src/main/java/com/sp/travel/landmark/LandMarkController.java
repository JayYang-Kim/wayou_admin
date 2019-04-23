package com.sp.travel.landmark;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public String list() {
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
