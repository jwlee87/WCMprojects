package com.cmt.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.HttpClientUtil;
import com.cmt.common.HttpUtil;
import com.cmt.service.CashbeeService;
import com.cmt.service.MyAssetsService;
import com.google.gson.Gson;

/*내 자산 보기*/
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
	
//	@RequestMapping(value="/myAssets/main", method=RequestMethod.POST)
	@RequestMapping(value="/myAssets/main")
	public ModelAndView myAssetsMainPage(HttpServletRequest request) throws Exception {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		paramMap.put("no", 1);
		paramMap.put("lt", "a");
		logger.debug(paramMap);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myAssets/main");
		Gson gson = new Gson();
		mav.addObject("data", gson.toJson(paramMap));
		return mav;
	}
	
	@RequestMapping(value="/myAssets/getDetail", method=RequestMethod.POST)
	@ResponseBody
//	public ModelAndView myAssetsDetailPage(HttpServletRequest request) throws Exception {
	public HashMap<String, Object> myAssetsDetailPage(HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		logger.debug(paramMap);
		
		String type = (String)paramMap.get("t");
		String uNo = (String)paramMap.get("uNo");
		String no = (String)paramMap.get("no");
		
		System.out.println(type+", "+uNo+", "+no);
		
		Device device = DeviceUtils.getCurrentDevice(request);
		
		logger.debug("debug: "+device);
		
		if(device.isMobile()) {
			logger.debug("mobile"+device.getDevicePlatform().toString());
			
			
			
			return paramMap;
		}else {
			logger.debug("Not mobile"+device.getDevicePlatform().toString());
			return null;
		}
		
	}
	
	@RequestMapping(value="/myAssets/getMain", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getMyAssets(HttpServletRequest request) throws Exception {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		return mas.getMyAssets(paramMap);
	}
	
}
