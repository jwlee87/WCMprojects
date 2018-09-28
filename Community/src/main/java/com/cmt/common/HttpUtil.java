package com.cmt.common;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.simple.JSONObject;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.nhncorp.lucy.security.xss.XssPreventer;

public class HttpUtil {
	
	public static HashMap<String, Object> getParamMap(HttpServletRequest req) {
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
	
	public static HashMap<String, Object> unescapeMap(HashMap<String, Object> paramMap) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		Set<String> keys = paramMap.keySet();
		while(keys.iterator().hasNext()) {
			String paramName = keys.iterator().next().toString();
			result.put(paramName, xssUnescape((String)paramMap.get(paramName)));
		}
		System.out.println(result);
		return result;
	}
	
	public static HashMap<String, Object> escapeMap(HashMap<String, Object> paramMap) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		Set<String> keys = paramMap.keySet();
		while(keys.iterator().hasNext()) {
			String paramName = keys.iterator().next().toString();
			result.put(paramName, xssEscape((String)paramMap.get(paramName)));
		}
		System.out.println(result);
		return result;
	}
	
	public static String xssEscape(String dirty) {
		return XssPreventer.escape(dirty);
	}
	public static String xssUnescape(String clean) {
		return XssPreventer.unescape(clean);
	}
	
	public static ModelAndView makeJsonView(HashMap<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		String jsonStr = JSONObject.toJSONString(map);
		mav.addObject("json", jsonStr);
		mav.setViewName("json");
		
		return mav;
	}
	
	
	public static void makeJsonWriter(HttpServletResponse res, HashMap<String, Object> map) {
		res.setContentType("text/html;charset=utf-8");
		String jsonStr = JSONObject.toJSONString(map);
		try {
			res.getWriter().write(jsonStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static JsonObject getJsonOfResponse(String url) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String jsonStr = "";
		Gson gson = new GsonBuilder().create();
		return new JsonObject();
	}
	
//	파라미터 스트링으로 Convert
	public static List<NameValuePair> convertParam(Map<String, Object> params){
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		Iterator<String> keys = params.keySet().iterator();
		while(keys.hasNext()){
			String key = keys.next();
			paramList.add(new BasicNameValuePair(key, params.get(key).toString()));
		}
		return paramList;
	}
	
	public static HashMap<String, Object> httpClient(HashMap<String, Object> paramMap) {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		int DEFAULT_TIMEOUT = 5000;
		String address = paramMap.get("url").toString().trim();
		String paramKey= "";
		
		RequestConfig defaultRequestConfig = RequestConfig.custom()
				.setConnectTimeout(DEFAULT_TIMEOUT)
				.setSocketTimeout(DEFAULT_TIMEOUT)
				.setConnectionRequestTimeout(DEFAULT_TIMEOUT)
				.build();
		
		CloseableHttpClient hc = HttpClients.custom()
				.setDefaultRequestConfig(defaultRequestConfig)
				.build();
		
		switch(paramMap.get("Command").toString()){
			case "10001": paramKey = "uniqueID";
				break;
			case "10101": paramKey = "phone";
				break;
			case "10102": paramKey = "trademark";
				break;
		}
		
		System.out.println(paramMap.get("Command") + " : " + paramKey + " : " + paramMap.get("value"));
		
		HttpPost post = new HttpPost("http://"+address);
		post.setConfig(defaultRequestConfig);
		paramMap.put(paramKey, paramMap.get("value"));
		paramMap.remove("url");
		paramMap.remove("value");
		System.out.println("paramMap= " + paramMap);
		
		List<NameValuePair> paramList = convertParam(paramMap);
		try {
			post.setEntity(new UrlEncodedFormEntity(paramList, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		post.addHeader("User-Agent", "Mozila/5.0");
		HttpResponse httpResponse;
		
		try {
			httpResponse = hc.execute(post);
			int statusCode = httpResponse.getStatusLine().getStatusCode();
			
			String body = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8.name());
			System.out.println(body);
			
			if(statusCode==200) {
				returnMap.put("check", "true");
				returnMap.put("result", body);
			} else {
				returnMap.put("check", "false");
				returnMap.put("result", "response error! 관리자에게 문의해주세요.");
			}
		} catch (IOException e) {
			System.out.println(" Time out Exception -" + address + " 서버 응답없음 ");
		} finally {
			try {
				hc.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return returnMap;
	}
	
	/**
	 * 
	 * string to hex string
	 * 
	 * @param string
	 * @return hex string
	 */
	public static String strToHex(String param) {
		String result = "";
		for(int i = 0; i < param.length(); i++) {
			result += String.format("%02X", (int)param.charAt(i));
		}
		return result;
	}
	
	/**
	 * 
	 * string to ascii-code(10진수)
	 * 
	 * @param param
	 * @return
	 */
	public static String encryptionPass(String param) {
		String result = "";
		for(int i = 0; i < param.length(); i++) {
		if(i != param.length() - 1) {
				result += (int) param.charAt(i) + "x";
			}else {
				result += (int) param.charAt(i);
			}
		}
		return result;
	}
	
	public static String restorePass(String param) {
		String result = "";
		String[] strArray = param.split("x");
		
		int[] intArray = new int[strArray.length];
		int i = 0;
		for(String unit : strArray) {
			intArray[i] = Integer.parseInt(unit);
			i ++;
		}
		for(int unit : intArray) {
			result += (char) unit;
		}
		return result;
	}
	
	public static byte[] strToByteArray(String param) throws UnsupportedEncodingException {
		byte[] byteArray = param.getBytes("UTF-8");
		String abc = new String(byteArray, "UTF-8");
		return byteArray;
	}
	
	public static String hexToStr(String param) {
		String result = "";
		String[] strArray = param.split(" ");
		for(String a : strArray) {
			System.out.println(a);
		}
		
		char[] charArray = new char[]{};
//		for(int i = 0; i < hexArray.length; i++) {
//			charArray[i] = (char)charArray[i];
//		}
		return new String(charArray);
	}
	/**
	 * hex string to byte[]
	 *
	 * @param hex HEX String
	 * @return converted byte array from hex string
	 */
	public static byte[] hexToByteArray(String hex) {
		hex = hex.replaceAll("\"", "\\\""); /*" */
		if (hex == null || hex.length() == 0) {
			return null;
		}
	
		byte[] ba = new byte[hex.length() / 2];
		for (int i = 0; i < ba.length; i++) {
			ba[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
		}
		return ba;
	}
	
	/**
	 * byte[] to hex sting
	 *
	 * @param byteArray byte array
	 * @return converted hex string from byte array
	 */
	public static String byteArrayToHex(byte[] byteArray) {
		if (byteArray == null || byteArray.length == 0) {
			return null;
		}
		StringBuilder stringBuffer = new StringBuilder(byteArray.length * 2);
		String hexNumber;
		for (byte aBa : byteArray) {
			hexNumber = "0" + Integer.toHexString(0xff & aBa);
			stringBuffer.append(hexNumber.substring(hexNumber.length() - 2));
		}
		return stringBuffer.toString();
	}
	
}
