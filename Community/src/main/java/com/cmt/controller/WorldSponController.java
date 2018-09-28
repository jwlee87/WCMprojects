package com.cmt.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.dao.BenefitDaoInterface;
import com.cmt.service.BenefitServiceInterface;

@Controller
public class WorldSponController {
	
	@Autowired
	BenefitDaoInterface bdi;
	
	@Autowired
	BenefitServiceInterface bsi;
	
	@RequestMapping("/benefit/data/{menu}")
	public ModelAndView result(HttpServletRequest req, @PathVariable String menu) throws IOException {
		return bsi.benefit(req, menu);
	}
	
	@RequestMapping("/benefit2/data/{menu}")
	public ModelAndView result2(HttpServletRequest req, @PathVariable String menu) throws IOException {
		return bsi.benefit2(req, menu);
	}
}
