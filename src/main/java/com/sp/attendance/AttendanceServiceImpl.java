package com.sp.attendance;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("attendanceService")
public class AttendanceServiceImpl implements AttendanceService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public String inAtt(int adminIdx) throws Exception {
		String result=null;
		
		try {
			result=dao.selectOne("attendance.checkIn", adminIdx);
			if(result!=null) {
				return result;
			}
			dao.insertData("attendance.inAtt", adminIdx);
			result=dao.selectOne("attendance.checkIn", adminIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String today() throws Exception {
		String today=null;
		Calendar cal = Calendar.getInstance();
		int year =cal.get(Calendar.YEAR);
		int mon =cal.get(Calendar.MONTH)+1;
		
		String month=null;
		if(mon <10) {
			month="0"+String.valueOf(mon);
		}
		
		int d = cal.get(Calendar.DAY_OF_MONTH);
		
		String day=null;
		if(d <10) {
			day="0"+String.valueOf(d);
		}
		try {
			today=year+"-"+month+"-"+day;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return today;
	}

	@Override
	public int checkAtt(Attendance dto) throws Exception {
		int result=0;
			try {
				result=dao.selectOne("attendance.check1", dto);
				if(result==0) {
					return result;
				}
				result=dao.selectOne("attendance.check2", dto);
				if(result==0) {
					return result=1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result=2;
	}

	@Override
	public int outAtt(Attendance dto) throws Exception {
		dao.selectOne("attendance.outAtt", dto);
		int result=1;
		return result;
	}
	
	@Override
	public int outAtt2(Attendance dto) throws Exception {
		dao.selectOne("attendance.outAtt2", dto);
		int result=1;
		return result;
	}

	@Override
	public Attendance check3(Attendance dto) throws Exception {
		dto=dao.selectOne("attendance.check3", dto);
		return dto;
	}
	
	@Override
	public Attendance check4(Attendance dto) throws Exception {
		dto=dao.selectOne("attendance.check4", dto);
		return dto;
	}
	
	@Override
	public Attendance check5(Attendance dto) throws Exception {
		dto=dao.selectOne("attendance.check5", dto);
		return dto;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result= dao.selectOne("attendance.dataCount", map);
		return result;
	}

	@Override
	public List<Attendance> listAtt(Map<String, Object> map) throws Exception {
		List<Attendance> list = dao.selectList("attendance.listAtt", map);
		return list;
	}
	

}
