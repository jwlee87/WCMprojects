package com.cmt.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmt.common.HttpUtil;
import com.cmt.dao.ServerDaoInterface;
import com.cmt.service.ServerServiceInterface;

@Service
public class ServerService implements ServerServiceInterface {
	
	///Field
	@Autowired
	private ServerDaoInterface sdi;

	@Override
	public List<HashMap<String, Object>> getServerList() {
		return sdi.getServerList();
	}

	@Override
	public HashMap<String, Object> addServer(HttpServletRequest req) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		
		System.out.println(paramMap);
		
		int returnValue = sdi.addServer(paramMap);
		if(String.valueOf(returnValue).equals("1")) {
			resultMap.put("check", "success");
		}else if(String.valueOf(returnValue).equals("0")) {
			resultMap.put("check", "fail");
		}else {
			resultMap.put("check", "error");
		}
		return resultMap;
	}

	@Override
	public synchronized HashMap<String, Object> updateServer(HttpServletRequest req) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		
		int updateResult = sdi.updateServer(paramMap);
		if(updateResult == 1) {
			resultMap.put("result", "success");
		}else {
			resultMap.put("result", "false");
		}
		return resultMap;
		
	}

	@Override
	public HashMap<String, Object> deleteServer(HttpServletRequest req) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		int updateResult = sdi.updateServerDelete(paramMap);
		if(updateResult == 1) {
			resultMap.put("result", "success");
		}else {
			resultMap.put("result", "false");
		}
		return resultMap;
	}

}
