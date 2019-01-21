package com.cmt.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.service.StoreServiceInterface;
import com.google.gson.Gson;

/*포인트 코인 락코인 로그*/
@Controller
public class HistoryController {
	
	@Autowired
	StoreServiceInterface ssi;
	
	@RequestMapping("/point/history")
	public ModelAndView result(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("resources/views/point/pHistory");
		return mav;
	}
	
	// 코인 히스토리
	@RequestMapping("/coin/history")
	public ModelAndView coinHistory(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("resources/views/point/cHistory");
		return mav;
	}
	
	// 락 코인 히스토리
	@RequestMapping("/lCoin/history")
	public ModelAndView lockCoinHistory(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("resources/views/point/lcHistory");
		return mav;
	}
	
	@RequestMapping("/history/getHis")
	@ResponseBody
	public String getHis(HttpServletRequest req) {
		HashMap<String, Object> resultMap = ssi.getHis(req);
		Gson gson = new Gson();
		return gson.toJson(resultMap);
	}

}
