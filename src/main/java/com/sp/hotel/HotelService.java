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
	public List<Room> listRoom();
	public Room readRoom(int num);
	public int updateRoom(Room dto, String pathname);
	
	public int insertFile(Room dto);
	public List<Room> listFile(int num);
}
