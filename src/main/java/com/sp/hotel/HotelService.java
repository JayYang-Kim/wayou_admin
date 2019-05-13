package com.sp.hotel;

import java.util.List;
import java.util.Map;


public interface HotelService {
	public int insertHotel(Hotel dto, String pathname);
	public List<Hotel> listHotel(Map<String, Object> map);
	public int hotelCount(Map<String, Object> map);
	public Hotel readHotel(int num);
	public int updateHotel(Hotel dto, String pathname);
	
	public int insertRoom(Room dto, String pathname);
	public List<Room> listRoom(int num);
	public Room readRoom(int num);
	public int updateRoom(Room dto, String pathname);
	public int deleteRoom(int roomCode, String pathname);
	public int deleteReserve(int roomCode);
	
	public int insertFile(Room dto);
	public List<Room> listFile(int num);
	public Room readFile(int fileCode) ;
	public int deleteFile(int fileCode);
	public int deleteAllFile(int roomCode);
	
	public List<Schedule> listHotelName();
	public List<Integer> listRoomNum(int num);
	
	public List<String> listCheckIn(int num);

	
	
	
	public List<Customer> listCustomer(Map<String, Object> map);
	public int customerCount(Map<String, Object> map);
}
