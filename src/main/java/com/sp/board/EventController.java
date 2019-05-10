package com.sp.board;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.admin.AdminSessionInfo;
import com.sp.common.FileManager;
import com.sp.common.MyUtil;


@Controller("board.eventController")
public class EventController {
	@Autowired
	private EventService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/{tname}/event/listEvent")
	public String listEvent(
			@PathVariable String tname,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="subject") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
   	    String cp = req.getContextPath();
   	    System.out.println(tname);
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int eventCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);
        map.put("tname", tname);
        
        eventCount = service.dataCount(map);
        if(eventCount != 0)
            total_page = myUtil.pageCount(rows, eventCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);
        map.put("tname", tname);
        
        // 글 리스트
        List<Event> listEvent = service.listEvent(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Event dto : listEvent) {
            listNum = eventCount - (start + n - 1);
            dto.setListNum(listNum);
            n++;
        }
       
        String query = "";
        String listUrl = cp+"/"+tname+"/event/listEvent";
        String articleUrl = cp+"/"+tname+"/event/article?page=" + current_page;
        if(searchValue.length()!=0) {
        	query = "searchKey=" +searchKey + 
        	         "&keyword=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/"+tname+"/event/listEvent?" + query;
        	articleUrl = cp+"/"+tname+"/event/article?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);


        model.addAttribute("listEvent", listEvent);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("eventCount", eventCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		return "."+tname+".event.listEvent";
	}
	
	@RequestMapping(value="/{tname}/event/insertEvent", method=RequestMethod.GET)
	public String insertEventForm(
			@PathVariable String tname,
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return "."+tname+".event.insertEvent";
	}
	
	@RequestMapping(value="/{tname}/event/insertEvent", method=RequestMethod.POST)
	public String createdSubmit(
			@PathVariable String tname,
			Event dto,
			HttpSession session,
			Model model) throws Exception{
	
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"event";
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		
		dto.setAdminIdx(info.getAdminIdx());

		service.insertEvent(dto, pathname);
		
		return "redirect:/"+tname+"/event/listEvent";
	}
	
	@RequestMapping(value="/{tname}/event/article")
	public String article(
			@PathVariable String tname,
			@RequestParam int eventNum,
			@RequestParam String page,
			@RequestParam(defaultValue="subject") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			Model model) throws Exception {
		
		searchValue = URLDecoder.decode(searchValue, "utf-8");
		
		String query="page="+page;
		if(searchValue.length()!=0) {
			query+="&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("eventNum", eventNum);
		map.put("tname", tname);
		// 해당 레코드 가져 오기
		Event dto = service.readEvent(map);
		if(dto==null)
			return "redirect:/"+tname+"/event/listEvent?"+query;
		
		// 스마트 에디터는 HTML로 작성되므로 
        dto.setContent(myUtil.htmlSymbols(dto.getContent()));
        
		// 이전 글, 다음 글
		
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("eventNum", eventNum);
		map.put("tname", tname);

		//Event preReadDto = service.preReadBoard(map);
		//Event nextReadDto = service.nextReadBoard(map);
        
		model.addAttribute("dto", dto);
		//model.addAttribute("preReadDto", preReadDto);
		//model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("page", page);
		model.addAttribute("query", query);

        return "."+tname+".event.article";
	}
	
	@RequestMapping(value="/{tname}/update", method=RequestMethod.GET)
	public String updateForm(
			@PathVariable String tname,
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		
		Event dto = service.updateReadEvent(num);
		if(dto==null) {
			return "redirect:/"+tname+"/list?page="+page;
		}

		
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".bbs.created";
	}

	@RequestMapping(value="/{tname}/update", method=RequestMethod.POST)
	public String updateSubmit(
			@PathVariable String tname,
			Event dto, 
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"event";		
		// 수정 하기
		service.updateBoard(dto, pathname);		
		
		return "redirect:/"+tname+"/list?page="+page;
	}
	
	@RequestMapping(value="/{tname}/deleteFile")
	public String deleteFile(
			@PathVariable String tname,
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"event";
		
		Event dto=service.updateReadEvent(num);
		if(dto==null) {
			return "redirect:/"+tname+"/list?page="+page;
		}
		/*
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/bbs/list?page="+page;
		}
		*/
		if(dto.getSaveFilename()!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname); // 실제파일삭제
			dto.setSaveFilename("");
			dto.setOriginalFilename("");
			service.updateBoard(dto, pathname); // DB 테이블의 파일명 변경(삭제)
		}
		
		return "redirect:/"+tname+"/update?num="+num+"&page="+page;
	}
	
	@RequestMapping(value="/{tname}/delete")
	public String delete(
			@PathVariable String tname,
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Event dto = service.deleteReadEvent(num);
		if(dto==null)
			return "redirect:/"+tname+"/list?"+query;
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"event";
		
		service.deleteBoard(num, pathname, dto.getSaveFilename());
		
		return "redirect:/"+tname+"/list?"+query;
	}
	

	
	// 게시글 좋아요 추가 :  : AJAX-JSON
	@RequestMapping(value="/{tname}/insertEventLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(
			@PathVariable String tname,
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int boardLikeCount=0;
		// SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		//paramMap.put("userId", info.getUserId());
		int result=service.insertBoardLike(paramMap);
		if(result==0) {
			state="false";
		}
			
		boardLikeCount = service.boardLikeCount(num);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("boardLikeCount", boardLikeCount);
		
		return model;
	}
	
	// 댓글 리스트 : AJAX-TEXT
	@RequestMapping(value="/{tname}/event/listReply")
	public String listReply(
			@PathVariable String tname,
			@RequestParam int eventNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("eventNum", eventNum);
		map.put("tname", tname);
		
		dataCount=service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		map.put("tname", tname);
		List<EventReply> listReply=service.listReply(map);
		
		for(EventReply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// AJAX 용 페이징
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return tname+"/event/listReply";
	}
	
	
	
	// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
	@RequestMapping(value="/{tname}/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@PathVariable String tname,
			@RequestParam Map<String, Object> paramMap
			) {
		String state="true";
		service.deleteReply(paramMap);
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	 
	
	
	
}
