package com.cmt.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface PointServiceInterface {
	public ModelAndView getPointList(HttpServletRequest req, HashMap<String, Object> paramMap);
	public HashMap<String, Object> updatePoint(HttpServletRequest req);
	public HashMap<String, Object> getPointAjaxList(HttpServletRequest req, HashMap<String, Object> paramMap);
}
