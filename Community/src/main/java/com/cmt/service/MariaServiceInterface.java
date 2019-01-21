package com.cmt.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface MariaServiceInterface {
	public HashMap<String, Object> getFindAjax(HttpServletRequest req);
}
