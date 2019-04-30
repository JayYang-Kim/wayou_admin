package com.sp.store;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("store.StoreService")
public class StoreServiceImpl implements StoreService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public int insertStore(Store dto, String pathname) {
		int result=0;
		try {
			int seq=dao.selectOne("store.seq");
			dto.setStoreCode(seq);
			
			result=dao.insertData("store.insertStore",dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						
						insertStoreFile(dto);
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int insertStoreFile(Store dto) {
		int result=0;
		try {
			result=dao.insertData("store.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Store> listStore(Map<String, Object> map) {
		List<Store> list = null;
		
		try {
			list = dao.selectList("store.listStore",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int storeCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("store.storeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Store readStore(int num) {
		Store dto = null;
		try {
			dto=dao.selectOne("store.readStore", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public List<Store> listStoreFile(int num) {
		List<Store> listFile = null;
		try {
			listFile=dao.selectList("store.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public int insertTicket(Ticket dto, String pathname) {
		int result=0;
		try {
			int seq=dao.selectOne("ticket.seq");
			dto.setTicketCode(seq);
			
			result=dao.insertData("ticket.insertTicket",dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						
						insertTicketFile(dto);
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Ticket> listTicket() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertTicketFile(Ticket dto) {
		int result=0;
		try {
			result=dao.insertData("ticket.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Ticket> listTicketFile(int num) {
		// TODO Auto-generated method stub
		return null;
	}


}
