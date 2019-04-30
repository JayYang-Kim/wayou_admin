package com.sp.work;

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

}
