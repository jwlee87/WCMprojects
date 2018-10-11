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
import com.cmt.service.ServerServiceInterface;
import com.google.gson.Gson;

@Controller
public class ServerListController {
	
	///Field
	@Autowired
	private ServerServiceInterface ssi;
	
	///Method
	@RequestMapping(value="/server")
	public ModelAndView getApList(HttpSession session, HttpServletRequest request, @ModelAttribute Board board, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		mav.addObject("list", gson.toJsonTree(ssi.getServerList()));
		mav.setViewName("resources/views/server/list");
		return mav;
	}
	/// INSERT
	@RequestMapping(value="/server/add", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> addServer(HttpServletRequest req){
		return ssi.addServer(req);
	}
	
	@RequestMapping(value="/server/get/a", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> ajaxList(HttpServletRequest req){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", ssi.getServerList());
		return resultMap;
	}
	
	@RequestMapping(value="/server/u", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> ajaxUpadate(HttpServletRequest req){
		return ssi.updateServer(req);
	}
	
	@RequestMapping(value="/server/d", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> ajaxDelete(HttpServletRequest req){
		return ssi.deleteServer(req);
	}
}
