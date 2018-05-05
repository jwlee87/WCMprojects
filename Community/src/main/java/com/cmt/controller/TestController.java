package com.cmt.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.cmt.common.EmailSender;
import com.cmt.common.HashUtil;
import com.cmt.common.UtilFile;
import com.cmt.domain.ADRequest;
import com.cmt.domain.AttachFile;
import com.cmt.domain.Board;
import com.cmt.domain.Comment;
import com.cmt.domain.Email;
import com.cmt.domain.RewardList;
import com.cmt.domain.Line;
import com.cmt.domain.Member;
import com.cmt.domain.Page;
import com.cmt.domain.Promotion;
import com.cmt.domain.ServerList;
import com.cmt.domain.SystemInfo;
import com.cmt.domain.Tab;
import com.cmt.service.BoardService;
import com.cmt.service.MemberService;
import com.google.gson.Gson;

@Controller
public class TestController {
	
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
	
	///Constructor
	public TestController() {
	}
	
	///Method
	@RequestMapping(value="/boardTest")
	public String boardTest(HttpSession session, HttpServletRequest request, @ModelAttribute Board board, Model model) throws Exception {
		int boardUniqueID = board.getBoardUniqueID();
		Board boardDomain = boardService.getBoardTest(boardUniqueID);
		String texts = boardDomain.getContents();
		
		texts = texts.replaceAll(System.getProperty("line.separator"), "<br>");
		logger.debug(texts);
		board.setContents(texts);
		
		model.addAttribute("board", board);
		
		return "board/test";
	}
		
}
