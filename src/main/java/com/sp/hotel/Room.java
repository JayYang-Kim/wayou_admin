package com.sp.hotel;

public class Room {
	private int roomCode, hotelCode;
	private int roomtypeCode, roomNum;
	private int hCount, price;
	private String information, notice, cancel_notice;
	
	public int getRoomCode() {
		return roomCode;
	}
	public void setRoomCode(int roomCode) {
		this.roomCode = roomCode;
	}
	public int getHotelCode() {
		return hotelCode;
	}
	public void setHotelCode(int hotelCode) {
		this.hotelCode = hotelCode;
	}
	public int getRoomtypeCode() {
		return roomtypeCode;
	}
	public void setRoomtypeCode(int roomtypeCode) {
		this.roomtypeCode = roomtypeCode;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public int gethCount() {
		return hCount;
	}
	public void sethCount(int hCount) {
		this.hCount = hCount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getInformation() {
		return information;
	}
	public void setInformation(String information) {
		this.information = information;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getCancel_notice() {
		return cancel_notice;
	}
	public void setCancel_notice(String cancel_notice) {
		this.cancel_notice = cancel_notice;
	}
	
}
