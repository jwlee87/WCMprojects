package com.cmt.service.impl;

import java.util.HashMap;
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
public class PointServiceImpl implements PointServiceInterface {

	@Autowired
	private PointDaoInterface pdi;

	@Override
	public ModelAndView getPointList(HttpServletRequest req, HashMap<String, Object> paramMap) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> tempMap = pdi.selectList(paramMap);
		
		int totalCount = pdi.selectTotalCount(paramMap);
		System.out.println(totalCount);
		
		Gson gson = new Gson();
		mav.addObject("data", gson.toJson(tempMap));
		mav.setViewName("resources/views/point/refund");
		return mav;
	}

	@Override
	public HashMap<String, Object> getPointAjaxList(HttpServletRequest req, HashMap<String, Object> paramMap) {
		return DateUtil.transformateDate((HashMap<String, Object>)pdi.selectList(paramMap));
	}

	@Override
	public HashMap<String, Object> updatePoint(HttpServletRequest req) {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		HashMap<String, Object> checkMap = pdi.selectOneRefund(paramMap);
		boolean cc = (boolean) checkMap.get("changeCheck");
		
		if(cc) {
			paramMap.put("dateTime", DateUtil.todayKoreanString());
			
			String type = (String)paramMap.get("type");
			if(type.equals("accept")) {
				paramMap.put("state", 1);
			} else if(type.equals("refuse")) {
				paramMap.put("state", 2);
				String pointWithComma = (String) paramMap.get("point");
				paramMap.put("point", Integer.parseInt(pointWithComma.replaceAll(",", "")));
				HashMap<String, Object> tempMap = pdi.selectOnePoint(paramMap);
				int sum = Integer.parseInt(paramMap.get("point").toString()) + Integer.parseInt(tempMap.get("_Point").toString());
				paramMap.put("point", sum);
			}
			returnMap = pdi.updateState(paramMap);
		}else {
			returnMap.put("result", 0);
		}
		return returnMap;
	}

}
