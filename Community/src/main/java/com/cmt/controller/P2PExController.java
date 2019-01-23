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
		
//		logger.debug(psi.getP2PExList(paramMap).size());
//		logger.debug(returnMap.get("data"));
//		logger.debug(returnMap.get("config"));
		return returnMap;
	}
	
//	분쟁해결
	@PostMapping(value="/p2p/clear")
	public @ResponseBody Map<String, Object> clearP2PEx(HttpServletRequest req){
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		return psi.updateRequestClear(paramMap);
	}
	
}
