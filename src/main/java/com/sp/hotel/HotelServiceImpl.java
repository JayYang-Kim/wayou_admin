package com.sp.hotel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

	@Override
	public Hotel readHotel(int num) {
		Hotel dto = null;
		try {
			dto=dao.selectOne("hotel.readHotel", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int updateHotel(Hotel dto, String pathname) {
		int result=0;
		try {
			result=dao.updateData("hotel.updateHotel", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int insertRoom(Room dto, String pathname) {
		int result=0;
		try {
			int seq=dao.selectOne("room.seq");
			dto.setRoomCode(seq);
			
			result=dao.insertData("room.insertRoom",dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						
						insertFile(dto);
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int insertFile(Room dto) {
		int result=0;
		try {
			result=dao.insertData("room.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Room> listRoom(int num) {
		List<Room> list = null;
		try {
			list=dao.selectList("room.listRoom", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Room readRoom(int num) {
		Room dto = null;
		try {
			dto=dao.selectOne("room.readRoom", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<Room> listFile(int num) {
		List<Room> listFile = null;
		try {
			listFile=dao.selectList("room.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public int updateRoom(Room dto, String pathname) {
		int result=0;
		try {
			result=dao.updateData("room.updateRoom", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						
						insertFile(dto);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Schedule> listHotelName() {
		List<Schedule> listHotelName = null;
		try {
			listHotelName=dao.selectList("schedule.listHotelName");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listHotelName;
	}

	@Override
	public List<Integer> listRoomNum(int num) {
		List<Integer> listRoomNum = null;
		try {
			listRoomNum = dao.selectList("schedule.listRoomNum", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listRoomNum;
	}

	@Override
	public List<String> listCheckIn(int num) {
		List<String> listCheckIn = null;
		try {
			listCheckIn = dao.selectList("schedule2.listCheckIn", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCheckIn;
	}
	
	@Override
	public List<Customer> listCustomer(Map<String, Object> map) {
		List<Customer> list = null;
		
		try {
			list = dao.selectList("customer.listCustomer",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int customerCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("customer.customerCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


	
	
	
}
