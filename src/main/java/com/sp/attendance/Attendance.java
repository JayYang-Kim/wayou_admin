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
	public int getDayTotal() {
		return dayTotal;
	}
	public void setDayTotal(int dayTotal) {
		this.dayTotal = dayTotal;
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
	
	
}
