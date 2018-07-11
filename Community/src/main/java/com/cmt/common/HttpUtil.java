package com.cmt.common;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

public class HttpUtil {

	public HttpUtil() {
	}
	
	public static HashMap<String, Object> getParamMap(HttpServletRequest req) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		Enumeration<?> enums = req.getParameterNames();
		while(enums.hasMoreElements()) {
			String paramName = enums.nextElement().toString();
			if("".equals(req.getParameter(paramName))) {
				result = null;
				break;
			}
			result.put(paramName, req.getParameter(paramName));
		}
		return result;
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
	
}
