package com.sp.travel.landmark;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("travel.landmark.landmarkService")
public class LandMarkServiceImpl implements LandMarkService{

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public List<LandMark> listLocation() throws Exception {
		List<LandMark> list = null;
		
		try {
			list = dao.selectList("travel.landmark.listLocation");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<LandMark> listTag() throws Exception {
		List<LandMark> list = null;
		
		try {
			list = dao.selectList("travel.landmark.listTag");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public int insertLandMark(LandMark dto, String pathname) throws Exception {
		int result = 0;
		
		try {
			int seq = dao.selectOne("travel.landmark.seqLandCode");
			dto.setLandCode(seq);
			
			dao.insertData("travel.landmark.insertLanmark", dto);
			dao.insertData("travel.landmark.insertLanmarkLog", dto);
			
			if(!dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					if(mf.isEmpty()) {
						continue;
					}
					
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename != null) {
						dto.setSaveFilename(saveFilename);
						
						insertFile(dto);
					}
				}
			}
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}
	
	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<LandMark> listLandMark(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public LandMark readLandMark(int landCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public LandMark preReadLandMark(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public LandMark nextReadLandMark(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int updateLandMark(LandMark dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int deleteLandMark(int landCode, String pathname) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<LandMark> listLandMarkLog(int landCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<LandMark> allLandMarkLog(int landCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertFile(LandMark dto) throws Exception {
		int result = 0;
		
		try {
			result = dao.insertData("travel.landmark.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public List<LandMark> listFile(int num) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public LandMark readFile(int fileNum) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
}
