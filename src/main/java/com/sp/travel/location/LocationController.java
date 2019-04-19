package com.sp.travel.location;

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
import com.sp.common.MyUtil;

@Controller("travel.party.controller")
public class LocationController {
	
	@Autowired
	private LocationService locationService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/travel/admin/location/list")
	public String main() {
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
}
