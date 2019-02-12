package com.cmt.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.cmt.common.HttpUtil;
import com.cmt.dao.MemberDao;
import com.cmt.domain.Member;
import com.cmt.service.TsunamiApiService;
import com.google.gson.Gson;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
public class TsunamiApiServiceImpl implements TsunamiApiService {
	
	@Value("${setup['tsunami.key']")
	private String privateKey;
	
	@Autowired
	@Qualifier("memberDaoImpl")
	private MemberDao memberDao;

	@Override
	public Map<String, Object> getAuth(HttpServletRequest req) throws Exception {
		Map<String, Object> returnMap = new HashMap<>();
		Gson gson = new Gson();
		System.out.println(req);
		Map<String, Object> paramMap = HttpUtil.getParamMap(req); 
		
		if(paramMap.size() == 0){
			returnMap.put("rst", "error");
			returnMap.put("msg", "service :: request dose not have any parameters");
			return returnMap;
		}
		
		int uid = (Integer)paramMap.get("u");
		String hash = (String)paramMap.get("v");
		Member member = memberDao.getMemberByUniqueID(uid);
		
		if(member == null) {
			returnMap.put("rst", "error");
			returnMap.put("msg", "member is null");
			return returnMap;
		}
		
		if(member.getPhone().equals(hash)) {
			String token = Jwts.builder()
					.setExpiration(new Date(System.currentTimeMillis()+(3000l*60l*10l)))
					.claim("u", member.getUniqueID())
					.claim("n", member.getTradeMark())
					.signWith(
						SignatureAlgorithm.HS512,
						privateKey.getBytes("UTF-8")
					).compact();
					
			returnMap.put("token", token);
			returnMap.put("rst", "success");
		}else {
			returnMap.put("rst", "error");
			returnMap.put("msg", "value is not correct");
			return returnMap;
		}
		return returnMap;
	}
	
	public Map<String, Object> getAuth(String jsonString) throws Exception {
		Map<String, Object> returnMap = new HashMap<>();
		Gson gson = new Gson();
		System.out.println("1"+jsonString);
		
		Map<String, Object> paramMap = gson.fromJson(jsonString, Map.class);
		System.out.println("======================");
		System.out.println(paramMap);
		System.out.println(paramMap.size());
		System.out.println("======================");
		if(paramMap.size() == 0){
			returnMap.put("rst", "error");
			returnMap.put("msg", "service :: request dose not have any parameters");
			return returnMap;
		}
		
		int uid = Integer.parseInt((String)paramMap.get("u"));
		String hash = (String)paramMap.get("v");
		Member member = memberDao.getMemberByUniqueID(uid);
		
		if(member == null) {
			returnMap.put("rst", "error");
			returnMap.put("msg", "member is null");
			return returnMap;
		}
		
		if(member.getPhone().equals(hash)) {
			String token = Jwts.builder()
					.setExpiration(new Date(System.currentTimeMillis()+(3000l*60l*10l)))
					.claim("u", member.getUniqueID())
					.claim("n", member.getTradeMark())
					.signWith(
						SignatureAlgorithm.HS512,
						privateKey.getBytes("UTF-8")
					).compact();
					
			returnMap.put("token", token);
			returnMap.put("rst", "success");
		}else {
			returnMap.put("rst", "error");
			returnMap.put("msg", "value is not correct");
			return returnMap;
		}
		return returnMap;
	}

}
