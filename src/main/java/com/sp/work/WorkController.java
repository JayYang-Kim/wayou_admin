package com.sp.work;

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

@Controller("work.workController")
public class WorkController {
	@Autowired
	private WorkService workService;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/work/list")
	public String listWork(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="departCode")String condition,
			@RequestParam(defaultValue="")String word,
			HttpServletRequest req,
			Model model) throws Exception{
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			word=URLDecoder.decode(word, "UTF-8");
		}
		
		int total_page=0;
		int dataCount=0;
		int rows=10;
		
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("word", word);
		
		dataCount=workService.dataCount(map);
		
		if(dataCount !=0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page-1) * rows +1;
		int end = current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Work> list = workService.listWork(map);
		
		int listNum=0;
		int n=0;
		
		for(Work dto : list) {
			listNum=dataCount - (start+ n-1);
			dto.setListNum(listNum);
			n++;
		}
		String cp = req.getContextPath();
		String listUrl= cp+"/work/list";
		String articleUrl=cp+"/work/view?page=";
		
		if(word.length()!=0) {
			String query = "&condition=" + condition +"&word="+ URLEncoder.encode(word, "UTF-8");
		
			listUrl +="?" + query;
			articleUrl +="&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("word", word);
		return ".work.list";
	}
	
	@RequestMapping(value="/work/created", method=RequestMethod.GET)
	public String insertWorkForm(
			HttpSession session,
			Model model) throws Exception{
		Work di = new Work();
		di=null;
		
		AdminSessionInfo info =(AdminSessionInfo)session.getAttribute("admin");
		int adminIdx=info.getAdminIdx();
		int departCode=info.getDepartCode();
		int dayWork=workService.searchWork(departCode);
		di=workService.readAdmin(adminIdx);
		di.setDayWork(dayWork);
		
		model.addAttribute("di",di);
		model.addAttribute("mode", "created");
		
		return ".work.created";
	}
	
	@RequestMapping(value="/work/created", method=RequestMethod.POST)
	public String insertWorkSubmit(Work dto) throws Exception{
		
		try {
		workService.insertWork(dto);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/work/list";
	}

}
