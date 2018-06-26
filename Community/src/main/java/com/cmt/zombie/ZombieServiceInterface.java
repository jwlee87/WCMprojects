package com.cmt.zombie;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface ZombieServiceInterface {
	public ModelAndView zombie(String menu, String type, HttpServletRequest req);
	public ModelAndView zombieJson(String menu, String type, HttpServletRequest req);
}
