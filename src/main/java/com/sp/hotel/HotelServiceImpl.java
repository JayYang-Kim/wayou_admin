package com.sp.hotel;

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

		}
		return result;
	}
	
}
