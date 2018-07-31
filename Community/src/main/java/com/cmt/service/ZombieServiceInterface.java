package com.cmt.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface ZombieServiceInterface {
	public ModelAndView zombie(String gameName, String menu, HttpServletRequest req);
	public ModelAndView myBet(String gameName, String menu, int userNo, HttpServletRequest req) throws Exception;
	public ModelAndView zombieJson(String gameName, String menu, HttpServletRequest req);
	public ModelAndView history(HttpServletRequest req);
	public HashMap<String, Object> getHis(HttpServletRequest req);
}
