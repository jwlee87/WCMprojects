package com.cmt.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmt.common.HttpUtil;
import com.cmt.dao.FindDaoInterface;
import com.cmt.service.FindServiceInterface;

@Service
public class FindServiceImpl implements FindServiceInterface {
	
	@Autowired
	private FindDaoInterface fdi;
	
	@Override
	public HashMap<String, Object> getFindAjax(HttpServletRequest req) {
		
		boolean isRun = true;
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> httpMap = new HashMap<String, Object>();
		
		paramMap = HttpUtil.getParamMap(req);
		
		if( paramMap.get("Command") == null ) isRun = false;
		if( paramMap.get("value") == null ) isRun = false;
		
		if(isRun) {
			boolean serverCondition = true;
			List<HashMap<String, Object>> serverList = fdi.getServerList();
			if(serverList.size() != 1) serverCondition = false;
			if(serverCondition) {
				String url = ((serverList.get(0)).get("_Address")).toString();
				paramMap.put("url", url);
				httpMap = HttpUtil.httpClient(paramMap);
			}
		}
		System.out.println("결과: "+httpMap);
		return httpMap;
	}

}
