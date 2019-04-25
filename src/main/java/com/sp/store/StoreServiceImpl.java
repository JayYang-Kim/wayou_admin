package com.sp.store;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("ticket.TicketService")
public class StoreServiceImpl implements StoreService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public int insertTicket(Ticket dto, String pathname) {
		int result=0;
		try {
			int seq=dao.selectOne("room.seq");
			//dto.setRoomCode(seq);
			
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
	public int insertFile(Ticket dto) {
		int result=0;
		try {
			result=dao.insertData("room.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
