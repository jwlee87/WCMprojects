package com.cmt.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.HashUtil;
import com.cmt.domain.Board;
import com.cmt.service.FindServiceInterface;
import com.cmt.service.MemberService;
import com.google.gson.Gson;

/*직접 비밀번호 찾기*/
@Controller
public class FindController {
	
	///Field
	private Logger logger = LogManager.getLogger();
	@Autowired
	private HashUtil hashUtil;

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	private FindServiceInterface fsi;
	
	///Method
	@RequestMapping(value="/admin/find")
	public ModelAndView boardTest(HttpSession session, HttpServletRequest request, @ModelAttribute Board board, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("resources/views/find/index");
		return mav;
	}
	
	@RequestMapping(value="/admin/callFind", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getHis(HttpServletRequest req) {
		return fsi.getFindAjax(req);
	}
}	
