package com.cmt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.HttpUtil;
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
	
	@RequestMapping(value="/myAssets/init", method=RequestMethod.POST)
//	@RequestMapping(value="/myAssets/init", method=RequestMethod.GET)
	public void myAssetsInit(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception {
		/**
		 * uNo , pid
		 */
		@SuppressWarnings("unchecked")
		
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)session.getAttribute("msList");
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		String uNo = (String)paramMap.get("uNo");
		String returnString = "";
		
		if(list == null) {
			
			logger.debug("session null 이므로 session 생성");
			
			session.setMaxInactiveInterval(60);
			String authStr = HttpUtil.generateRandomStr();
			logger.debug(authStr);
			
			paramMap.put("no", 1);
			paramMap.put("uNo", uNo);
			paramMap.put("authStr", authStr);
			returnString = "http://worldspon.net/myAssets/main/"+authStr;
			
			ArrayList<HashMap<String, Object>> tempList = new ArrayList<HashMap<String, Object>>();
			tempList.add(paramMap);
			session.setAttribute("msList", tempList);
		} else {
			
			logger.debug("session not null 이므로 session 가져오기");
			
			String authStr = "";
			for( HashMap<String, Object> sessionMap : list) {
				Iterator<String> keys = sessionMap.keySet().iterator();
				while( keys.hasNext() ) {
					String key = keys.next();
					if(key.equals("uNo")) {
						if(sessionMap.get(key).equals(uNo)) {
							logger.debug("가져온 세션의 uNo가 입력받은 uNo와 일치할때");
							logger.debug(sessionMap);
							authStr = (String) sessionMap.get("authStr");
						}
					}
				}
			}
			returnString = "http://worldspon.net/myAssets/main/"+authStr;
		}
		
		logger.debug(returnString);
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(returnString);
	}
	
	/**
	 * 
	 * @param request
	 * @paramMap
	 * no = pageNo
	 * uNo = userNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/myAssets/main/{authStr}", method=RequestMethod.GET)
	public ModelAndView myAssetsMainPage(HttpServletRequest request, HttpSession session, @PathVariable String authStr) throws Exception {
		
		logger.debug("main start");
		@SuppressWarnings("unchecked")
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)session.getAttribute("msList");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView();
		if(list != null) {
			for(HashMap<String, Object> sessionMap : list) {
				Iterator<String> keys = sessionMap.keySet().iterator();
				while(keys.hasNext()) {
					String key = keys.next();
					if(sessionMap.get(key).equals(authStr)) {
						paramMap.putAll(sessionMap);
						Gson gson = new Gson();
						mav.addObject("data", gson.toJson(paramMap));
						mav.setViewName("myAssets/main");
					}
				}
			}
		}
		
		logger.debug(paramMap);
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
