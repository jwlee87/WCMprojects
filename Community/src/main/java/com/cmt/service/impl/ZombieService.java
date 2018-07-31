package com.cmt.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.HttpUtil;
import com.cmt.dao.ZombieDaoInterface;
import com.cmt.service.ZombieServiceInterface;

@Service
public class ZombieService implements ZombieServiceInterface {

	@Autowired
	private ZombieDaoInterface zdi;

	@Override
	public ModelAndView zombie(String gameName, String menu, HttpServletRequest req) {
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView();
		param.put("gameName", gameName);
 		param.put("menu", menu);
//		param.put("param", HttpUtil.getParamMap(req));
//		System.out.println("gameName= "+gameName+", menu= "+menu);
		
		if("run".equals(gameName)) {
			if("tList".equals(menu)) {
				mav.setViewName("resources/views/game/runListT");
			}else if("yList".equals(menu)) {
				mav.setViewName("resources/views/game/runListY");
			}
		}else if("break".equals(gameName)) {
			if("tList".equals(menu)) {
				mav.setViewName("resources/views/game/breakListT");
			}else if("yList".equals(menu)) {
				mav.setViewName("resources/views/game/breakListY");
			}
		}else if("fight".equals(gameName)) {
			if("tList".equals(menu)) {
				mav.setViewName("resources/views/game/fightListT");
			}else if("yList".equals(menu)) {
				mav.setViewName("resources/views/game/fightListY");
			}
		}else{
			mav.setViewName("resources/views/game/test");
		}
		
		HashMap<String, Object> tempMap = zdi.selectList(param);
		mav.addObject("data", JSONObject.toJSONString(tempMap));
		return mav;
	}

	@Override
	public ModelAndView zombieJson(String menu, String type, HttpServletRequest req) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelAndView myBet(String gameName, String menu, int userNo, HttpServletRequest req) throws Exception {
		HashMap<String, Object> param = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView();
		param.put("gameName", gameName);
 		param.put("menu", menu);
 		param.put("userNo", userNo);
		
 		if(!menu.equals("myBet")) {
 			throw new Exception();
 		}
 		
		HashMap<String, Object> tempMap = zdi.selectList(param);
//		System.out.println(tempMap);
		
		@SuppressWarnings("unchecked")
		ArrayList<HashMap<String, Object>> tempList = (ArrayList<HashMap<String, Object>>) tempMap.get("result");
		for(HashMap<String, Object> contents : tempList) {
			for( String key : contents.keySet() ) {
				if(key.equals("_DateTime")) {
					contents.put("_DateTime", contents.get("_DateTime").toString().substring(0, 16));
				}
			}
		}
		mav.addObject("data", JSONObject.toJSONString(tempMap));
		mav.setViewName("resources/views/game/myBet");
		return mav;
	}

	@Override
	public ModelAndView history(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("resources/views/game/history");
		return mav;	
	}

	@Override
	public HashMap<String, Object> getHis(HttpServletRequest req) {
		return zdi.getHistory(HttpUtil.getParamMap(req));
	}

}
