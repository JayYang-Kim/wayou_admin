package com.sp.work;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("workServie")
public class WorkServiceImpl implements WorkService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertWork(Work dto) {
		int result = 0;
		
		try {
			result=dao.insertData("work.insertWork", dto);
			result=1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Work readAdmin(int AdminIdx) {
		Work dto = new Work();
		try {
			dto=dao.selectOne("work.readAdmin", AdminIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int searchWork(int AdminIdx) {
		int dayWork = 0;
		try {
			dayWork=dao.selectOne("work.searchWork", AdminIdx);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dayWork;
	}

	@Override
	public List<Work> listWork(Map<String, Object> map) throws Exception {
		List<Work> list = null;
		
		try {
			list=dao.selectList("work.listWork",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result=0;
		
		try {
			result=dao.selectOne("work.dataCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Work articleWork(int diaryCode) throws Exception {
		Work dto = null;
		
		try {
			dto=dao.selectOne("work.articleWork", diaryCode);
			System.out.println("ㅅㅅ : " +dto.getModifyDate());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public String todayDiary() throws Exception {
		String today=null;
		Calendar cal = Calendar.getInstance();
		int year =cal.get(Calendar.YEAR);
		int mon =cal.get(Calendar.MONTH)+1;
		
		String month=null;
		if(mon <10) {
			month="0"+String.valueOf(mon);
		}
		
		int d = cal.get(Calendar.DAY_OF_MONTH);
		
		String day=null;
		if(d <10) {
			day="0"+String.valueOf(d);
		}
		try {
			today=year+"-"+month+"-"+day;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return today;
	}

	@Override
	public int updateWork(Work dto) throws Exception {
		int result =0;
			
		try {
			result = dao.updateData("work.updateWork", dto);
			result=1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int searchDiary(int adminIdx) throws Exception {
		int result =0;
		
		try {
			result=dao.selectOne("work.searchDiary", adminIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Work preArticleWork(Map<String, Object> map) throws Exception {
		Work dto = null;
		
		try {
			dto=dao.selectOne("work.preArticleWork", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Work nextArticleWork(Map<String, Object> map) throws Exception {
		Work dto = null;
		
		try {
			dto=dao.selectOne("work.nextArticleWork", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int deleteWork(int diaryCode) throws Exception {
		int result=0;
		
		try {
			result=dao.deleteData("work.deleteWork", diaryCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
