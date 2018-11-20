package com.cmt.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.service.ZombieServiceInterface;
import com.google.gson.Gson;

/*게임 기록 페이지*/
@Controller
public class GameController {
	
	@Autowired
	ZombieServiceInterface zsi;
	
	@RequestMapping("/game/history")
	public ModelAndView result(HttpServletRequest req) {
		return zsi.history(req);
	}
	
	@RequestMapping("/game/{gameName}/{menu}")
	public ModelAndView result(@PathVariable String gameName, @PathVariable String menu, HttpServletRequest req) {
		return zsi.zombie(gameName, menu, req);
	}
	
	@RequestMapping("/game/{gameName}/{menu}/{userNo}")
	public ModelAndView result(@PathVariable String gameName, @PathVariable String menu, @PathVariable int userNo, HttpServletRequest req) throws Exception {
		return zsi.myBet(gameName, menu, userNo, req);
	}
	
	@RequestMapping("/ri/{uniqueID}")
	public ModelAndView recodeIntegration(@PathVariable String uniqueID, HttpServletRequest req) {
		
		ModelAndView aa = new ModelAndView();
		return aa;
	}
	
	@RequestMapping("/game/getHis")
	@ResponseBody
	public String getHis(HttpServletRequest req) {
		HashMap<String, Object> resultMap = zsi.getHis(req);
		Gson gson = new Gson();
		return gson.toJson(resultMap);
	}

}
