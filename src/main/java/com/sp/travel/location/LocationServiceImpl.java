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
			result = dao.insertData("travel.location.insertLocation", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public List<Location> locationList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
