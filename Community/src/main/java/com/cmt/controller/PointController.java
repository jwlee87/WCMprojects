package com.cmt.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.HttpUtil;
import com.cmt.service.PointServiceInterface;

@Controller
public class PointController {
	
	@Autowired
	PointServiceInterface psi;
	
	@RequestMapping("/point/refund")
	public ModelAndView refund(HttpServletRequest req) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("state", 0);
		return psi.pointList(req, paramMap);
	}
	
	@RequestMapping(value="/point/getAjax", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> acceptList(HttpServletRequest req) {
		long start = System.currentTimeMillis();
		
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		
		String type = (String)paramMap.get("type");
		if(type.equals("ready")) {
			paramMap.put("state", 0);
		}else if(type.equals("accept")) {
			paramMap.put("state", 1);
		}else if(type.equals("cancle")) {
			paramMap.put("state", 2);
		}else {
			paramMap.put("state", 0);
		}
		
		long end = System.currentTimeMillis();
		System.out.println("실행시간: "+(end - start)/1000.0);
		return psi.pointAjaxList(req, paramMap);
	}
	
	// 승인
	@RequestMapping(value="/point/update", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> update(HttpServletRequest req) {
		return psi.pointUpdate(req);
	}
	
}
