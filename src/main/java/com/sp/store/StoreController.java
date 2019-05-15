package com.sp.store;

import java.io.File;
import java.net.URLDecoder;
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

@Controller("store.StoreController")
public class StoreController {
	
	@Autowired
	private StoreService storeService;
	
	@Autowired
	private MyUtil myUtil;
	
	
	
	@RequestMapping(value= {"/store/main"}, method=RequestMethod.GET)
	public String method() {
		return ".store.main";
	}
	
	@RequestMapping(value="/store/storeInfo/list", method=RequestMethod.GET)
	public String listStore(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="storeName") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model)  throws Exception{
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue=URLDecoder.decode(searchValue, "UTF-8");
		}
		int rows=10;
		int total_page=0;
		int storeCount=0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		storeCount=storeService.storeCount(map);
		if(storeCount!=0) {
			total_page=myUtil.pageCount(rows, storeCount);
		}
		
		if(current_page>total_page) {
			current_page=total_page;
		}
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		List<Store> list = storeService.listStore(map);
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		model.addAttribute("list", list);
		model.addAttribute("storeCount", storeCount);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue",searchValue);
		
		return ".store.storeInfo.list";
	}
	
	@RequestMapping(value="/store/storeInfo/insertStore", method=RequestMethod.GET)
	public String insertStoreForm(
			Model model) {

		model.addAttribute("mode", "created");
		
		return ".store.storeInfo.insertStore";
	}
	
	@RequestMapping(value="/store/storeInfo/insertStore", method=RequestMethod.POST)
	public String insertRoomSubmit(
			Store dto,
			Model model,
			HttpSession session
			) throws Exception{
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		String root = session.getServletContext().getRealPath("/");
		
		String pathname = root + File.separator + "uploads" + File.separator + "store";
		
		dto.setAdminIdx(info.getAdminIdx());
		
		storeService.insertStore(dto, pathname);
		
		return "redirect:/store/storeInfo/list";
	}
	
	@RequestMapping(value="/store/storeInfo/view", method=RequestMethod.GET)
	public String viewStore(
			@RequestParam int storeCode,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		String query = null;
		Store dto = null;
		
		int rows=10;
		int total_page=0;
		int ticketCount=0;
		
		ticketCount=storeService.ticketCount(storeCode);
		
		if(ticketCount!=0) {
			total_page=myUtil.pageCount(rows, ticketCount);
		}
		
		if(current_page>total_page) {
			current_page=total_page;
		}
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		
		
		
		dto = storeService.readStore(storeCode);
				
		if(dto == null) {
			return "redirect:/store/storeInfo/list";
		}
		
		dto.setCancel_notice(myUtil.htmlSymbols(dto.getCancel_notice()));
		
		List<Store> listStoreFile = null;	
		listStoreFile = storeService.listStoreFile(storeCode);

		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("storeCode", storeCode);
		List<Ticket> listTicket = storeService.listTicket(map);
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		model.addAttribute("listTicket", listTicket);
		model.addAttribute("ticketCount", ticketCount);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listStoreFile", listStoreFile);

		model.addAttribute("query", query);
		
		return ".store.storeInfo.view";
	}
	
	@RequestMapping(value="/store/storeInfo/ticketInfo/list", method=RequestMethod.GET)
	public String listTicket(
			Model model) {
		
		
		return ".store.storeInfo.ticketInfo.list";
	}

	@RequestMapping(value="/store/storeInfo/ticketInfo/insertTicket", method=RequestMethod.GET)
	public String insertTicketForm(
			@RequestParam int storeCode,
			Model model) {
		
		model.addAttribute("storeCode", storeCode);
		model.addAttribute("mode", "created");
		
		return "store/storeInfo/ticketInfo/insertTicket";
	}
	
	@RequestMapping(value="/store/storeInfo/ticketInfo/insertTicket", method=RequestMethod.POST)
	public String insertTicketSubmit(
			Ticket dto,
			@RequestParam int storeCode,
			Model model,
			HttpSession session
			) throws Exception{
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		String root = session.getServletContext().getRealPath("/");
		
		String pathname = root + File.separator + "uploads" + File.separator + "ticket";
		dto.setStoreCode(storeCode);
		dto.setAdminIdx(info.getAdminIdx());
		
		storeService.insertTicket(dto, pathname);
		
		return "redirect:/store/storeInfo/view?storeCode="+storeCode;
	}

	@RequestMapping(value="/store/storeInfo/ticketInfo/updateTicket", method=RequestMethod.GET)
	public String updateTicketForm(
			@RequestParam int storeCode,
			@RequestParam int ticketCode,
			Model model) {
		
		Ticket dto = storeService.readTicket(ticketCode);
		dto.setStoreCode(storeCode);
		
		List<Ticket> listFile = storeService.listTicketFile(ticketCode);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("mode", "update");
		
		return "store/storeInfo/ticketInfo/insertTicket";
	}
	
	@RequestMapping(value="/store/storeInfo/ticketInfo/updateTicket", method=RequestMethod.POST)
	public String updateTicketSubmit(
			Ticket dto,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "ticket";
		
		storeService.updateTicket(dto, pathname);

		return "redirect:/store/storeInfo/view?storeCode="+dto.getStoreCode();
	}
	
	@RequestMapping(value="/store/storeInfo/ticketInfo/detail", method=RequestMethod.GET)
	public String listTicketDetail(
			@RequestParam int ticketCode,
			@RequestParam int storeCode,
			Model model) {
		List<TicketDetail> listTicketDetail = storeService.listTicketDetail(ticketCode);
		
		model.addAttribute("listTicketDetail", listTicketDetail);
		model.addAttribute("ticketCode", ticketCode);
		model.addAttribute("storeCode", storeCode);
		return ".store.storeInfo.ticketInfo.detail";
	}
	
	@RequestMapping(value="/store/storeInfo/ticketInfo/insertDetail", method=RequestMethod.GET)
	public String insertTicketDetailForm(
			@RequestParam int ticketCode,
			Model model) {
		
		model.addAttribute("mode", "created");
		model.addAttribute("ticketCode", ticketCode);
		
		return "store/storeInfo/ticketInfo/insertTicketDetail";
	}
	
	@RequestMapping(value="/store/storeInfo/ticketInfo/insertDetail", method=RequestMethod.POST)
	public String insertTicketDetailSubmit(
			TicketDetail dto,
			Model model
			) throws Exception{
		
		storeService.insertTicketDetail(dto);
		
		return "redirect:/store/storeInfo/ticketInfo/detail?ticketCode="+dto.getTicketCode();
	}

}
