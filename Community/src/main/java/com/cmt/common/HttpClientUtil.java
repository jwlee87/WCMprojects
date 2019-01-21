package com.cmt.common;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
public class HttpClientUtil {
	
	private Logger logger = LogManager.getLogger();

	@Bean
	public HttpClient httpClientPooling() {
		PoolingHttpClientConnectionManager pcm = new PoolingHttpClientConnectionManager();
		pcm.setMaxTotal(300);
		pcm.setDefaultMaxPerRoute(50);
		return HttpClients.custom().setConnectionManager(pcm).build();
	}
	
	@Bean
	public HttpClient httpClientTimeOut() {
		int DEFAULT_TIMEOUT = 3000;
		RequestConfig defaultRequestConfig = RequestConfig.custom()
				.setConnectTimeout(DEFAULT_TIMEOUT)
				.setConnectTimeout(DEFAULT_TIMEOUT)
				.setSocketTimeout(DEFAULT_TIMEOUT)
				.setConnectionRequestTimeout(DEFAULT_TIMEOUT)
				.build();
		return HttpClients.custom().setDefaultRequestConfig(defaultRequestConfig).build();
	}
	
	public RequestConfig reqeustConfig(int DEFAULT_TIMEOUT) {
		RequestConfig defaultRequestConfig = RequestConfig.custom()
				.setConnectTimeout(DEFAULT_TIMEOUT)
				.setConnectTimeout(DEFAULT_TIMEOUT)
				.setSocketTimeout(DEFAULT_TIMEOUT)
				.setConnectionRequestTimeout(DEFAULT_TIMEOUT)
				.build();
		return defaultRequestConfig;
	}
	
	public HashMap<String, Object> getParamMap(HttpServletRequest req) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		Enumeration<?> enums = req.getParameterNames();
		while(enums.hasMoreElements()) {
			String paramName = enums.nextElement().toString();
//			if("".equals(req.getParameter(paramName))) {
//				result = null;
//				break;
//			}
			result.put(paramName, req.getParameter(paramName));
		}
		return result;
	}
	
	public List<NameValuePair> convertParam(Map<String, Object> params){
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		Iterator<String> keys = params.keySet().iterator();
		while(keys.hasNext()){
			String key = keys.next();
			paramList.add(new BasicNameValuePair(key, params.get(key).toString()));
		}
		return paramList;
	}
	
	public HashMap<String, Object> stringToHashMap(String body, String separator) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		String[] paramArray = body.split(separator);
		if(paramArray.length != 0) {
			for(String param : paramArray) {
				String[] innerArray = param.split("=");
				if(innerArray.length == 2) {
					returnMap.put(innerArray[0], innerArray[1]);
				}
			}
		}
		return returnMap;
	}
	
	public HashMap<String, Object> periodCaller(HashMap<String, Object> paramMap) {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();

		HttpClientUtil hcu = new HttpClientUtil();
		HttpClient httpClient = hcu.httpClientTimeOut();
		HttpPost post = (HttpPost)paramMap.get("httpPost");
		
		System.out.println("periodCaller START");
		
		boolean isRun = true;
		Timer callTimer = new Timer();
		TimerTask task = new TimerTask() {

			@Override
			public void run() {
				
				if(isRun)
				{
					
					try {
						HttpResponse httpResponse = httpClient.execute(post);
						int statusCode = httpResponse.getStatusLine().getStatusCode();
						String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
						HttpClientUtils.closeQuietly(httpResponse);
						logger.debug("[statusCode] "+statusCode+" , [이사님이 보내주신 값]: "+body);
						returnMap.put("body", body);
					} catch (ClientProtocolException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					System.out.println("5초마다 재실행");
				}
				else
				{
					callTimer.cancel();
				}
				
			}
			
		};
		
		callTimer.schedule(task, 0, 5000);
		
		System.out.println("periodCaller END");
		
		return returnMap;
	}

}
