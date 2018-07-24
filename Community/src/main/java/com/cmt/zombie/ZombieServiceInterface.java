package com.cmt.zombie;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface ZombieServiceInterface {
	public ModelAndView zombie(String gameName, String menu, HttpServletRequest req);
	public ModelAndView myBet(String gameName, String menu, int userNo, HttpServletRequest req);
	public ModelAndView zombieJson(String gameName, String menu, HttpServletRequest req);
}
