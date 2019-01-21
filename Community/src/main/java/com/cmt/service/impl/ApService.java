package com.cmt.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
	
	@Value("#{setup['ap.pass']}")
	private String pass;
	
	@Override
	public List<HashMap<String, Object>> getApList() {
		return adi.getApList();
	}

	@Override
	public HashMap<String, Object> addAp(HttpServletRequest req) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		
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

	@Override
	public HashMap<String, Object> getCheckPw(HttpServletRequest req) {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		if(paramMap.size() != 0) {
			String checkKey = (String)paramMap.get("pass");
			HashMap<String, Object> tempMap = adi.getAp(paramMap);
			String originPass = (String)tempMap.get("login_pw");
			String restoredPass = HttpUtil.restorePass(originPass);
			if(pass.equals(checkKey)) {
				resultMap.put("check", "true");
				resultMap.put("result", restoredPass);
			}else {
				resultMap.put("check", "false");
				resultMap.put("result", "비밀번호 불일치!");
			}
			return resultMap;
		}else {
			resultMap.put("check", "false");
			return resultMap;
		}
	}
	
	@Override
	public HashMap<String, Object> getSimplePw(HttpServletRequest req) {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		return adi.getAp(paramMap);
	}
	
	@Override
	public synchronized HashMap<String, Object> updateAp(HttpServletRequest req) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		
		System.out.println("A= "+paramMap);
		HashMap<String, Object> dbMap = adi.getAp(paramMap);
		System.out.println("B= "+dbMap);
		
		boolean check = false;
		
		System.out.println("b P: "+(String)paramMap.get("bLoginPw"));
		System.out.println("dbP:"+(String)dbMap.get("login_pw"));
		
		if( ((String)paramMap.get("bCompanyName")).equals((String)dbMap.get("company_name"))
				&& ((String)paramMap.get("bCompanyUrl")).equals((String)dbMap.get("site_address"))
				&& ((String)paramMap.get("bLoginId")).equals((String)dbMap.get("login_id"))
				&& ((String)paramMap.get("bLoginPw")).equals((String)dbMap.get("login_pw"))
				&& ((String)paramMap.get("bPartName")).equals((String)dbMap.get("part_name"))
				&& ((String)paramMap.get("bNote")).equals((String)dbMap.get("note"))
		) { check = true; }
		
		
		paramMap.put("loginPw", HttpUtil.encryptionPass((String)(paramMap.get("loginPw"))));
		
		System.out.println(paramMap);
		
		if(check) {
			int updateResult = adi.updateAdvertisingProvider(paramMap);
			if(updateResult == 1) {
				resultMap.put("result", "success");
			}else {
				resultMap.put("result", "false");
			}
		}else {
			resultMap.put("result", "false-2");
		}
		return resultMap;
	}

	@Override
	public HashMap<String, Object> deleteAp(HttpServletRequest req) {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		paramMap.put("no", Integer.parseInt((String)paramMap.get("no")));
		int deleteCheck = adi.updateApDelete(paramMap);
		if(deleteCheck == 1) {
			resultMap.put("result", "삭제되었습니다.");
		}else {
			resultMap.put("result", "실패했습니다.");
		}
		return resultMap;
	}

}
