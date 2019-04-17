package com.sp.travel.party;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("travel.party.partyService")
public class PartyServiceImpl implements PartyService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("travel.party.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public List<Party> listParty(Map<String, Object> map) throws Exception {
		List<Party> list = null;
		
		try {
			list = dao.selectList("travel.party.listParty", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int updateConfirm(int partyCode) throws Exception {
		int result = 0;
		
		try {
			result = dao.updateData("travel.party.updateConfirm", partyCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public Party readParty(int partyCode) throws Exception {
		Party dto = null;
		
		try {
			dto = dao.selectOne("travel.party.readParty", partyCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Party preReadParty(Map<String, Object> map) throws Exception {
		Party dto = null;
		
		try {
			dto = dao.selectOne("travel.party.preReadParty", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Party nextReadParty(Map<String, Object> map) throws Exception {
		Party dto = null;
		
		try {
			dto = dao.selectOne("travel.party.nextReadParty", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}
