package com.cmt.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
public class HttpClientUtil {

	@Bean
	public HttpClient httpClientCashbee() {
		PoolingHttpClientConnectionManager pcm = new PoolingHttpClientConnectionManager();
		pcm.setMaxTotal(300);
		pcm.setDefaultMaxPerRoute(50);
		return HttpClients.custom().setConnectionManager(pcm).build();
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
		HttpClient httpClient = hcu.httpClientCashbee();
		
		System.out.println("periodCaller START");
		
		boolean isRun = true;
		Timer callTimer = new Timer();
		TimerTask task = new TimerTask() {

			@Override
			public void run() {
				
				if(isRun)
				{
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
