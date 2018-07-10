package com.cmt.zombie;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.DateUtil;
import com.cmt.common.HttpUtil;

@Service
public class ZombieService implements ZombieServiceInterface {

	@Autowired
	ZombieDaoInterface zdi;
	
	HashMap<String, Object> param;
	HashMap<String, Object> tempMap;
	ModelAndView mav;

	@Override
	public ModelAndView zombie(String menu, String type, HttpServletRequest req) {
		mav = new ModelAndView();
		param = new HashMap<String, Object>();
		param.put("menu", menu);
		param.put("type", type);
		param.put("param", HttpUtil.getParamMap(req));
		
		if("selectList".equals(type)) {
			param.put("date", DateUtil.today());
			mav.setViewName("resources/views/zombie/result");
		}else if("yList".equals(type)) {
			param.put("date", DateUtil.yesterday());
			mav.setViewName("resources/views/zombie/yResult");
		}
		
//		ZombieData.zombieDataCheck(gameCount)
		
		tempMap = zdi.selectList(param);
		ArrayList<HashMap<String, Object>> tempArray = (ArrayList<HashMap<String, Object>>) tempMap.get("result");
		int index = 1;
		for(HashMap<String, Object> tp : tempArray) {
			tp.remove("_DateTime");
			index++;
		}
		
		mav.addObject("data", JSONObject.toJSONString(tempMap));
		return mav;
	}

	@Override
	public ModelAndView zombieJson(String menu, String type, HttpServletRequest req) {
		// TODO Auto-generated method stub
		return null;
	}

}
