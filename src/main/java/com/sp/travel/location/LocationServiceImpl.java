package com.sp.travel.location;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("travel.location.locationService")
public class LocationServiceImpl implements LocationService{

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public List<Location> locList() throws Exception {
		List<Location> list = null;
		
		try {
			list = dao.selectList("travel.location.listLoc");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int insertLocation(Location dto, String pathName) throws Exception {
		int result = 0;
		
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathName);
			if(saveFilename != null) {
				dto.setSaveFilename(saveFilename);
			}
			dao.insertData("travel.location.insertLocation", dto);
			dao.insertData("travel.location.insertLocationLog", dto);
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("travel.location.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Location> locationList(Map<String, Object> map) throws Exception {
		List<Location> list = null;
		
		try {
			list = dao.selectList("travel.location.listLocation", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Location readLocation(int locCode) throws Exception {
		Location dto = null;
		
		try {
			dto = dao.selectOne("travel.location.readLocation", locCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public Location preReadLocation(Map<String, Object> map) throws Exception {
		Location dto = null;
		
		try {
			dto = dao.selectOne("travel.location.preReadLocation", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Location nextReadLocation(Map<String, Object> map) throws Exception {
		Location dto = null;
		
		try {
			dto = dao.selectOne("travel.location.nextReadLocation", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public List<Location> listLocationLog(int locCode) throws Exception {
		List<Location> list = null;
		
		try {
			list = dao.selectList("travel.location.listLocationLog", locCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Location> allLocationLog(int locCode) throws Exception {
		List<Location> list = null;
		
		try {
			list = dao.selectList("travel.locatin.allLocationLog", locCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int updateLocation(Location dto, String pathname) throws Exception {
		int result = 0;
		
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			
			if(saveFilename != null) {
				if(dto.getSaveFilename() != null && dto.getSaveFilename().length() != 0) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
				
				dto.setSaveFilename(saveFilename);
			}
			
			dao.updateData("travel.location.updateLocation", dto);
			dao.insertData("travel.location.insertLocationLog", dto);
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int deleteLocation(int locCode, String pathname) throws Exception {
		int result = 0;
		
		try {
			Location dto = readLocation(locCode);
			if(dto == null) {
				return result;
			}
			
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			
			dao.deleteData("travel.location.deleteLocationLog", locCode);
			dao.deleteData("travel.location.deleteLocation", locCode);
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}
}
