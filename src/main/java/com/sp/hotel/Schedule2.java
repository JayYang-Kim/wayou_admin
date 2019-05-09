package com.sp.hotel;

import java.util.List;

public class Schedule2 {
	
	private int roomNum;
	private int hotelCode;
	private String checkIn;
	private String checkOut;
	
	private List<String> checkInDay;
	
	
	
	public String getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}
	public String getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	
	
	
	public int getHotelCode() {
		return hotelCode;
	}
	public void setHotelCode(int hotelCode) {
		this.hotelCode = hotelCode;
	}
	public List<String> getCheckInDay() {
		return checkInDay;
	}
	public void setCheckInDay(List<String> checkInDay) {
		this.checkInDay = checkInDay;
	}

	

	
	

	
	
}
