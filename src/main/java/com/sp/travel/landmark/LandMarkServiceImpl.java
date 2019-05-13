package com.sp.travel.landmark;

import java.util.Iterator;
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
					
					String saveFilename = fileManager.doFileUpload2(mf,"landmark");
					if(saveFilename != null) {
						dto.setSaveFilename(saveFilename);
						
						insertFile(dto);
					}
				}
			}
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("travel.landmark.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public List<LandMark> listLandMark(Map<String, Object> map) throws Exception {
		List<LandMark> list = null;
		
		try {
			list = dao.selectList("travel.landmark.listLandmark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public LandMark readLandMark(int landCode) throws Exception {
		LandMark dto = null;
		
		try {
			dto = dao.selectOne("travel.landmark.readLandmark", landCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public LandMark preReadLandMark(Map<String, Object> map) throws Exception {
		LandMark dto = null;
		
		try {
			dto = dao.selectOne("travel.landmark.preReadLandmark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public LandMark nextReadLandMark(Map<String, Object> map) throws Exception {
		LandMark dto = null;
		
		try {
			dto = dao.selectOne("travel.landmark.nextReadLandmark", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public int updateLandMark(LandMark dto, String pathname) throws Exception {
		int result = 0;
		
		try {
			dao.updateData("travel.landmark.updateLandmark", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty()) {
						continue;
					}
					
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						dto.setSaveFilename(saveFilename);
						insertFile(dto);
					}
				}
			}
			
			dao.insertData("travel.landmark.insertLanmarkLog", dto);
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}
	
	@Override
	public int deleteLandMark(int landCode, String pathname) throws Exception {
		int result = 0;
		
		try {
			List<LandMark> listFile = listFile(landCode);
			if(listFile!=null) {
				Iterator<LandMark> it = listFile.iterator();
				while(it.hasNext()) {
					LandMark dto = it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			deleteAllFile(landCode);
			
			dao.deleteData("travel.landmark.deleteLandmarkLog", landCode);
			dao.deleteData("travel.landmark.deleteLandmark", landCode);
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}
	
	@Override
	public List<LandMark> listLandMarkLog(int landCode) throws Exception {
		List<LandMark> list = null;
		
		try {
			list = dao.selectList("travel.landmark.listLandmarkLog", landCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<LandMark> allLandMarkLog(int landCode) throws Exception {
		List<LandMark> list = null;
		
		try {
			list = dao.selectList("travel.landmark.allLandmarkLog", landCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
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
	public List<LandMark> listFile(int landCode) throws Exception {
		List<LandMark> list = null;
		
		try {
			list = dao.selectList("travel.landmark.listLandmarkFile", landCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public LandMark readFile(int fileCode) throws Exception {
		LandMark dto = null;
		
		try {
			dto = dao.selectOne("travel.landmark.readLandmarkFile", fileCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int deleteFile(int fileCode) throws Exception {
		int result = 0;
		
		try {
			result = dao.deleteData("travel.landmark.deleteLandmarkFile", fileCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int deleteAllFile(int landCode) throws Exception {
		int result = 0;
		
		try {
			result = dao.deleteData("travel.landmark.deleteAllLandmarkFile", landCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}
}
