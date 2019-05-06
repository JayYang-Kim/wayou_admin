package com.sp.attendance;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.admin.AdminSessionInfo;
import com.sp.common.MyUtil;

@Controller(value="attendance.attendanceController")
public class AttendanceController {
	@Autowired
	private AttendanceService att;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/attendance/list")
	public String listAtt(
			@RequestParam (value="page", defaultValue="1" )int current_page,
			@RequestParam (defaultValue="departCode") String condition,
			@RequestParam (defaultValue="")String word,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			word=URLDecoder.decode(word, "utf-8");
		}
		
		int rows=10;
		int dataCount=0;
		int total_page=0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("word", word);
		dataCount=att.dataCount(map);
		
		if(dataCount !=0) {
			total_page=myUtil.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		
		int listNum=0;
		int n=0;
		
		List<Attendance> listAtt = att.listAtt(map);
		for(Attendance dto : listAtt) {
			listNum = dataCount - (start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String listUrl = cp;
		
		if(word.length()!=0) {
			listUrl += "?condtion="+condition+"&word="+URLEncoder.encode(word, "utf-8");
		}
		
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		int departCode=info.getDepartCode();
		int idnCode=info.getIdnCode();
		
		
		String paging = myUtil.pagingMethod(current_page, total_page, listUrl);
		
		
		
		model.addAttribute("departCode",departCode);
		model.addAttribute("idnCode",idnCode);
		model.addAttribute("page",current_page);
		model.addAttribute("listAtt",listAtt);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);
		model.addAttribute("condition",condition);
		model.addAttribute("word",word);
		
		
		return ".attendance.list";
	}
	
	@RequestMapping(value="/attendance/inAtt")
	@ResponseBody
	public Map<String, Object> inAtt(HttpSession session){ 
		Map<String, Object> model = new HashMap<>();
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		int adminIdx=info.getAdminIdx();
		String startTime=null;
		try {
			startTime=att.inAtt(adminIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.put("startTime", startTime);
		
		return model;
	}
	
	@RequestMapping(value="/attendance/outAtt")
	@ResponseBody
	public Map<String, Object> outAtt(HttpSession session){
		Map<String, Object> model = new HashMap<>();
		AdminSessionInfo info = (AdminSessionInfo)session.getAttribute("admin");
		int adminIdx=info.getAdminIdx();
		Attendance dto=new Attendance();
		
		try {
			String today=att.today();
			dto.setToday(today);
			dto.setAdminIdx(adminIdx);
			
			int result=att.checkAtt(dto);
			if(result==0) {//출근 없음
				
			}
			
			if(result==1) {//출근 있고 퇴근 없음
				result=att.outAtt(dto);
				if(result!=0)
				dto=att.check3(dto);
				att.outAtt2(dto);
				dto=att.check4(dto);
			}
			
			if(result==2) {//출근 퇴근도 있음
				dto=att.check5(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String endTime=dto.getEndTime();
		int dayTotal=dto.getDayTotal();
		
		model.put("endTime", endTime);
		model.put("dayTotal", dayTotal);
		return model;
	} 

}
