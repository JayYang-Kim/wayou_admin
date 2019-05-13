package com.sp.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("fileManager")
public class FileManager {
	/**
	 * 파일을 업로드 하기 위한 메소드
	 * @param partFile		업로드할 파일정보를 가지고 있는 MultipartFile 객체
	 * @param pathname	파일을 저장할 경로
	 * @return					서버에 저장된 새로운 파일의 이름
	 */
	public String doFileUpload(MultipartFile partFile, String pathname) throws Exception {
		String saveFilename = null;
		if(partFile == null || partFile.isEmpty())
			return null;
		
		// 클라이언트가 업로드한 파일의 이름
		String originalFilename=partFile.getOriginalFilename();
		if(originalFilename==null||originalFilename.length()==0)
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		System.nanoTime();
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		saveFilename += System.nanoTime();
		saveFilename += fileExt;
		
		String fullpathname = pathname + File.separator + saveFilename;
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File f = new File(fullpathname);
		if(!f.getParentFile().exists())//그냥 MKDIR하면 파일까지 폴더경로로 인식함
			f.getParentFile().mkdirs();

		partFile.transferTo(f); //파일 객체에 데이터를 넘겨줌

		return saveFilename;
	}
	
	public String doFileUpload2(MultipartFile partFile, String sort) throws Exception {
		String saveFilename = null;
		if(partFile == null || partFile.isEmpty())
			return null;
		
		// 클라이언트가 업로드한 파일의 이름
		String originalFilename=partFile.getOriginalFilename();
		if(originalFilename==null||originalFilename.length()==0)
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		System.nanoTime();
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		saveFilename += System.nanoTime();
		saveFilename += fileExt;
		
		String fullpathname;
		if(sort.equals("location")) {
			fullpathname = "C:"+File.separator+"Users"+File.separator+"임상근"+File.separator+"git"+File.separator+"wayou_user"+File.separator+"src"+File.separator+"main"+File.separator+"webapp"+File.separator+"uploads"+File.separator+"location"+File.separator+saveFilename;
		}else {
			fullpathname = "C:"+File.separator+"Users"+File.separator+"임상근"+File.separator+"git"+File.separator+"wayou_user"+File.separator+"src"+File.separator+"main"+File.separator+"webapp"+File.separator+"uploads"+File.separator+"landmark"+File.separator+saveFilename;
		}
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File f = new File(fullpathname);
		if(!f.getParentFile().exists())//그냥 MKDIR하면 파일까지 폴더경로로 인식함
			f.getParentFile().mkdirs();

		partFile.transferTo(f); //파일 객체에 데이터를 넘겨줌

		return saveFilename;
	}
	/** 
	 * 파일을 업로드 하기 위한 메소드
	 * @param bytes					업로드할 파일정보를 가지고 있는byte 배열
	 * @param originalFilename	클라이언트가 업로드한 파일명
	 * @param pathname			파일을 저장할 경로
	 * @return							서버에 저장된 새로운 파일의 이름
	 * 
	 * 바이트 배열을 사용하는 사람이 있을 수 있기 때문에 이것도 알아두는 것이 좋아
	 */
	public String doFileUpload(byte[] bytes, String originalFilename, String pathname) throws Exception {
		String saveFilename = null;

		if(bytes == null)
			return null;
		
		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null||originalFilename.length()==0)
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		saveFilename += System.nanoTime();
		saveFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(pathname);
		if(!dir.exists())
			dir.mkdirs();
		
		String fullpathname = pathname + File.separator + saveFilename;
		
		FileOutputStream fos = new FileOutputStream(fullpathname);
		fos.write(bytes);
		fos.close();
		
