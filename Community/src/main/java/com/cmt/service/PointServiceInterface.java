package com.cmt.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface PointServiceInterface {
	public ModelAndView pointList(HttpServletRequest req, HashMap<String, Object> paramMap);
	public HashMap<String, Object> pointUpdate(HttpServletRequest req);
	public HashMap<String, Object> pointAjaxList(HttpServletRequest req, HashMap<String, Object> paramMap);
}
