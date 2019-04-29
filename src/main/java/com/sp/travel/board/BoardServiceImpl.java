package com.sp.travel.board;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("travel.board.boardService")
public class BoardServiceImpl implements BoardService{
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertNotice(Board dto, String pathname) throws Exception {
		int result = 0;
		
		try {
			int seq = dao.selectOne("travel.notice.seqNotiCode");
			dto.setNotiCode(seq);
			
			dao.insertData("travel.notice.insertNotice", dto);
			
			if(!dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					if(mf.isEmpty()) {
						continue;
					}
					
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename != null) {
						String originalFilename = mf.getOriginalFilename();
						
						dto.setSaveFilename(saveFilename);
						dto.setOriginalFilename(originalFilename);
						insertNoticeFile(dto);
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
	public int dataCountNotice(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("travel.notice.dataCountNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public List<Board> listNotice(Map<String, Object> map) throws Exception {
		List<Board> list = null;
		
		try {
			list = dao.selectList("travel.notice.listNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public Board readNotice(int notiCode) throws Exception {
		Board dto = null;
		
		try {
			dto = dao.selectOne("travel.notice.readNotice", notiCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public Board preReadNotice(Map<String, Object> map) throws Exception {
		Board dto = null;
		
		try {
			dto = dao.selectOne("travel.notice.preReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public Board nextReadNotice(Map<String, Object> map) throws Exception {
		Board dto = null;
		
		try {
			dto = dao.selectOne("travel.notice.nextReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public int updateNotice(Board dto, String pathname) throws Exception {
		int result = 0;
		
		try {
			dao.updateData("travel.notice.updateNotice", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty()) {
						continue;
					}
					
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						insertNoticeFile(dto);
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
	public int deleteNotice(int notiCode, String pathname) throws Exception {
		int result = 0;
		
		try {
			List<Board> listNoticeFile = listNoticeFile(notiCode);
			if(listNoticeFile!=null) {
				Iterator<Board> it = listNoticeFile.iterator();
				while(it.hasNext()) {
					Board dto = it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			deleteAllNoticeFile(notiCode);
			
			dao.deleteData("travel.notice.deleteNotice", notiCode);
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int insertNoticeFile(Board dto) throws Exception {
		int result = 0;
		
		try {
			result = dao.insertData("travel.notice.insertNoticeFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public List<Board> listNoticeFile(int notiCode) throws Exception {
		List<Board> list = null;
		
		try {
			list = dao.selectList("travel.notice.listNoticeFile", notiCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Board readNoticeFile(int fileCode) throws Exception {
		Board dto = null;
		
		try {
			dto = dao.selectOne("travel.notice.readNoticeFile", fileCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int deleteNoticeFile(int fileCode) throws Exception {
		int result = 0;
		
		try {
			result = dao.deleteData("travel.notice.deleteNoticeFile", fileCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int deleteAllNoticeFile(int notiCode) throws Exception {
		int result = 0;
		
		try {
			result = dao.deleteData("travel.notice.deleteAllNoticeFile", notiCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}
}
