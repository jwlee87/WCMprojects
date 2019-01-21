package com.cmt.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cmt.service.StoreServiceInterface;

/*앱팡 스토어*/
@Controller
public class StoreController {
	
	@Autowired
	StoreServiceInterface ssi;
	
	@RequestMapping("/appang/store/payment")
	public void appangStorePayment(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> tempMap = new HashMap<String, Object>();
		String result;
		
		tempMap = ssi.payment(req);
		if((boolean) tempMap.get("returnFlag")) {
			result = "1";
			map.put("money", tempMap.get("money"));
		}else{
			result = "0";
		};
		map.put("result", result);
		
		res.setHeader("Content-Type", "text/html");
		res.setContentType("application/json");
		res.setCharacterEncoding("UTF-8");
		res.getWriter().write(JSONObject.toJSONString(map));
	}
	
	@RequestMapping("/appang/store/refund")
	public void appangStoreRefund(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> tempMap = new HashMap<String, Object>();
		String result;
		
		tempMap = ssi.refund(req);
		if((boolean) tempMap.get("returnFlag")) {
			result = "1";
		}else{
			result = "0";
		};
		map.put("result", result);
		
		res.setHeader("Content-Type", "text/html");
		res.setContentType("application/json");
		res.setCharacterEncoding("UTF-8");
		res.getWriter().write(JSONObject.toJSONString(map));
		
	}
}