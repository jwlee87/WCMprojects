package com.cmt.service.impl;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cmt.common.HttpClientUtil;
import com.cmt.dao.P2PExDaoInterface;
import com.cmt.domain.ServerList;
import com.cmt.service.MemberService;
import com.cmt.service.P2PExService;
import com.google.gson.Gson;

@Service("p2pExServiceImpl")
public class P2PExServiceImpl implements P2PExService {
	
	private Logger logger = LogManager.getLogger();
	private final String NULL_CHECK = "EXCEPTION";
	private final int DEFAULT_TIMEOUT = 5000;

	@Autowired
	@Qualifier("p2pExDaoImpl")
	private P2PExDaoInterface pdi;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	private HttpClientUtil httpClientUtil;
	
	@Autowired
	private HttpClient httpClientPooling;
	
	@Override
	public int getTotalCount(Map<String, Object> paramMap) {
		return 0;
	}

	@Override
	public Map<String, Object> getP2PEx(Map<String, Object> paramMap) {
		return null;
	}

	@Override
	public List<Map<String, Object>> getP2PExList(Map<String, Object> paramMap) {
		return pdi.getP2PExList(paramMap);
	}

	@Override
	public Map<String, Object> updateP2PEx(Map<String, Object> paramMap) {
		return null;
	}

	@Override
	public Map<String, Object> getPagination(Map<String, Object> paramMap) {
		Map<String, Object> returnMap = paramMap;
		returnMap.put("totalCount", pdi.getTotalCount(paramMap));
		return returnMap;
	}

	@Override
	public Map<String, Object> updateRequestClear(HashMap<String, Object> paramMap) {
		System.out.println("updateRequestClear()");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		ServerList serverURL = null;
		try {
			serverURL = memberService.getServerList();
		} catch (Exception e) {
			e.printStackTrace();
			serverURL = null;
		}
		String serverIP = "";
		if(serverURL != null) {
			serverIP = serverURL.getAddress();
		}else { 
			serverIP = NULL_CHECK;
		}
		if(!serverIP.equals(NULL_CHECK)) {
			logger.debug("serverURL is not null /// sending start ///");
		} else {
			logger.debug("serverURL is null /// sending false ///");
		}
		HttpPost post = new HttpPost("http://"+serverIP);
		post.setConfig(httpClientUtil.reqeustConfig(DEFAULT_TIMEOUT));
		List<NameValuePair> paramList = httpClientUtil.convertParam(paramMap);
		paramList.add(0, new BasicNameValuePair("Command", "70001"));
		try {
			post.setEntity(new UrlEncodedFormEntity(paramList, "UTF-8"));
			boolean flag = false;
			
			try {
				HttpResponse httpResponse = httpClientPooling.execute(post);
				int statusCode = httpResponse.getStatusLine().getStatusCode();
				String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
				HttpClientUtils.closeQuietly(httpResponse);
				logger.debug("[statusCode] "+statusCode+", [받은 값]: "+body);
				if(body.equals(""))	flag = true;
			} catch (IOException e) {
				flag = false;
				e.printStackTrace();
				returnMap.put("msg", "hc execute IO Exception");
			} catch (Exception e) {
				flag = false;
				returnMap.put("msg", "httpClientUtil.stringToHashMap Exception");
				e.printStackTrace();
			} finally {
				if(flag) {
					returnMap.put("msg", "true");
				}else {
					returnMap.put("msg", "false");
				}
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			returnMap.put("msg", "파라미터 인코딩 에러");
		}
		logger.debug(returnMap);
		return returnMap;
	}

}
