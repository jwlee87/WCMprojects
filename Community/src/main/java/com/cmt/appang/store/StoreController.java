package com.cmt.appang.store;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StoreController {
	
	@Autowired
	StoreServiceInterface ssi;
	
	@RequestMapping("/appang/store/payment")
	public void appangStorePayment(HttpServletRequest req, HttpServletResponse res) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> tempMap = new HashMap<String, Object>();
		
		String result;
		
		tempMap = ssi.payment(req);
		if((boolean) tempMap.get("returnFlag")) {
			result = "1";
			map.put("money", tempMap.get("money"));
			System.out.println("성공");
		}else{
			result = "0";
			System.out.println("실패");
		};
		map.put("result", result);
		
		try {
			res.setHeader("Content-Type", "text/html");
			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().write(JSONObject.toJSONString(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/appang/store/refund")
	public void appangStoreRefund(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("환불 시스템");
	}
}