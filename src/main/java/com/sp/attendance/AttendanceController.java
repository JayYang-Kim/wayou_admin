package com.sp.attendance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller(value="attendance.attendanceController")
public class AttendanceController {
	@Autowired
	private AttendanceService att;
	
	@RequestMapping(value="/attendance/list")
	public String listAtt() throws Exception{
		
		return ".attendance.list";
	}
}
