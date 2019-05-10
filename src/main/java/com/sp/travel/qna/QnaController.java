package com.sp.travel.qna;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller("travelQna.controller")
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	@Autowired
	private MyUtil util;
	
	@GetMapping("/travel/admin/qna/list")
	public String qnaList(			
			@RequestParam(defaultValue="1", value="page") int current_page,
			@RequestParam(defaultValue="", value="searchKey") String searchKey,
			@RequestParam(defaultValue="", value="searchValue") String searchValue,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
		Map<String,Object> map = new HashMap<>();
		String cp = req.getContextPath();
		String url = cp+"/travel/qna/list";
		
		searchValue = URLDecoder.decode(searchValue, "utf-8");
		if(!searchValue.equals("")) {	
			url += "?searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
		}
		
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		//사전 준비
		int rows = 10;
		int qnaCount = qnaService.qnaCount(map);
		int total_page = util.pageCount(rows, qnaCount);
		
		int start = (current_page-1)*rows +1;
		int end = current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		List<TQuestion> list =  qnaService.qnaList(map);
		//리스트 번호 만들기
		int n =0;
		for(TQuestion question : list) {
			question.setListNum(qnaCount-((current_page-1)*rows +n));
			question.setCreated(question.getCreated().substring(0, 11));
			map.put("qnaCode", question.getQnaCode());
			question.setAnswers(qnaService.answerList(map));
			n++;
		}
		
		String paging = util.paging(current_page, total_page, url);
		
		model.addAttribute("page", current_page);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("url", url);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);	
		return ".travel.qna.list";
	}
	
	@PostMapping("/travel/admin/qna/insertAnswer")
	@ResponseBody
	public Map<String,Object> insertAnswer(
			Answer answer,
			HttpSession session
			){
		Map<String,Object> map = new HashMap<>();
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		answer.setAdminIdx(info.getAdminIdx());
		qnaService.insertAnswer(answer);
		return map;
	}
	
	@PostMapping("/travel/admin/qna/deleteAnswer")
	@ResponseBody
	public Map<String,Object> deleteAnswer(
			@RequestParam int answerCode
			) {
		Map<String,Object> map = new HashMap<>();
		qnaService.deleteAnswer(answerCode);
		return map;
	}
}
