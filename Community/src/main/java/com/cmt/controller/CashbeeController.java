package com.cmt.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.HttpClientUtil;
import com.cmt.service.CashbeeService;

@Controller
public class CashbeeController {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("cashbeeServiceImpl")
	private CashbeeService cashbeeService;
	
	@Autowired
	private HttpClientUtil httpClientUtil;
	
	///Constructor
	public CashbeeController() {
	}
	
	@RequestMapping(value="/api/verify-card-no", method=RequestMethod.POST)
	public void verifyCardNo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String inAddress = request.getRemoteAddr();
		logger.debug(inAddress+" : "+request.getRequestURL());
		
		boolean ipCheck = cashbeeService.validationCheck(inAddress);
		HashMap<String, Object> paramMap = httpClientUtil.getParamMap(request);
		System.out.println("request ParamMap: "+paramMap);
		
		String jsonStr = "";
		if(ipCheck)
		{
			HashMap<String, Object> responseMap = cashbeeService.requestSelectSender(paramMap);
			System.out.println("responseMap: "+responseMap);
			jsonStr = (String) responseMap.get("jsonStr");
			logger.debug("jsonStr: "+jsonStr);
		}
		response.setContentType("text/x-json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonStr);
	}
	
	@RequestMapping(value="/api/callback-commit-point", method=RequestMethod.POST)
	public void commitPoint(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String inAddress = request.getRemoteAddr();
		logger.debug(inAddress+" : "+request.getRequestURL());
		
		boolean ipCheck = cashbeeService.validationCheck(inAddress);	// 보안상 인입 ip 체크
		HashMap<String, Object> paramMap = httpClientUtil.getParamMap(request);
		System.out.println(paramMap);
		
		String jsonStr = "";
		if(ipCheck)
		{
			HashMap<String, Object> responseMap = cashbeeService.requestCommitSender(paramMap);
			System.out.println("responseMap: "+responseMap);
			jsonStr = (String) responseMap.get("jsonStr");
			logger.debug("jsonStr: "+jsonStr);
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonStr);
	}
	
	@RequestMapping(value="/log/charge")
	public ModelAndView chargeLog() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("WEB-INF/view/cashbee/chargeLog");
		return mav;
	}
	
	@RequestMapping(value="/log/lock")
	public ModelAndView lockLog() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("WEB-INF/view/cashbee/lockLog");
		return mav;
	}
	
	@RequestMapping(value="/log/a/lock")
	@ResponseBody
	public HashMap<String, Object> getLockLog(HttpServletRequest request) throws Exception {
		return cashbeeService.getLockLog(request);
	}
	
	@RequestMapping(value="/log/a/charge")
	@ResponseBody
	public HashMap<String, Object> getChargeLog(HttpServletRequest request) throws Exception {
		return cashbeeService.getChargeLog(request);
	}
	
	@RequestMapping(value="/cashbee/update/state")
	@ResponseBody
	public HashMap<String, Object> updateLockState(HttpServletRequest request) throws Exception {
		return cashbeeService.updateLockState(request);
	}
}
