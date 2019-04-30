package com.sp.store;

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
		
		String pathname = root+"uploads"+File.separator+"hotel";
		
		dto.setAdminIdx(info.getAdminIdx());
		
		storeService.insertStore(dto, pathname);
		
		return "redirect:/store/storeInfo/list";
	}
	
	@RequestMapping(value="/store/storeInfo/view", method=RequestMethod.GET)
	public String viewStore(
			@RequestParam int storeCode,
			@RequestParam(defaultValue="storeName") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			Model model) throws Exception {
		String query = null;
		
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		if(searchValue.length() != 0) {
			query = "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		Store dto = null;
		
		
		dto = storeService.readStore(storeCode);
				
		if(dto == null) {
			return "redirect:/store/storeInfo/list";
		}
		
		dto.setCancel_notice(myUtil.htmlSymbols(dto.getCancel_notice()));
		
		List<Store> listStoreFile = null;	
		listStoreFile = storeService.listStoreFile(storeCode);
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue); 
		
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
		
		model.addAttribute("mode", "created");
		
		return "store/storeInfo/ticketInfo/insertTicket";
	}
	
	@RequestMapping(value="/store/storeInfo/ticketInfo/insertTicket", method=RequestMethod.POST)
	public String insertTicketSubmit(
			Ticket dto,
			Model model,
			HttpSession session
			) throws Exception{
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		String root = session.getServletContext().getRealPath("/");
		
		String pathname = root+"uploads"+File.separator+"ticket";
		
		dto.setAdminIdx(info.getAdminIdx());
		
		storeService.insertTicket(dto, pathname);
		
		return "redirect:/store/storeInfo/view?storeCode="+dto.getStoreCode();
	}

}
