package com.cmt.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.DateUtil;
import com.cmt.common.HttpUtil;
import com.cmt.dao.PointDaoInterface;
import com.cmt.service.PointServiceInterface;
import com.google.gson.Gson;

@Service
public class PointService implements PointServiceInterface {

	@Autowired
	private PointDaoInterface pdi;

	@Override
	public ModelAndView pointList(HttpServletRequest req, HashMap<String, Object> paramMap) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> tempMap = pdi.selectList(paramMap);
		
		Gson gson = new Gson();
		mav.addObject("data", gson.toJson(tempMap));
		mav.setViewName("resources/views/point/refund");
		return mav;
	}

	@Override
	public HashMap<String, Object> pointAjaxList(HttpServletRequest req, HashMap<String, Object> paramMap) {
		return DateUtil.transformateDate((HashMap<String, Object>)pdi.selectList(paramMap));
	}

	@Override
	public HashMap<String, Object> pointUpdate(HttpServletRequest req) {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		System.out.println(paramMap);
		HashMap<String, Object> checkMap = pdi.selectOne(paramMap);
		boolean cc = (boolean) checkMap.get("changeCheck");
		if(cc) {
			System.out.println("체크 트루");
			paramMap.put("dateTime", DateUtil.todayKoreanString());
			paramMap.put("state", 1);
			returnMap = pdi.pointUpdate(paramMap);
		}else {
			System.out.println("체크 펄스");
			returnMap.put("result", "false");
		}
		return returnMap;
	}

}
