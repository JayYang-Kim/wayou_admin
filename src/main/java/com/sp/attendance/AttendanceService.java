package com.sp.attendance;

import java.util.List;
import java.util.Map;

public interface AttendanceService {
	public String inAtt(int adminIdx) throws Exception;
	public String today() throws Exception;
	public int checkAtt(Attendance dto) throws Exception;
	public int outAtt(Attendance dto) throws Exception;
	public int outAtt2(Attendance dto) throws Exception;
	public Attendance check3(Attendance dto) throws Exception;
	public Attendance check4(Attendance dto) throws Exception;
	public Attendance check5(Attendance dto) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Attendance> listAtt(Map<String, Object> map) throws Exception;
}
