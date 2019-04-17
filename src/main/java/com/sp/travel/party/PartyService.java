package com.sp.travel.party;

import java.util.List;
import java.util.Map;

public interface PartyService {
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Party> listParty(Map<String, Object> map) throws Exception;
	public Party readParty(int partyCode) throws Exception;
	public Party preReadParty(Map<String, Object> map) throws Exception;
	public Party nextReadParty(Map<String, Object> map) throws Exception;
	public int updateConfirm(int partyCode) throws Exception;
}
