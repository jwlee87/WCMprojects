package com.cmt.service.impl;

import java.io.BufferedReader;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.cmt.common.HttpClientUtil;
import com.cmt.domain.ServerList;
import com.cmt.service.CashbeeService;
import com.cmt.service.MemberService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Service("cashbeeServiceImpl")
public class CashbeeServiceImpl implements CashbeeService {
	
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	private HttpClientUtil httpClientUtil;
	
	@Autowired
	private HttpClient httpClientCashbee;
	
	@Value("#{cashbeeProperties['coinbox.ipAddr1']}")
	private String coinboxIp1;
	
	@Value("#{cashbeeProperties['coinbox.ipAddr2']}")
	private String coinboxIp2;
	
	@Value("#{cashbeeProperties['coinbox.ipAddr3']}")
	private String coinboxIp3;
	
	@Override
	public boolean validationCheck(String ipAddr) {
		
		boolean ipCheck = false;
		if( ipAddr.equals(coinboxIp1) ) {
			logger.debug("1과 일치");
			ipCheck = true;
		} else if( ipAddr.equals(coinboxIp2) ) {
			logger.debug("2와 일치");
			ipCheck = true;
		} else if( ipAddr.equals(coinboxIp3) ) {
			logger.debug("3과 일치");
			ipCheck = true;
		} else {
			logger.debug("임시 무조건 true");
			ipCheck = true;
		}
		return ipCheck;
	}

	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> requestReader(HttpServletRequest request) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		Gson gson = new Gson();
		BufferedReader br = request.getReader();
		map = (HashMap<String, Object>) gson.fromJson(br.readLine(), map.getClass());
		logger.debug("ReaderMap: "+map);
//		System.out.println("카드넘버 체크: "+map.get("cardno"));
		return map;
	}
	
	@Override
	public HashMap<String, Object> requestSelectSender(HashMap<String, Object> paramMap) throws Exception {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		ServerList serverURL = memberService.getServerList();
		String serverIP = "";
		
		if(serverURL == null) {
			serverIP = "EXCEPTION";
		}else {
			serverIP = serverURL.getAddress();
		}
//		System.out.println("target IP: "+serverIP);
		String testServerIpAddr = "175.196.77.185";
		System.out.println("target IP: "+testServerIpAddr);
		
		if(!serverIP.equals("EXCEPTION")) {
			paramMap.put("Command", "60001");
			HttpPost post = new HttpPost("http://"+testServerIpAddr);
//			String jsonStr = gson.toJson(paramMap);
//			StringEntity entity = new StringEntity(jsonStr, "UTF-8");
			List<NameValuePair> paramList = httpClientUtil.convertParam(paramMap);
			post.setEntity(new UrlEncodedFormEntity(paramList, "UTF-8"));
			HttpResponse httpResponse = httpClientCashbee.execute(post);
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
			
			System.out.println("[statusCode] "+statusCode+" , [이사님이 보내주신 값]: "+body);
			returnMap = httpClientUtil.stringToHashMap(body, "&");
			
			String code = (String) returnMap.get("code");
			
			Gson gson = new Gson();
			JsonObject jso = new JsonObject();
			jso.addProperty("code", code);
			
			if( code.equals("100") ) {
				jso.addProperty("message", "ok");
				jso.addProperty("available_point", (String) returnMap.get("ap"));
			}else if( code.equals("200") ) {
				jso.addProperty("message", "미등록 카드입니다.");
			}else if( code.equals("300") ) {
				jso.addProperty("message", "사용중지된 카드입니다.");
			};
			
			returnMap.put("jsonStr", gson.toJson(jso));
		}
		return returnMap;
	}
	
	@Override
	public HashMap<String, Object> requestCommitSender(HashMap<String, Object> paramMap) throws Exception {
		
		HashMap<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("code", "100");
		tempMap.put("message", "ok");
		tempMap.put("tid", "abcd1234efg567");
		
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		ServerList serverURL = memberService.getServerList();
		String serverIP = "";
		
		if(serverURL == null) {
			serverIP = "EXCEPTION";
		}else {
			serverIP = serverURL.getAddress();
		}
//		System.out.println("target IP: "+serverIP);
		String testServerIpAddr = "175.196.77.185";
		System.out.println("target IP: "+testServerIpAddr);
		
		if(!serverIP.equals("EXCEPTION")) {
			
			System.out.println("1");
			
//			paramMap.put("Command", "60010");
			tempMap.put("Command", "60010");
			HttpPost post = new HttpPost("http://"+testServerIpAddr);
			
			System.out.println("2");
			
//			List<NameValuePair> paramList = httpClientUtil.convertParam(paramMap);
			List<NameValuePair> paramList = httpClientUtil.convertParam(tempMap);
			
			System.out.println("3");
			
			post.setEntity(new UrlEncodedFormEntity(paramList, "UTF-8"));
			
			System.out.println("4");
			
			HashMap<String, Object> timerMap = new HashMap<String, Object>();
			timerMap.put("httpPost", post);
			
			System.out.println("5");
			
			System.out.println("periodCaller before");
			HashMap<String, Object> timerReturnMap = httpClientUtil.periodCaller(timerMap);
			System.out.println("periodCaller after");
			
			HttpResponse httpResponse = (HttpResponse) timerReturnMap.get("httpResponse");
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
			
			System.out.println("[statusCode] "+statusCode+" , [이사님이 보내주신 값]: "+body);
			returnMap = httpClientUtil.stringToHashMap(body, "&");
			
			String code = (String) returnMap.get("code");
			
			Gson gson = new Gson();
			JsonObject jso = new JsonObject();
			jso.addProperty("code", code);
			
			if( code.equals("100") ) {
				jso.addProperty("message", "ok");
				jso.addProperty("available_point", (String) returnMap.get("ap"));
			}else if( code.equals("200") ) {
				jso.addProperty("message", "미등록 카드입니다.");
			}else if( code.equals("300") ) {
				jso.addProperty("message", "사용중지된 카드입니다.");
			};
			
			returnMap.put("jsonStr", gson.toJson(jso));
		}
		return returnMap;
	}

	@Override
	public HashMap<String, Object> communication(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public HashMap<String, Object> completeCharge(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	

	

}
