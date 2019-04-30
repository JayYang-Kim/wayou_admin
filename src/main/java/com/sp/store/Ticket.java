package com.sp.store;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Ticket {
	private int ticketCode, storeCode;
	private String ticketName;
	private String ticket_info;
	private int adminIdx;
	private String sales_start, sales_end;
	
	private int fileCode;
	private String saveFilename, originalFilename;
	private List<MultipartFile> upload;
	
	public int getFileCode() {
		return fileCode;
	}
	public void setFileCode(int fileCode) {
		this.fileCode = fileCode;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	public int getTicketCode() {
		return ticketCode;
	}
	public void setTicketCode(int ticketCode) {
		this.ticketCode = ticketCode;
	}
	public int getStoreCode() {
		return storeCode;
	}
	public void setStoreCode(int storeCode) {
		this.storeCode = storeCode;
	}
	public String getTicketName() {
		return ticketName;
	}
	public void setTicketName(String ticketName) {
		this.ticketName = ticketName;
	}
	public String getTicket_info() {
		return ticket_info;
	}
	public void setTicket_info(String ticket_info) {
		this.ticket_info = ticket_info;
	}
	public int getAdminIdx() {
		return adminIdx;
	}
	public void setAdminIdx(int adminIdx) {
		this.adminIdx = adminIdx;
	}
	public String getSales_end() {
		return sales_end;
	}
	public void setSales_end(String sales_end) {
		this.sales_end = sales_end;
	}
	public String getSales_start() {
		return sales_start;
	}
	public void setSales_start(String sales_start) {
		this.sales_start = sales_start;
	}
	
}
