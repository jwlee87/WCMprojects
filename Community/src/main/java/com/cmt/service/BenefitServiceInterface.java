package com.cmt.service;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface BenefitServiceInterface {
	public ModelAndView benefit(HttpServletRequest req, String menu);
	public ModelAndView benefit2(HttpServletRequest req, String menu);
}
