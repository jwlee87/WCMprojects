package com.cmt.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.domain.Board;
import com.cmt.service.ApServiceInterface;
import com.google.gson.Gson;

@Controller
public class AdvertisingProviderController {
	
	///Field
	@Autowired
	private ApServiceInterface asi;
	
	///Method
	@RequestMapping(value="/mariatest")
	public ModelAndView getApList(HttpSession session, HttpServletRequest request, @ModelAttribute Board board, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		Gson gson = new Gson();
		mav.addObject("list", gson.toJsonTree(asi.getApList()));
		mav.setViewName("resources/views/advertising/list");
		return mav;
	}
	/// INSERT
	@RequestMapping(value="/ap/add", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> addAp(HttpServletRequest req){
		return asi.addAp(req);
	}
	
	@RequestMapping(value="/ap/get/a", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> ajaxList(HttpServletRequest req){
		return asi.getAjaxList(req);
	}
	
}	
