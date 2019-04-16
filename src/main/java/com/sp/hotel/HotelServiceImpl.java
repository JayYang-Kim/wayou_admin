package com.sp.hotel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("hotel.HotelService")
public class HotelServiceImpl implements HotelService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertHotel(Hotel dto, String pathname) {
		int result=0;
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			dto.setSaveFilename(saveFilename);
			
			result=dao.insertData("hotel.insertHotel", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Hotel> listHotel(Map<String, Object> map) {
		List<Hotel> list = null;
		
		try {
			list = dao.selectList("hotel.listHotel",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int hotelCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("hotel.hotelCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	
}
