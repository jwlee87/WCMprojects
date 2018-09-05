package com.cmt.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cmt.common.HttpUtil;
import com.cmt.dao.ApDaoInterface;
import com.cmt.service.ApServiceInterface;
import com.google.gson.Gson;

@Service
public class ApService implements ApServiceInterface {
	
	///Field
	@Autowired
	private ApDaoInterface adi;
	
	@Override
	public List<HashMap<String, Object>> getApList() {
		return adi.getApList();
	}

	@Override
	public HashMap<String, Object> addAp(HttpServletRequest req) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		
		System.out.println("server data= "+paramMap);
		
		int returnValue = adi.addAdvertisingProvider(paramMap);
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
	public HashMap<String, Object> getAjaxList(HttpServletRequest req) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Gson gson = new Gson();
		resultMap.put("list", gson.toJson(adi.getApList()));
		return resultMap;
	}

}
