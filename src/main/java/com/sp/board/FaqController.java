package com.sp.board;

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

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller("board.faqController")
public class FaqController {
	@Autowired
	private FaqService faqService;
	@Autowired
	private MyUtil myUtil;
	

	@RequestMapping(value="/{tname}/faq/list")
	public String list (
			@PathVariable String tname,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue=URLDecoder.decode(searchValue, "UTF-8");
		}
		
		int total_page = 0;
		int dataCount = 0;
		int rows = 10;
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("tname", tname);
		
		dataCount=faqService.dataCount(map);
		if(dataCount!=0)
			total_page=myUtil.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		map.put("tname", tname);
		List<Faq> list = faqService.listFaq(map);
		
		int listNum, n=0;
		for(Faq dto : list) {
			listNum = dataCount - (start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp + "/"+tname+"/faq/list";
		String articleUrl = cp + "/"+ tname+"/faq/article?page="+current_page;
		
		if(searchValue.length()!=0) {
			query = "searchKey"+searchKey+"&searchValue"+URLEncoder.encode(searchValue, "UTF-8");
			
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
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
	
		return "."+tname+".faq.list";
	}
	
	
	@RequestMapping(value="/{tname}/faq/insertFaq", method=RequestMethod.GET)
	public String insertAnswerForm(
			@PathVariable String tname,
			@RequestParam String page,
			Model model) throws Exception {

		model.addAttribute("page", page);
		
		return "."+tname+".faq.insertFaq";
	}


	@RequestMapping(value="/{tname}/faq/insertFaq", method=RequestMethod.POST)
	public String insertAnswerSubmit(
			@PathVariable String tname,
			@RequestParam String page,
			HttpSession session,
			Faq dto) {
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		
		dto.setAdminIdx(info.getAdminIdx());
		dto.setTname(tname);
		
		faqService.insertFaq(dto);
		
		return "redirect:/"+tname+"/faq/list?page="+page;
	}
	
}
