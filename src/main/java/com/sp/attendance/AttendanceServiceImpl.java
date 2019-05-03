package com.sp.attendance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("attendanceService")
public class AttendanceServiceImpl implements AttendanceService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertAtt(int adminIdx) throws Exception {
		int result=0;
		
		try {
			result=dao.insertData("attendance.insertAtt", adminIdx);
		} catch (Exception e) {
		}
		return result;
	}

}
