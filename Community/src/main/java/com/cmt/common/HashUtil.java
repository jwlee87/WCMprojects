package com.cmt.common;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.logging.log4j.LogManager;
import org.json.simple.JSONObject;

import com.cmt.domain.RewardList;
import com.cmt.domain.Member;
import com.cmt.service.MemberService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.logging.log4j.*;

public class HashUtil {
	
	// field
	int DEFAULT_TIMEOUT = 5000;
	
	Logger logger = LogManager.getLogger();
	
	// default constructor
	public HashUtil() {
	}
	
	// method
	public String stringToHMACMD5(String keyStr, String plainText) {
		String encodedString = "";
		
		try {
			SecretKeySpec key = new SecretKeySpec( keyStr.getBytes("UTF-8") , "HmacMD5");
			Mac mac = Mac.getInstance("HmacMD5");
			mac.init(key);
			
			byte[] bytes = mac.doFinal(plainText.getBytes("ASCII"));
			
			StringBuffer hash = new StringBuffer();
			
			for (int i=0; i<bytes.length; i++) {
				String hex = Integer.toHexString(0xff & bytes[i]);
				if (hex.length() == 1) {
					hash.append("0");
				}
				hash.append(hex);
			}
			encodedString = hash.toString();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return encodedString;
	}
	
	///////////////////////
	// ad popcorn reward //
	///////////////////////
	public String returnCheck(String signedValue, String plainText, String usn, String rewardKey, 
			Member member, MemberService memberService, RewardList igaReward, String serverIP) throws Exception {
		
		logger.debug(" JSON OBJECT MAKING METHOD START ");
		
		String hash_key = "1339caa7b57c40f3";
		JSONObject obj = new JSONObject();
		
		String decodedValue = stringToHMACMD5(hash_key, plainText);
		
		logger.debug("AD POPCORN DECODEDVALUE ="+decodedValue);
		List<RewardList> rewardList = memberService.getRewardList(Integer.parseInt(usn));
		
		boolean checkKey = false;
		
		// 리워드 리스트가 0이 아닐때
		if(rewardList.size() != 0) {
			// 리워드키 중복일 경우 checkKey true로 바뀜
			for(RewardList reward : rewardList) {
				if(reward.getRewardKey().equals(rewardKey)) {
					checkKey = true;
				}
			}
		}
		
		
		// 보안성 검증 성공
		if( signedValue.equals(decodedValue) ) {
			
			if (member != null) {
				// 유저 검증 실패
				//String uniqueID =String.valueOf(member.getUniqueID());
				//if ( (uniqueID.trim()).equals(usn.trim()) ) {
				
				logger.debug("유저가 널이 아님");
				
				if ( member.getUniqueID() != Integer.parseInt(usn.trim()) ) {
					
					logger.debug("유저가 널이 아니지만 유니크 아이디가 같지 않음");
					obj.put("Result", false);
					obj.put("ResultCode", 3200);
					obj.put("ResultMsg", "invalid user ");
					
				// 리워드 중복 지급
				}else if ( checkKey ) {
					
					logger.debug("유저가 널이 아니고 유니크 아이디가 같지만 리워드 중복 지급");
					obj.put("Result", false);
					obj.put("ResultCode", 3100);
					obj.put("ResultMsg", "duplicate transaction");

				//리워드 지금 성공
				} else {
					
					logger.debug("유저가 널이 아니고 유니크 아이디가 같고 리워드 중복 지급이 아니므로 리워드 지급!");

					HashMap<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("rewardList", igaReward);

					logger.debug("hashUtil Debugging :: before :: "+igaReward);
					memberService.addReward(paramMap);
					logger.debug("hashUtil Debugging :: after :: "+igaReward);
					// 지급 절차 통신  //
					String httpReturn = httpClient(serverIP, igaReward);
					
					obj.put("Result", true);
					obj.put("ResultCode", 1);
					obj.put("ResultMsg", "success");
				}
				
			// 예외사항 발생
			} else {
				obj.put("Result", false);
				obj.put("ResultCode", 4000);
				obj.put("ResultMsg", "custom error message");
			}
			
		}
		// 보안성 검증 실패
		else {
			obj.put("Result", false);
			obj.put("ResultCode", 1100);
			obj.put("ResultMsg", "invalid signed value");
		}
		
		Gson gson = new Gson();
		return gson.toJson(obj);
	}
	/////////////////////////////////
	// appang reward return method //
	/////////////////////////////////
	public String returnCheckForAppang(String usn, String rewardKey, String adID, Member member, MemberService memberService,
			RewardList apReward, String serverIP) throws Exception {
		
		logger.debug(" JSON OBJECT MAKING METHOD START ");
		
		List<RewardList> rewardList = memberService.getRewardList(Integer.parseInt(usn));
		
		boolean checkKey = false;
		String returnValue = "false";
		// 리워드 리스트가 0이 아닐때
		if(rewardList.size() != 0) {
			for(RewardList reward : rewardList) {
				// 콜백 중복 호출시 적립금 중복 지금 방지 리워드키 중복일 경우 checkKey true로 바뀜
				if(reward.getRewardKey().equals(rewardKey)) {
					checkKey = true;
				// 동일 사용자에게 적립금 중복 지급을 방지하기 위해, 개발사의 회원 ID와 광고ID 값 기준으로 중복 체크
				}else if(reward.getCampaignKey().equals(adID)){
					checkKey = true;
				}
			}
		}
		
		if (member != null) {
			
			logger.debug("유저가 널이 아님");
			
			if ( member.getUniqueID() != Integer.parseInt(usn.trim()) ) {
				logger.debug("유저가 널이 아니지만 유니크 아이디가 같지 않음");
				returnValue = "0001";
			// 리워드 중복 지급
			}else if ( checkKey ) {
				logger.debug("유저가 널이 아니고 유니크 아이디가 같지만 리워드 중복 지급");
				returnValue = "0002";

			//리워드 지금 성공					
			} else {
				
				logger.debug("유저가 널이 아니고 유니크 아이디가 같고 리워드 중복 지급이 아니므로 리워드 지급!");

				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("rewardList", apReward);
				logger.debug("hashUtil Debugging :: before :: "+apReward);
				memberService.addReward(paramMap);
				logger.debug("hashUtil Debugging :: after :: "+apReward);
				// 지급 절차 통신  //
				String httpReturn = httpClient(serverIP, apReward);
				returnValue = "1111";
				
			}
			
		// 예외사항 발생
		} else {
			logger.debug("리워드 지급 예외상황 발생");
			returnValue = "0004";
		}
		return returnValue;
	}
	
	
	/////////////////////////////////
	// TNK reward return method //
	/////////////////////////////////
	public String tnkLogic(String usn, String rewardKey, Member member, 
			MemberService memberService, RewardList tnkReward, String serverIP)throws Exception {
	
		logger.debug(" JSON OBJECT MAKING METHOD START ");
		
		List<RewardList> rewardList = memberService.getRewardListTNK(Integer.parseInt(usn));
		
		boolean checkKey = false;
		String returnValue = "false";
		// 리워드 리스트가 0이 아닐때
		if(rewardList.size() != 0) {
			for(RewardList reward : rewardList) {
				//콜백 중복 호출시 적립금 중복 지금 방지 리워드키 중복일 경우 checkKey true로 바뀜
				if(reward.getRewardKey().equals(rewardKey)) {
					checkKey = true;
				}
			}
		}
	
		if (member != null) {
		
			logger.debug("유저가 널이 아님");
	
			if ( member.getUniqueID() != Integer.parseInt(usn.trim()) ) {
				logger.debug("유저가 널이 아니지만 유니크 아이디가 같지 않음");
				returnValue = "0001";
			// 리워드 중복 지급
			}else if ( checkKey ) {
				logger.debug("유저가 널이 아니고 유니크 아이디가 같지만 리워드 중복 지급");
				returnValue = "0002";
			//리워드 지금 성공					
			} else {
				logger.debug("유저가 널이 아니고 유니크 아이디가 같고 리워드 중복 지급이 아니므로 리워드 지급!");
			
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("rewardList", tnkReward);
				logger.debug("hashUtil Debugging :: before :: "+tnkReward);
				memberService.addReward(paramMap);
				logger.debug("hashUtil Debugging :: after :: "+tnkReward);
				// 지급 절차 통신  //
				String httpReturn = httpClient(serverIP, tnkReward);
				returnValue = "1111";
			}
		
		// 예외사항 발생
		} else {
			logger.debug("리워드 지급 예외상황 발생 - member null");
			returnValue = "0004";
		}
			return returnValue;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String simpleJson() {
		Gson gson = new Gson();
		JsonObject object = new JsonObject();
		object.addProperty("Result", false);
		object.addProperty("ResultCode", 1);
		object.addProperty("ResultMsg", "success");
		String json = gson.toJson(object);
		System.out.println(json);
		return json;
	}
	
	public JSONObject getJsonStringFromMap( Map<String, Object> map ) {
		JSONObject json = new JSONObject();
		for( Map.Entry<String, Object> entry : map.entrySet() ) {
			String key = entry.getKey();
			Object value = entry.getValue();
			json.put(key, value);
		}
		return json;
	}
	
	public List<NameValuePair> convertParam(Map<String, Object> params){
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		Iterator<String> keys = params.keySet().iterator();
		while(keys.hasNext()){
			String key = keys.next();
			logger.debug(key);
			paramList.add(new BasicNameValuePair(key, params.get(key).toString()));
		}
		return paramList;
	}
	
	
	//////////////////
	/// httpClient ///
	//////////////////
	public String httpClient(String url, RewardList igaReward) {
		
		RequestConfig defaultRequestConfig = RequestConfig.custom()
				.setConnectTimeout(DEFAULT_TIMEOUT)
				.setSocketTimeout(DEFAULT_TIMEOUT)
				.setConnectionRequestTimeout(DEFAULT_TIMEOUT)
				.build();
		
		CloseableHttpClient hc = HttpClients.custom()
				.setDefaultRequestConfig(defaultRequestConfig)
				.build();
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uniqueID", igaReward.getUniqueID());
		
		logger.debug(params);
		
		HttpPost post = new HttpPost("http://"+url);
		post.setConfig(defaultRequestConfig);
		
		String returnStr = "";
		
		List<NameValuePair> paramList = convertParam(params);
		try {
			post.setEntity(new UrlEncodedFormEntity(paramList, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		post.addHeader("User-Agent", "Mozila/5.0");
		
		logger.debug(" 이사님 서버로 보내기 전 ");
		
		HttpResponse httpResponse;
		try {
			httpResponse = hc.execute(post);
			
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			logger.debug("===== statusCode ===== "+statusCode);
			
			if(statusCode==200) {
				returnStr = "true";
			} else {
				returnStr = "false";
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				hc.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		logger.debug(" 이사님 서버로 보내기 후");
		
		returnStr = returnStr.equals("") ? "false" : returnStr;
		return returnStr;
		
	}
}
	
