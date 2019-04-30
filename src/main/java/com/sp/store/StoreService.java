package com.sp.store;

import java.util.List;
import java.util.Map;

public interface StoreService {
	public int insertStore(Store dto, String pathname);
	
	public List<Store> listStore(Map<String, Object> map);
	public int storeCount(Map<String, Object> map);
	public Store readStore(int num);
	
	public int insertTicket(Ticket dto, String pathname);
	public List<Ticket> listTicket();
	
	public int insertStoreFile(Store dto);
	public List<Store> listStoreFile(int num);
	
	public int insertTicketFile(Ticket dto);
	public List<Ticket> listTicketFile(int num);
}
