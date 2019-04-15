package com.sp.admin;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;
import com.sp.common.dao.CommonDAO;

@Service("admin.adminService")
public class AdminService {
	@Autowired
	private FileManager fileManager;
	@Autowired
	private CommonDAO dao;
	@Autowired
	private MyUtil myUtil;
	
	public Admin readLoginInfo(String adminId) {
		Admin admin = null;
		try {
			admin = dao.selectOne("admin.readLoginInfo", adminId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return admin;
	}
	
	public int insertAdmin(Admin dto, String pathname) {
		int result=0;
		
		try {
			if(dto.getEmail1() != null && dto.getEmail1().length()!=0 &&
					dto.getEmail2() != null && dto.getEmail2().length()!=0)
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setSaveFilename(saveFilename);
			}
			dao.insertData("admin.insertAdmin",dto);

			result=1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int findSeq() {
		int result=0;
		try {
			result=dao.selectOne("admin.findSeq");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String findBebun(int adminIdx) {
		String result=null;
		try {
			result=dao.selectOne("admin.findBebun",adminIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public List<Admin> listAdmin(Map<String, Object> map) {
		List<Admin> listAdmin =null;
		
		try {
			listAdmin=dao.selectList("admin.listAdmin",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listAdmin;
	}
	
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("admin.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public Admin articleAdmin(int adminIdx){
		Admin dto = null;
		
		try {
			dto=dao.selectOne("admin.articleAdmin", adminIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public int updateAdmin(Admin dto, String pathname) {
		int result=0;
		
		try {
			if(dto.getEmail1() != null && dto.getEmail1().length()!=0 &&
					dto.getEmail2() != null && dto.getEmail2().length()!=0)
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);

			if(saveFilename != null) {
				if(dto.getSaveFilename()!=null && dto.getSaveFilename().length()!=0) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
				dto.setSaveFilename(saveFilename);
			}
			dao.updateData("admin.updateAdmin",dto);
			result=1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	private String mailType= "text/html; charset=utf-8";
	private String encType= "utf-8";
	private class SMTPAuthenticator extends javax.mail.Authenticator {
		  @Override
	      public PasswordAuthentication getPasswordAuthentication() {  
	          String username =  "wayou1904"; 
	          String password = "1qaz2wsx!!"; 
	          return new PasswordAuthentication(username, password);  
	       }  
	}
	
	private void makeMessage(Message msg, String any) throws MessagingException {
			msg.setText(any);
			msg.setHeader("Content-Type", mailType);
	}
	
	public boolean mailSend(Admin dto) {
		boolean b=false;
		String sendEmail="wayou1904@gmail.com";
		String sendName="관리자";
		String content=dto.getAdminName()+"님의 아이디는  "+dto.getAdminId()+" 입니다";
		String subject= dto.getAdminId()+" 님 WAYOU의 일원이 되신걸 환영합니다~";

		Properties p = new Properties();   
  
		p.put("mail.smtp.user", "wayou1904");   
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.port", "465");   
		p.put("mail.smtp.starttls.enable", "true");   
		p.put("mail.smtp.auth", "true");   
		p.put("mail.smtp.socketFactory.port", "465");   
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		p.put("mail.smtp.socketFactory.fallback", "false");  
		
		try {
			Authenticator auth = new SMTPAuthenticator();  
			Session session = Session.getDefaultInstance(p, auth);
			
			Message msg = new MimeMessage(session);

			msg.setFrom(new InternetAddress(sendEmail, sendName, encType));
			
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dto.getEmail()));
			
			msg.setSubject(subject);
			
			if(mailType.indexOf("text/html") != -1) {
				content=(myUtil.htmlSymbols(content));
			}
			makeMessage(msg, content);
			msg.setHeader("X-Mailer", sendName);
			
			msg.setSentDate(new Date());
			
			Transport.send(msg);
			
			b=true;
						
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return b;
	}
}
