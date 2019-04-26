package com.sp.store;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.common.MyUtil;

@Controller("ticket.TicketController")
public class StoreController {
	
	@Autowired
	private StoreService ticketService;
	
	@Autowired
	private MyUtil myUtil;
	
	
	
	@RequestMapping(value= {"/store/main"}, method=RequestMethod.GET)
	public String method() {
		return ".store.main";
	}
	
	@RequestMapping(value="/store/storeInfo/list", method=RequestMethod.GET)
	public String listTicket(
			Model model) {
		
		
		return ".store.storeInfo.list";
	}
	
	@RequestMapping(value="/store/storeInfo/insertStore", method=RequestMethod.GET)
	public String insertStoreForm(
			Model model) {

		model.addAttribute("mode", "created");
		
		return "store/storeInfo/insertStore";
	}
	
	@RequestMapping(value="/ticket/ticketInfo/insertTicket", method=RequestMethod.POST)
	public String insertRoomSubmit(
			Ticket dto,
			Model model,
			HttpSession session
			) throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"hotel";
		
		//ticketService.insertRoom(dto, pathname);
		
		return "redirect:/ticket/ticketInfo/list";
	}



}