		return saveFilename;
	}

	/**
	 * 파일을 업로드 하기 위한 메소드
	 * @param is						업로드할 파일정보를 가지고 있는 InputStream 객체
	 * @param originalFilename	클라이언트가 업로드한 파일명
	 * @param pathname			파일을 저장할 경로
	 * @return							서버에 저장된 새로운 파일의 이름
	 * 
	 * 이 것도 알아두면 좋음 다른 방법 3번째 (파라미터가 다른 거)1
	 */
	public String doFileUpload(InputStream is, String originalFilename, String pathname) throws Exception {
		String saveFilename = null;

		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null||originalFilename.equals(""))
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		saveFilename += System.nanoTime();
		saveFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(pathname);
		if(!dir.exists())
			dir.mkdirs();
		
		String fullpathname = pathname + File.separator + saveFilename;
		
		byte[] b=new byte[1024];
		int size=0;
		FileOutputStream fos = new FileOutputStream(fullpathname);
		
		while((size=is.read(b))!=-1) {
			fos.write(b, 0, size);
		}
		
		fos.close();
		is.close();
		
		return saveFilename;
	}
	
	/**
	 * 파일을 다운로드하는 메소드
	 * @param saveFilename		서버에 저장된 파일이름
	 * @param originalFilename	클라이언트가 업로드한 파일이름
	 * @param pathname			파일이 저장된 경로
	 * @param response				응답할 HttpServletResponse 객체
	 * @return							파일 다운로드 성공 여부
	 * 스프링에서 제공하는 다운로드는 이미지나 텍스트의 경우 화면에 바로 보여버림 따라서 따로 구현하는 것이 중요함
	 */
	public boolean doFileDownload(String saveFilename, String originalFilename, String pathname, HttpServletResponse response) {
		String fullpathname = pathname + File.separator + saveFilename;
		
        try {
    		if(originalFilename == null || originalFilename.equals(""))
    			originalFilename = saveFilename;
        	originalFilename = new String(originalFilename.getBytes("euc-kr"),"8859_1");
        } catch (UnsupportedEncodingException e) {
        }

	    try {
	        File file = new File(fullpathname);

	        if (file.exists()){
	            byte readByte[] = new byte[4096];

	            response.setContentType("application/octet-stream"); //2진데이터로 보내겠다.
				response.setHeader(
						"Content-disposition",
						"attachment;filename=" + originalFilename); //헤더로 파일이름 전송 (EUC-KR로 인코딩해야한다.)

	            BufferedInputStream  fin  = new BufferedInputStream(new FileInputStream(file));
	            //javax.servlet.ServletOutputStream outs =	response.getOutputStream();
	            OutputStream outs = response.getOutputStream();
	            
	   			int read;
	    		while ((read = fin.read(readByte, 0, 4096)) != -1)
	    				outs.write(readByte, 0, read);
	    		outs.flush();
	    		outs.close();
	            fin.close();
	            
	            return true;
	        }
	    } catch(Exception e) {
	    }
	    
	    return false;
	}
	
	/**
	 * 파일을 삭제하는 메소드
	 * @param pathname	경로를 포함한 삭제할 파일이름
	 */
	public void doFileDelete(String pathname) {
		File file = new File(pathname);
        if (file.exists())
           file.delete();
	}

	/**
	 * 파일을 삭제하는 메소드
	 * @param filename			삭제할 파일 이름
	 * @param pathname		삭제할 파일이 존재하는 경로
	 * 이름과 경로가 다른 경우
	 */
	public void doFileDelete(String filename, String pathname) {
		String fullpathname = pathname + File.separator + filename;
		File file = new File(fullpathname);
        if (file.exists())
           file.delete();
	}
	
	/**
	 * 파일 또는 폴더 및 하위 폴더를 삭제하는 메소드
	 * @param pathname	삭제할 파일명(경로포함) 또는 삭제할 폴더
	 * 
	 * 모든 것을 다 삭제하므로 위험하다. 조심해라
	 */
	public void removePathname(String pathname) {
		try {
			File f=new File(pathname);
			if (! f.exists())
				return;
			if(f.isDirectory())
				removeSubDirectory(pathname);
			
			f.delete();
		} catch (Exception e) {
		}
	}
	private void removeSubDirectory(String pathname) { //재귀호출이므로 스택에 너무 많이 쌓이면 뒤진다.(그정도 양은 사실 드물다)
		File[] listFile = new File(pathname).listFiles();
		try {
			if (listFile.length > 0) {
				for (int i = 0; i < listFile.length; i++) {
					if (listFile[i].isDirectory()) {
						removeSubDirectory(listFile[i].getPath());
					}
					listFile[i].delete();
				}
			}
		} catch (Exception e) {
		}
	}

	/**
	 * 파일의 길이를 구하는 메소드
	 * @param pathname	길이를 구할 경로를 포함한 파일이름
	 * @return
	 */
	public long getFilesize(String pathname) {
		long size=-1;
		
		File file = new File(pathname);
		if (! file.exists())
			return size;
		
		size=file.length();
		
		return size;
	}
	
	/**
	 * 파일의 타입을 구하는 메소드
	 * @param pathname	파일 타입을 구할 파일이름
	 * @return					파일 타입
	 * 
	 * 해당 되는 파일이 이미지 인지 doc타인지 뭐 이런거??
	 */
	public String getFiletype(String pathname) {
		String type="";
		try {
			URL u = new URL("file:"+pathname);
		    URLConnection uc = u.openConnection();
		    type = uc.getContentType();
		} catch (Exception e) {
		}
		
	    return type;
	}
}
