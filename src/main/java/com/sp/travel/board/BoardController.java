package com.sp.travel.board;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

@Controller("travel.board.boardController")
public class BoardController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/travel/admin/board/{tname}/list")
	public String list(@PathVariable String tname,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="subject") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		int dataCount = 0;
		int total_page = 0;
		int rows = 10;
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		if(tname.equalsIgnoreCase("notice")) {
			dataCount = boardService.dataCountNotice(map);
		} else if(tname.equalsIgnoreCase("event")) {
			dataCount = boardService.dataCountEvent(map);
		}
		
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Board> list = null;
		
		if(tname.equalsIgnoreCase("notice")) {
			list = boardService.listNotice(map);
		} else if(tname.equalsIgnoreCase("event")) {
			list = boardService.listEvent(map);
		}
		
		int listNum, n = 0;
		for(Board dto : list) {
			listNum = dataCount - (start + n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String listUrl = cp + "/travel/admin/board/"+ tname +"/list";
		String articleUrl = cp + "/travel/admin/board/"+ tname +"/view?page=" + current_page;
		
		if(searchValue.length() != 0) {
			String query = "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		return ".travel."+ tname +".list";
	}
	
	@RequestMapping(value="/travel/admin/board/{tname}/add", method = RequestMethod.GET)
	public String add(@PathVariable String tname,
			Model model) throws Exception {
		model.addAttribute("mode", "add");
		
		return ".travel."+ tname +".add";
	}
	
	@RequestMapping(value="/travel/admin/board/{tname}/add", method = RequestMethod.POST)
	public String add(@PathVariable String tname,
			Board dto,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			return "redirect:/travel/admin/board/"+ tname +"/list";
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + tname;
		 
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		dto.setAdminIdx(info.getAdminIdx());
		
		try {
			if(tname.equalsIgnoreCase("notice")) {
				boardService.insertNotice(dto, pathname);
			} else if(tname.equalsIgnoreCase("event")) {
				boardService.insertEvent(dto, pathname);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/travel/admin/board/"+ tname +"/list";
	}
	
	@RequestMapping(value="/travel/admin/board/{tname}/view")
	public String view(@PathVariable String tname,
			@RequestParam(defaultValue="0") int notiCode,
			@RequestParam(defaultValue="0") int eventCode,
			@RequestParam int page,
			@RequestParam(defaultValue="locName") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			Model model) throws Exception {
		
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		String query = "?page=" + page;
		
		if(searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		Board dto = null;
		
		if(tname.equalsIgnoreCase("notice")) {
			dto = boardService.readNotice(notiCode);
		} else if(tname.equalsIgnoreCase("event")) {
			dto = boardService.readEvent(eventCode);
		}
		
		if(dto == null) {
			return "redirect:/travel/admin/board/"+ tname +"/list" + query;
		}
		
		dto.setContent(myUtil.htmlSymbols(dto.getContent()));
		
		List<Board> listBoardFile = null;
		
		if(tname.equalsIgnoreCase("notice")) {
			listBoardFile = boardService.listNoticeFile(notiCode);
		} else if(tname.equalsIgnoreCase("event")) {
			listBoardFile = boardService.listEventFile(eventCode);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		if(tname.equalsIgnoreCase("notice")) {
			map.put("notiCode", notiCode);
		} else if(tname.equalsIgnoreCase("event")) {
			map.put("eventCode", eventCode);
		}
		
		Board preReadBoard = null;
		Board nextReadBoard = null;
		if(tname.equalsIgnoreCase("notice")) {
			preReadBoard = boardService.preReadNotice(map);
			nextReadBoard = boardService.nextReadNotice(map);
		} else if(tname.equalsIgnoreCase("event")) {
			preReadBoard = boardService.preReadEvent(map);
			nextReadBoard = boardService.nextReadEvent(map);
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("listBoardFile", listBoardFile);
		model.addAttribute("preReadBoard", preReadBoard);
		model.addAttribute("nextReadBoard", nextReadBoard);
		model.addAttribute("query", query);
		
		return ".travel."+ tname +".view";
	}
	
	@RequestMapping(value="/travel/admin/board/{tname}/update", method = RequestMethod.GET)
	public String update(@PathVariable String tname,
			@RequestParam(defaultValue="0") int notiCode,
			@RequestParam(defaultValue="0") int eventCode,
			@RequestParam int page,
			@RequestParam(defaultValue="locName") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			Model model) throws Exception {
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		String query = "?page=" + page;
		
		if(searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		Board dto = null;
		
		if(tname.equalsIgnoreCase("notice")) {
			dto = boardService.readNotice(notiCode);
		} else if(tname.equalsIgnoreCase("event")) {
			dto = boardService.readEvent(eventCode);
		}
		
		if(dto == null) {
			return "redirect:/travel/admin/board/"+ tname +"/list" + query;
		}
		
		List<Board> listBoardFile = null;
		if(tname.equalsIgnoreCase("notice")) {
			listBoardFile = boardService.listNoticeFile(notiCode);
		} else if(tname.equalsIgnoreCase("event")) {
			listBoardFile = boardService.listEventFile(eventCode);
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("listBoardFile", listBoardFile);
		model.addAttribute("query", query);
		model.addAttribute("mode", "update");
		
		return ".travel."+ tname +".add";
	}
	
	@RequestMapping(value="/travel/admin/board/{tname}/update", method = RequestMethod.POST)
	public String updateSubmit(@PathVariable String tname,
			Board dto,
			@RequestParam int page,
			@RequestParam(defaultValue="locName") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpSession session) throws Exception {
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		String query = "?page=" + page;
		
		if(searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + tname;	
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		dto.setAdminIdx(info.getAdminIdx());
		
		try {
			if(tname.equalsIgnoreCase("notice")) {
				boardService.updateNotice(dto, pathname);
			} else if(tname.equalsIgnoreCase("event")) {
				boardService.updateEvent(dto, pathname);
			}
		} catch (Exception e) {
			if(tname.equalsIgnoreCase("notice")) {
				return "redirect:/travel/admin/board/"+ tname +"/update" + query + "&notiCode=" + dto.getNotiCode();
			} else if(tname.equalsIgnoreCase("event")) {
				return "redirect:/travel/admin/board/"+ tname +"/update" + query + "&eventCode=" + dto.getEventCode();
			}
		}
		
		return "redirect:/travel/admin/board/"+ tname +"/list" + query;
	}
	
	@RequestMapping(value="/travel/admin/board/notice/download")
	public void download(@RequestParam int fileCode,
			HttpServletRequest req,
			HttpServletResponse resp,
			HttpSession session
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "notice";
		
		Board dto = boardService.readNoticeFile(fileCode);
		
		if(dto!=null) {
			boolean b=fileManager.doFileDownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
			if(b) return;
		}
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print("<script>alert('파일 다운로드를 실패했습니다.');history.back();</script>");
	}
	
	@RequestMapping(value="/travel/admin/board/{tname}/delete")
	public String delete(@PathVariable String tname,
			@RequestParam(defaultValue="0") int notiCode,
			@RequestParam(defaultValue="0") int eventCode,
			@RequestParam int page,
			@RequestParam(defaultValue="locName") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			HttpSession session) throws Exception {
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		String query = "?page=" + page;
		
		if(searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + tname;
					
		try {
			if(tname.equalsIgnoreCase("notice")) {
				boardService.deleteNotice(notiCode, pathname);
			} else if(tname.equalsIgnoreCase("event")) {
				boardService.deleteEvent(eventCode, pathname);
			}
		} catch (Exception e) {
			if(tname.equalsIgnoreCase("notice")) {
				return "redirect:/travel/admin/board/"+ tname +"/view" + query + "&notiCode=" + notiCode;
			} else if(tname.equalsIgnoreCase("event")) {
				return "redirect:/travel/admin/board/"+ tname +"/view" + query + "&eventCode=" + eventCode;
			}
		}
		
		return "redirect:/travel/admin/board/"+ tname +"/list" + query;
	}
	
	@RequestMapping(value="/travel/admin/board/{tname}/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@PathVariable String tname,
			@RequestParam int fileCode,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + tname;
			
		Map<String, Object> model = new HashMap<>(); 
		
		String msg = "true";
		
		Board dto = null;
		
		if(tname.equalsIgnoreCase("notice")) {
			dto = boardService.readNoticeFile(fileCode);
		} else if(tname.equalsIgnoreCase("event")) {
			dto = boardService.readEventFile(fileCode);
		}
		
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		try {
			if(tname.equalsIgnoreCase("notice")) {
				boardService.deleteNoticeFile(fileCode);
			} else if(tname.equalsIgnoreCase("event")) {
				boardService.deleteEventFile(fileCode);
			}
		} catch (Exception e) {
			msg = "false";
		}
		
		model.put("msg", msg);
		
		return model;
	}
}
