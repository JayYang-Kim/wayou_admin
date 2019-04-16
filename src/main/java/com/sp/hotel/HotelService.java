package com.sp.hotel;

import java.util.List;
import java.util.Map;

public interface HotelService {
	public int insertHotel(Hotel dto, String pathname);
	public List<Hotel> listHotel(Map<String, Object> map);
	public int hotelCount(Map<String, Object> map);

}
