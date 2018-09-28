package com.cmt.service.impl;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.dao.BenefitDaoInterface;
import com.cmt.service.BenefitServiceInterface;
import com.google.gson.Gson;

@Service
public class BenefitService implements BenefitServiceInterface {
	
	@Autowired
	BenefitDaoInterface bdi;

	@Override
	public ModelAndView benefit(HttpServletRequest req, String menu) {
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("menu", menu);
		if(menu.equals("cm")) {
			mav.addObject("data", gson.toJson(bdi.selectListMap(paramMap)));
		}else if(menu.equals("pm")) {
			mav.addObject("data", gson.toJson(bdi.selectListMap(paramMap)));
		}
		mav.addObject("menu", menu);
		mav.setViewName("resources/views/data/benefit");
		return mav;
	}
	
	@Override
	public ModelAndView benefit2(HttpServletRequest req, String menu) {
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("menu", menu);
		if(menu.equals("cm")) {
			mav.addObject("data", gson.toJson(bdi.selectListMap(paramMap)));
		}else if(menu.equals("pm")) {
			mav.addObject("data", gson.toJson(bdi.selectListMap(paramMap)));
		}
		mav.addObject("menu", menu);
		mav.setViewName("resources/views/data/benefit2");
		return mav;
	}

}
