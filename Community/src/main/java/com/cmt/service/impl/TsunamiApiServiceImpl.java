package com.cmt.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cmt.dao.MemberDao;
import com.cmt.domain.Member;
import com.cmt.service.TsunamiApiService;
import com.google.gson.Gson;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
public class TsunamiApiServiceImpl implements TsunamiApiService {
	
	private final String privateKey = "mXqVz5Tj5yyAxuLs7mBx";
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("memberDaoImpl")
	private MemberDao memberDao;

	@Transactional
	public Map<String, Object> getAuth(String jsonString) throws Exception {
		Map<String, Object> returnMap = new HashMap<>();
		Gson gson = new Gson();
		
		Map<String, Object> paramMap = gson.fromJson(jsonString, Map.class);
//		logger.debug("service :: paramMap ======================");
//		logger.debug(paramMap);
//		logger.debug(paramMap.size());
//		logger.debug("service :: paramMap end ======================");
		if(paramMap.size() == 0){
			returnMap.put("rst", "error");
			returnMap.put("msg", "service :: request dose not have any parameters");
			return returnMap;
		}
		
		if(paramMap.get("u") != null & paramMap.get("v") != null) {
			
			int cutSize = Integer.parseInt((String)paramMap.get("u"));
			String rawString = (String)paramMap.get("v");
			int uid = Integer.parseInt(rawString.substring(0, cutSize));
			String hash = rawString.substring(cutSize);
			Member member = memberDao.getMemberByUniqueID(uid);
			
//			logger.debug("debug encoding value :: rawString="+rawString);
//			logger.debug("debug encoding value :: uid="+uid);
//			logger.debug("debug encoding value :: hash="+hash);
			
			if(member == null) {
				returnMap.put("rst", "error");
				returnMap.put("msg", "member is null");
				return returnMap;
			}
			
			String wallter = member.getWallet();
			if(wallter == null || wallter.equals("")) {
				returnMap.put("rst", "error");
				returnMap.put("msg", "wallet adress is invalid");
			} else {
				String storedHash = wallter.substring(wallter.length()-8, wallter.length());
				if(storedHash.equals(hash)) {
					String token = Jwts.builder()
							.setIssuer("main")
							.setSubject("auth")
							.setHeaderParam("typ", "JWT")
							.setHeaderParam("alg", "HS256")
							.setExpiration(new Date(System.currentTimeMillis()+(1000*60*300)))
							.claim("u", String.valueOf(member.getUniqueID()))
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
			}
			return returnMap;
		} else {
			returnMap.put("rst", "error");
			returnMap.put("msg", "not enough key");
			return returnMap;
		}
	}
}
