package com.cmt.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Period;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.HttpClientUtil;
import com.cmt.common.HttpUtil;
import com.cmt.service.CashbeeService;
import com.cmt.service.MyAssetsService;
import com.google.gson.Gson;

@Controller
public class MyAssetsController {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("cashbeeServiceImpl")
	private CashbeeService cashbeeService;
	
	@Autowired
	@Qualifier("myAssetsServiceImpl")
	private MyAssetsService mas;
	
	@Autowired
	private HttpClientUtil httpClientUtil;
	
	
	
	///Constructor
	public MyAssetsController() {
		
	}
	
	@RequestMapping(value="/myAssets/main")
	public ModelAndView myAssetsMainPage(HttpServletRequest request) throws Exception {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		paramMap.put("no", 1);
		logger.debug(paramMap);
		
		String strDateTime = (String)paramMap.get("dt");
		String strDate = strDateTime.substring(0, 4);
		String strTime = strDateTime.substring(4);
		logger.debug(strDate+", "+strTime);
		
		String strMon = strDate.substring(0, 2);
		String strDay = strDate.substring(2);
		String strHour = strTime.substring(0, 2);
		String strMin = strTime.substring(2);
		
		logger.debug(strMon+", "+strDay+", "+strHour+", "+strMin);
		
		int intMon = Integer.parseInt(strMon);
		int intDay = Integer.parseInt(strDay);
		int intHour = Integer.parseInt(strHour);
		int intMin = Integer.parseInt(strMin);
		
		logger.debug(intMon+", "+intDay+", "+intHour+", "+intMin);
		//
		LocalDate startDate = LocalDate.now();
		LocalDate endDate = LocalDate.of(startDate.getYear(), intMon, intDay);
		
		Period period = Period.between(startDate, endDate);
		int gapMon = period.getMonths();
		int gapDay = period.getDays();
		
		
		LocalTime startTime = LocalTime.now();
		LocalTime endTime = LocalTime.of(intHour, intMin, 00);
		
		Duration duration = Duration.between(startTime, endTime);
		duration.getSeconds();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myAssets/main");
		Gson gson = new Gson();
		mav.addObject("data", gson.toJson(paramMap));
		return mav;
	}
	
	@RequestMapping(value="/myAssets/detail")
	public ModelAndView myAssetsDetailPage(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		logger.debug(paramMap);
		
		Device device = DeviceUtils.getCurrentDevice(request);
		if(device.isMobile()) {
			logger.debug("mobile"+device.getDevicePlatform().toString());
			mav.setViewName("myAssets/detail");
		}else {
			logger.debug("Not mobile"+device.getDevicePlatform().toString());
		}
		
		
		
		
		
		
		
		return mav;
	}
	
	@RequestMapping(value="/myAssets/get")
	@ResponseBody
	public HashMap<String, Object> getMyAssets(HttpServletRequest request) throws Exception {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		return mas.getMyAssets(paramMap);
	}
	
}
