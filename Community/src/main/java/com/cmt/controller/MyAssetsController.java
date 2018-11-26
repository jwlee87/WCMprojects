package com.cmt.controller;

import java.util.ArrayList;
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
		logger.debug(paramMap);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myAssets/main");
		Gson gson = new Gson();
		mav.addObject("data", gson.toJson(paramMap));
		return mav;
	}
	
	
	/**
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 * @filed String type : Assets 타입 spon / point / lockspon
	 * @filed String uNo : 유저 UniqueID
	 * @filed String no : 현재 페이지 번호
	 * @filed String lt : 현재 페이지 리스트 타입 lt : a[all] / i[input] / o[output] 
	 */
	@RequestMapping(value="/myAssets/getDetail", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> myAssetsDetailPage(HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		logger.debug(paramMap);
		
		String type = (String)paramMap.get("type");
		String uNo = (String)paramMap.get("uNo");
		String no = (String)paramMap.get("no");
		String listType = (String)paramMap.get("listType");
		
		logger.debug(type+", "+uNo+", "+no+", "+listType);
		String total = String.valueOf(mas.getTotalCount(paramMap));
		paramMap.put("total", total);
		HashMap<String, Object> myAssetsMap = mas.getMyAssets(paramMap);
		paramMap.putAll(myAssetsMap);
		
		Device device = DeviceUtils.getCurrentDevice(request);
		
		logger.debug("debug: "+device);
		logger.debug(paramMap);
		
		if(device.isMobile()) {
			logger.debug("mobile"+device.getDevicePlatform().toString());
			return paramMap;
		}else {
			logger.debug("Not mobile"+device.getDevicePlatform().toString());
			return null;
		}
		
	}
	
	@RequestMapping(value="/myAssets/getDetailContents", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> myAssetsDetailContents(HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		int begin = Integer.parseInt((String)paramMap.get("page[begin]"));
		int end = Integer.parseInt((String)paramMap.get("page[end]"));
		String no = (String)paramMap.get("page[no]");
		String total = (String)paramMap.get("page[total]");
		String max = (String)paramMap.get("page[max]");
		
		paramMap.put("begin", begin);
		paramMap.put("end", end);
		paramMap.put("no", no);
		paramMap.put("total", total);
		paramMap.put("max", max);
		
		paramMap.remove("page[begin]");
		paramMap.remove("page[end]");
		paramMap.remove("page[no]");
		paramMap.remove("page[total]");
		paramMap.remove("page[max]");
		paramMap.remove("page[count]");
		
		logger.debug(paramMap);
		
		paramMap.putAll(mas.getDetailContents(paramMap));
		return paramMap;
	}
	
	@RequestMapping(value="/myAssets/getMain", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> getMyAssets(HttpServletRequest request) throws Exception {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		return mas.getMyAssets(paramMap);
	}
	
}
