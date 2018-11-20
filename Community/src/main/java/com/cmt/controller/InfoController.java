package com.cmt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cmt.common.EmailSender;
import com.cmt.common.HashUtil;
import com.cmt.dao.FindDaoInterface;
import com.cmt.dao.MemberDao;
import com.cmt.dao.StoreDaoInterface;
import com.cmt.domain.Board;
import com.cmt.domain.Email;
import com.cmt.service.BoardService;
import com.cmt.service.MemberService;

/*회사 정보 페이지*/
@Controller
public class InfoController {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	@Value("#{setup['new.interval']}")
	private int interval;
	
	@Value("#{setup['tab.countTabs']}")
	private int countTabs;
	
	@Value("#{setup['tab.defaultRows']}")
	private int defaultRows;
	
	@Value("#{setup['comment.countRows']}")
	private int commentRows;

	@Value("#{setup['promotionLimit.level']}")
	private int promotionLevel;
	
	@Autowired
	private Email email;
	
	@Autowired
	private HashUtil hashUtil;
	
	@Autowired
	private EmailSender emailSender;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@Autowired
	private StoreDaoInterface sdi;
	
	@Autowired
	@Qualifier("memberDaoImpl")
	private MemberDao mdi;
	
	@Autowired
	private FindDaoInterface fdi;
	
	///Constructor
	public InfoController() {
	}
	
	///Method
	@RequestMapping(value="/info")
	public ModelAndView callPageInfo(HttpServletResponse res, HttpServletRequest request, @ModelAttribute Board board, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		logger.debug("info page init");
		mav.setViewName("info/index");
		return mav;
	}
	
	@RequestMapping(value="/info2")
	public void callPageInfo2(HttpServletResponse res, HttpServletRequest request, @ModelAttribute Board board, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		logger.debug("info2 page init");
		res.sendRedirect("/info/index.html");
	}
	
}
