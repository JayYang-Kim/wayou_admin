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

	@Override
	public int insertEvent(Board dto, String pathname) throws Exception {
		int result = 0;
		
		try {
			int seq = dao.selectOne("travel.event.seqEventCode");
			dto.setEventCode(seq);
			
			dao.insertData("travel.event.insertEvent", dto);
			
			if(!dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					if(mf.isEmpty()) {
						continue;
					}
					
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename != null) {
						dto.setSaveFilename(saveFilename);
						insertEventFile(dto);
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
	public int dataCountEvent(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("travel.event.dataCountEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Board> listEvent(Map<String, Object> map) throws Exception {
		List<Board> list = null;
		
		try {
			list = dao.selectList("travel.event.listEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Board readEvent(int eventCode) throws Exception {
		Board dto = null;
		
		try {
			dto = dao.selectOne("travel.event.readEvent", eventCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Board preReadEvent(Map<String, Object> map) throws Exception {
		Board dto = null;
		
		try {
			dto = dao.selectOne("travel.event.preReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Board nextReadEvent(Map<String, Object> map) throws Exception {
		Board dto = null;
		
		try {
			dto = dao.selectOne("travel.event.nextReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int updateEvent(Board dto, String pathname) throws Exception {
		int result = 0;
		
		try {
			dao.updateData("travel.event.updateEvent", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty()) {
						continue;
					}
					
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						dto.setSaveFilename(saveFilename);
						insertEventFile(dto);
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
	public int deleteEvent(int eventCode, String pathname) throws Exception {
		int result = 0;
		
		try {
			List<Board> listNoticeFile = listNoticeFile(eventCode);
			if(listNoticeFile!=null) {
				Iterator<Board> it = listNoticeFile.iterator();
				while(it.hasNext()) {
					Board dto = it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			deleteAllEventFile(eventCode);
			
			dao.deleteData("travel.event.deleteEvent", eventCode);
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int insertEventFile(Board dto) throws Exception {
		int result = 0;
		
		try {
			result = dao.insertData("travel.event.insertEventFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public List<Board> listEventFile(int eventCode) throws Exception {
		List<Board> list = null;
		
		try {
			list = dao.selectList("travel.event.listEventFile", eventCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Board readEventFile(int fileCode) throws Exception {
		Board dto = null;
		
		try {
			dto = dao.selectOne("travel.event.readEventFile", fileCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int deleteEventFile(int fileCode) throws Exception {
		int result = 0;
		
		try {
			result = dao.deleteData("travel.event.deleteEventFile", fileCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int deleteAllEventFile(int eventCode) throws Exception {
		int result = 0;
		
		try {
			result = dao.deleteData("travel.event.deleteAllEventFile", eventCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}
}
