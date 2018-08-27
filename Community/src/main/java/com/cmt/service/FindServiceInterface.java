package com.cmt.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface FindServiceInterface {
	public HashMap<String, Object> getFindAjax(HttpServletRequest req);
}
