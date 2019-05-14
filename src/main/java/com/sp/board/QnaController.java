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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller("ticket.qnaController")
public class QnaController {
	@Autowired
	private QnaService qnaService;
	@Autowired
	private MyUtil myUtil;

	
	@RequestMapping(value="/{tname}/qna/insertAnswer", method=RequestMethod.GET)
	public String insertAnswerForm(
			@PathVariable String tname,
			@RequestParam int qnaCode,
			@RequestParam String page,
			@RequestParam int catCode,
			Model model) throws Exception {

		Qna dto = qnaService.readBoard(qnaCode);
		
		if(dto==null) {
			return "redirect:/"+tname+"/qna/list?catCode="+catCode+"&page="+page;
		}

		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("catCode", catCode);
		
		return "."+tname+".qna.answer";
	}


	@RequestMapping(value="/{tname}/qna/insertAnswer", method=RequestMethod.POST)
	public String insertAnswerSubmit(
			@PathVariable String tname,
			@RequestParam String page,
			@RequestParam int catCode,
			HttpSession session,
			Qna dto) {
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		
		dto.setAdminIdx(info.getAdminIdx());

		
		qnaService.insertAnswer(dto);
		
		return "redirect:/"+tname+"/qna/list?catCode="+catCode+"&page="+page;
	}

	
	@RequestMapping(value="/{tname}/qna/list")
	public String list (
			@PathVariable String tname,
			@RequestParam int catCode,
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
		map.put("catCode", catCode);
		
		dataCount=qnaService.dataCount(map);
		if(dataCount!=0)
			total_page=myUtil.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		map.put("catCode", catCode);
		List<Qna> list = qnaService.listBoard(map);
		
		int listNum, n=0;
		for(Qna dto : list) {
			listNum = dataCount - (start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp + "/"+tname+"/qna/list";
		String articleUrl = cp + "/"+ tname+"/qna/article?page="+current_page;
		
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
	
		return "."+tname+".qna.list";
	}
	
	@RequestMapping(value="/{tname}/qna/hitCount", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> hitCount(
			@PathVariable String tname,
			@RequestParam int qnaCode) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		String msg="true";
		int result=qnaService.updateHitCount(qnaCode);
		if(result==0) {
			msg="false";
		}
		
		int hitCount=qnaService.readHitCount(qnaCode);
		
		model.put("msg", msg);
		model.put("hitCount", hitCount);
		
		return model;
	}
	
	
}
