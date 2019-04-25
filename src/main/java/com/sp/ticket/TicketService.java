package com.sp.ticket;

public interface TicketService {
	public int insertTicket(Ticket dto, String pathname);
	public int insertFile(Ticket dto);
}
