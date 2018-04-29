package com.cmt.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.cmt.domain.ADRequest;
import com.cmt.domain.AttachFile;
import com.cmt.domain.Board;

@Component
public class UtilFile {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	///Constructor
	public UtilFile() {
	}
	
	///Method
	// file upload method
	public HashMap<String, Object> fileUpload(HttpServletRequest request
								, MultipartFile uploadFile, Object obj) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String path = "";
		String fileName = "";
		
		OutputStream out = null;
		PrintWriter pw = null;
		
		try {
			fileName = uploadFile.getOriginalFilename();
			byte[] bytes = uploadFile.getBytes();
			path = getSaveLocation(request, obj);
			
			logger.debug("UtilFile fileUpload fileName : "+ fileName);
			logger.debug("UtilFile fileUpload uploadPath : "+ path);
			
			File file = new File(path);
			
//			파일명이 중복으로 존재할 경우
			if(fileName != null && !fileName.equals("")) {
				if(file.exists()) {
//					파일명 앞에 업로드 시간 초단위로 붙여 파일명 중복을 방지
					fileName = System.currentTimeMillis() + "_"+ fileName;
					file = new File(path + fileName);
				}
			}
			
			logger.debug("UtilFile fileUpload final fileName : "+ fileName);
			logger.debug("UtilFile fileUpload file : "+ file);
			
			out = new FileOutputStream(file);
			
			logger.debug("UtilFile fileUpload out : "+ out);
			
			out.write(bytes);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(out != null) {
					out.close();
				}
				if(pw != null) {
					pw.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		resultMap.put("filePath", path);
		resultMap.put("fileName", fileName);
		return resultMap;
	}
	
	// delete File
	public String deleteFile(List<AttachFile> fileList) throws Exception {
		
		String returnValue = "null";
		
		for(AttachFile attachFile: fileList) {
			String filePath = attachFile.getFilePath();
			String fileName = attachFile.getFileName();
			File file = new File(filePath+fileName);
			
			logger.debug(filePath+fileName);
			
			if(file.exists()) {
				if(file.delete()) {
					logger.debug("파일삭제 성공");
					returnValue = "success";
				} else {
					logger.debug("파일삭제 실패");
					returnValue = "fail";
				}
			} else {
				logger.debug("파일이 존재하지 않습니다.");
				returnValue = "null";
			}
		}
		
		return returnValue;
	}
	
	// get save Location method
	// 업로드한 파일의 경로가 도메인 별로 달라야 하는 기능을 위해 도메인의 타입을 비교하여 파일 저장 경로를 다르게 지정
	private String getSaveLocation(HttpServletRequest request, Object obj) {
		
		String uploadPath = request.getServletContext().getRealPath("/");
		String attachPath = "resources/files/";
		
		if(obj instanceof Board) {
			attachPath += "board/";
		}else if(obj instanceof ADRequest){
			attachPath += "adRequest/";
		}
		
		logger.debug("UtilFile getSaveLocation path : "+ uploadPath + attachPath);
		
		return uploadPath + attachPath;
	}

	public void deleteADReq(ADRequest adr) {
		String filePath = adr.getFilePath();
		String fileName = adr.getFileName();
		
		logger.debug(filePath+fileName);
		
		File file = new File(filePath+fileName);
		
		if(file.exists()) {
			if(file.delete()) {
				logger.debug("파일삭제 성공");
			} else {
				logger.debug("파일삭제 실패");
			}
		}else {
			logger.debug("파일 없음");
		}
		
	}
}
