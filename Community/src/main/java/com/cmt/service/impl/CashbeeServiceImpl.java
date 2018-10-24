package com.cmt.service.impl;

import java.io.BufferedReader;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.cmt.common.DateUtil;
import com.cmt.common.HttpClientUtil;
import com.cmt.common.HttpUtil;
import com.cmt.dao.CashbeeDao;
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
	@Qualifier("cashbeeDaoImpl")
	private CashbeeDao cashbeeDao;
	
	@Autowired
	private HttpClientUtil httpClientUtil;
	
	@Autowired
	private HttpClient httpClientPooling;
	
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
			logger.debug("지정된 아이피 이외 접근");
			ipCheck = false;
		}
		return ipCheck;
	}

	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> requestReader(HttpServletRequest request) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		Gson gson = new Gson();
		BufferedReader br = request.getReader();
		System.out.println(br.readLine());
		map = (HashMap<String, Object>) gson.fromJson(br.readLine(), map.getClass());
		logger.debug("ReaderMap: "+map);
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
			
			if(paramMap.containsKey("tid")) {
				paramMap.put("Command", "60002");
			}else {
				paramMap.put("Command", "60001");
			}
			
			HttpPost post = new HttpPost("http://"+testServerIpAddr);
			post.setConfig(httpClientUtil.reqeustConfig(3500));
			List<NameValuePair> paramList = httpClientUtil.convertParam(paramMap);
			post.setEntity(new UrlEncodedFormEntity(paramList, "UTF-8"));
			
			boolean reachable = true;
			try {
				HttpResponse httpResponse = httpClientPooling.execute(post);
				int statusCode = httpResponse.getStatusLine().getStatusCode();
				String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
				HttpClientUtils.closeQuietly(httpResponse);
				logger.debug("[statusCode] "+statusCode+" , [이사님이 보내주신 값]: "+body);
				returnMap = httpClientUtil.stringToHashMap(body, "&");
			} catch (Exception e) {
				reachable = false;
			} finally {
				JsonObject jso = new JsonObject();
				if(reachable)
				{
					String code = (String) returnMap.get("code");
					jso.addProperty("code", code);
					if( code.equals("100") ) {
						jso.addProperty("message", "ok");
						jso.addProperty("available_point", (String) returnMap.get("ap"));
					}else if( code.equals("200") ) {
						jso.addProperty("message", "미등록 카드입니다.");
					}else if( code.equals("300") ) {
						jso.addProperty("message", "사용중지된 카드입니다.");
					};
					returnMap.put("jsonStr", jso.toString());
				}
				else
				{
					jso.addProperty("code", "-nnn");
					jso.addProperty("message", "서버점검 중입니다.");
					returnMap.put("jsonStr", jso.toString());
				}
			}
		}
		return returnMap;
	}
	
	@Override
	public HashMap<String, Object> requestCommitSender(HashMap<String, Object> paramMap) throws Exception {

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
		URIBuilder builder = new URIBuilder();
		builder.setScheme("http").setHost(testServerIpAddr)
			.setParameter("Command", "60003")
			.setParameter("cardno", (String)paramMap.get("cardno"))
			.setParameter("tid", (String)paramMap.get("tid"))
			.setParameter("amount", (String)paramMap.get("amount"));

		URI uri = builder.build();
		System.out.println("target IP: "+testServerIpAddr);
		
		if(!serverIP.equals("EXCEPTION")) {
			
			//성공 60003
			paramMap.put("Command", "60003");
			
			HttpPost post = new HttpPost(uri);
			post.setConfig(httpClientUtil.reqeustConfig(3500));
			
//			List<NameValuePair> paramList = httpClientUtil.convertParam(paramMap);
//			post.setEntity(new UrlEncodedFormEntity(paramList, "UTF-8"));
			System.out.println("+++ list +++ "+ uri);
			
			boolean reachable = true;
			try {
				HttpResponse httpResponse = httpClientPooling.execute(post);
				int statusCode = httpResponse.getStatusLine().getStatusCode();
				String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
				//임의 실패
//				if(body.equals("code=200")) reachable = false;
				HttpClientUtils.closeQuietly(httpResponse);
				logger.debug("[statusCode] "+statusCode+" , [이사님이 보내주신 값]: "+body);
			} catch (Exception e) {
				reachable = false;
			} finally {
				//통신성공시 기록
				if(reachable)
				{
					System.out.println("통신성공");
				}
				//통신실패시 기록
				else
				{
					System.out.println("통신실패");
					cashbeeDao.addCompleteCashbee(paramMap);
				}
				JsonObject jso = new JsonObject();
				jso.addProperty("code", "100");
				jso.addProperty("message", "ok");
				jso.addProperty("tid", (String)paramMap.get("tid"));
				returnMap.put("jsonStr", jso.toString());
			}
		}
		return returnMap;
	}

	@Override
	public HashMap<String, Object> getLockLog(HttpServletRequest request) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Gson gson = new Gson();
		resultMap.put("list", gson.toJson(cashbeeDao.getLockLog()));
		return resultMap;
	}

	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> getChargeLog(HttpServletRequest request) throws Exception {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		return DateUtil.transformateDate((HashMap<String, Object>)cashbeeDao.getChargeLog(paramMap));
	}

}
