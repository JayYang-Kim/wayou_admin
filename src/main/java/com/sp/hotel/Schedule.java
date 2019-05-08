package com.sp.hotel;

import java.util.List;

public class Schedule {
	private String hName;
	private int count;
	private int hotelCode;
	private int day;
	
	private List<Integer> roomNum;
	

	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getHotelCode() {
		return hotelCode;
	}
	public void setHotelCode(int hotelCode) {
		this.hotelCode = hotelCode;
	}
	public String gethName() {
		return hName;
	}
	public void sethName(String hName) {
		this.hName = hName;
	}
	public List<Integer> getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(List<Integer> roomNum) {
		this.roomNum = roomNum;
	}

		
	

	


		

	
	
}
