package com.cmt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.HttpUtil;
import com.cmt.service.P2PExService;
import com.google.gson.Gson;

/* P2P거래 관리자 페이지 */
@Controller
public class P2PExController {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("p2pExServiceImpl")
	private P2PExService psi;
	
	@GetMapping(value="/p2p")
	public ModelAndView moveMainPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("p2p/main");
		return mav;
	}
	
	@PostMapping(value="/p2p/init")
	public @ResponseBody Map<String, Object> doPostP2PExinit(HttpServletRequest req) {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Gson gson = new Gson();
		
		returnMap.put("config", gson.toJson(paramMap));
		returnMap.put("data", gson.toJson(psi.getP2PExList(paramMap)));
		
		logger.debug(psi.getP2PExList(paramMap).size());
		logger.debug(returnMap.get("data"));
		return returnMap;
	}
	
//	분쟁해결
	@PostMapping(value="/p2p/clear")
	public @ResponseBody Map<String, Object> clearP2PEx(HttpServletRequest req){
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		return psi.updateRequestClear(paramMap);
	}
	
//	@RequestMapping(value="/myAssets/init")
	public void myAssetsInit(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception {
		/**
		 * uNo , pid
		 */
//		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
//		String uNo = (String)paramMap.get("uNo");
//		String returnString = "";
//		
//		Map<String, Object> objMap = mas.makeRandomString(uNo);
//		
//		mas.addTempUrl(objMap);
//		String authString = (String)objMap.get("authStr");
//		returnString = "http://worldspon.net/myAssets/main/"+authString.trim();
//		
////		logger.debug(objMap);
//		response.setCharacterEncoding("utf-8");
//		response.getWriter().write(returnString);
		
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
	@RequestMapping(value="/p2p/main/{authStr}")
	public ModelAndView myAssetsMainPage(HttpServletRequest request, HttpSession session, @PathVariable String authStr) throws Exception {
		
//		logger.debug("main start");
//		logger.debug("authStr: "+authStr.length());
//		logger.debug("authStr: "+authStr.trim().length());
//		List<Map<String, Object>>  mapList = mas.getMapList();
//		logger.debug(mapList);
		
		long end = System.currentTimeMillis();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
//		resultMap.put("check", "error");
//		for(int i=0; i<mapList.size(); i++) {
//			Map<String, Object> tempMap = mapList.get(i);
//			Iterator<String> keys = tempMap.keySet().iterator();
//			while(keys.hasNext()) {
//				String key = keys.next();
//				if(key.equals("beginTime")) {
//					String beginTime = (String)tempMap.get(key);
//					long start = Long.parseLong(beginTime);
//					if(mas.timeValidationChecker(start, end)) {
////						logger.debug("유효시간 초과로 인한 리스트 삭제");
//						mas.deleteTempUrl(tempMap);
//						resultMap.put("check", "error");
//					}
//				}
//			}
//		}
//		mapList = mas.getMapList();
//		for(int j=0; j<mapList.size(); j++) {
//			Map<String, Object> tempMap = mapList.get(j);
//			Iterator<String> keys = tempMap.keySet().iterator();
//			while(keys.hasNext()) {
//				String key = keys.next();
//				if(key.equals("authStr")) {
//					String mapAuthStr = (String) tempMap.get(key);
//					if(mapAuthStr.equals(authStr)) {
//						resultMap.putAll(tempMap);
//						resultMap.put("check", "true");
//					}
//				}
//			}
//		}
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		mav.addObject("data", gson.toJson(resultMap));
		mav.setViewName("myAssets/main");
		
		resultMap.put("no", 1);
//		logger.debug(resultMap);
//		logger.debug("mapList: "+mapList+", size: "+mapList.size());
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
	@RequestMapping(value="/p2p/getDetail", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> myAssetsDetailPage(HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
//		logger.debug(paramMap);
		
//		String type = (String)paramMap.get("type");
//		String uNo = (String)paramMap.get("uNo");
//		String no = (String)paramMap.get("no");
//		String listType = (String)paramMap.get("listType");
//		logger.debug(type+", "+uNo+", "+no+", "+listType);
		
//		String total = String.valueOf(mas.getTotalCount(paramMap));
//		paramMap.put("total", total);
//		HashMap<String, Object> myAssetsMap = mas.getMyAssets(paramMap);
//		paramMap.putAll(myAssetsMap);
//		
//		Device device = DeviceUtils.getCurrentDevice(request);
//		
////		logger.debug("debug: "+device);
////		logger.debug(paramMap);
//		
//		if(device.isMobile()) {
////			logger.debug("mobile"+device.getDevicePlatform().toString());
//			return paramMap;
//		}else {
////			logger.debug("Not mobile"+device.getDevicePlatform().toString());
//			return null;
//		}
		return null;
	}
	
	@RequestMapping(value="/lt/getDetailContents", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> myAssetsDetailContents(HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
		
//		logger.debug(paramMap);
		
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
		
//		logger.debug(paramMap);
		
//		paramMap.putAll(mas.getDetailContents(paramMap));
		return paramMap;
	}
	
	@RequestMapping(value="/lt/getMain", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> getMyAssets(HttpServletRequest request) throws Exception {
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(request);
//		logger.debug(paramMap);
//		return mas.getMyAssets(paramMap);
		return null;
	}
	
}
