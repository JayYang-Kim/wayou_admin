package com.sp.attendance;

public class Attendance {
	private int attCode;
	private int adminIdx;
	private String startTime;
	private String endTime;
	private String created;
	private int dayTotal;
	private int weekTotal;
	private int monthTotal;
	private String today;
	private int listNum;
	private String departName;
	private String departCode;
	private String idnCode;
	private String positionCode;
	private String positionName;
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	private String adminName;
	
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	public String getDepartCode() {
		return departCode;
	}
	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}
	public String getIdnCode() {
		return idnCode;
	}
	public void setIdnCode(String idnCode) {
		this.idnCode = idnCode;
	}
	public String getPositionCode() {
		return positionCode;
	}
	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getAttCode() {
		return attCode;
	}
	public void setAttCode(int attCode) {
		this.attCode = attCode;
	}
	public int getAdminIdx() {
		return adminIdx;
	}
	public void setAdminIdx(int adminIdx) {
		this.adminIdx = adminIdx;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}

	public int getWeekTotal() {
		return weekTotal;
	}
	public void setWeekTotal(int weekTotal) {
		this.weekTotal = weekTotal;
	}
	public int getMonthTotal() {
		return monthTotal;
	}
	public void setMonthTotal(int monthTotal) {
		this.monthTotal = monthTotal;
	}
	public String getToday() {
		return today;
	}
	public void setToday(String today) {
		this.today = today;
	}
	public int getDayTotal() {
		return dayTotal;
	}
	public void setDayTotal(int dayTotal) {
		this.dayTotal = dayTotal;
	}
	
	
}
