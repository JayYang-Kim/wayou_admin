package com.sp.hotel;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.admin.AdminSessionInfo;

@Controller("hotel.hotelController")
public class HotelController {
	
	@Autowired
	private HotelService hotelService;
	
	
	@RequestMapping(value= {"/hotel/main"}, method=RequestMethod.GET)
	public String method() {
		return ".hotel.main";
	}
	
	@RequestMapping(value="/hotel/reserve/list")
	public String reserveList() {
		return ".hotel.reserve.list";
	}
	
	
	@RequestMapping(value="/hotel/customer/reserveList")
	public String customerList() {
		return ".hotel.customer.reserveList";
	}
	
	@RequestMapping(value="/hotel/hotelInfo/insertHotel", method=RequestMethod.GET)
	public String insertHotelForm(Model model) {
		
		//model.addAttribute("mode", "created");
		
		return "hotel/hotelInfo/insertHotel";
	}
	
	@RequestMapping(value="/hotel/hotelInfo/insertHotel", method=RequestMethod.POST)
	public String insertHotelSubmit(Hotel dto, HttpSession session, Model model) {
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		String root = session.getServletContext().getRealPath("/");
		
		String pathname=root+"uploads"+File.separator+"hotel";
	
		dto.setAdminIdx(info.getAdminIdx());
		
		hotelService.insertHotel(dto, pathname);
		
		return "redirect:/hotel/reserve/list";
	}
	
	@RequestMapping(value="/hotel/event/listEvent")
	public String listEvent() {
		return ".hotel.event.listEvent";
	}
	
}
