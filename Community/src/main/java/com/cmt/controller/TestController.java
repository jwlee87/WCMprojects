package com.cmt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
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
import com.cmt.common.HttpUtil;
import com.cmt.dao.FindDaoInterface;
import com.cmt.dao.MemberDao;
import com.cmt.dao.MyAssetsDao;
import com.cmt.dao.StoreDaoInterface;
import com.cmt.domain.Board;
import com.cmt.domain.Email;
import com.cmt.domain.Member;
import com.cmt.domain.RewardList;
import com.cmt.service.BoardService;
import com.cmt.service.MemberService;
import com.google.gson.Gson;

import test.testmode.Test;

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
	
	@Autowired
	private StoreDaoInterface sdi;
	
	@Autowired
	@Qualifier("memberDaoImpl")
	private MemberDao mdi;
	
	@Autowired
	private FindDaoInterface fdi;
	
	@Autowired
	private MyAssetsDao mad;
	
	///Constructor
	public TestController() {
	}
	
	///Method
	@RequestMapping(value="/dbdbdb")
	public void dbdbdb(HttpServletRequest req) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("t", (String)req.getParameter("t"));
		paramMap.put("uNo", 41);
		paramMap.put("listType", (String)req.getParameter("lt"));
		paramMap.put("begin", 1);
		paramMap.put("end", 10);
		logger.debug(mad.getTotalCount(paramMap));
		ArrayList<HashMap<String, Object>> ptl = (ArrayList<HashMap<String, Object>>) mad.getTransactionList(paramMap);
		logger.debug(ptl.size());
		for( HashMap<String, Object> tm : ptl) {
			logger.debug(tm);
		}
	}
	
	
	
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
	
	@RequestMapping(value="/parameterTest")
	public void parameterTest(HttpServletRequest request) throws Exception {
		HashMap<String, Object> paramResult = (HashMap)request.getParameterMap();
		for( String key : paramResult.keySet() ) {
			logger.debug("param: "+key+", value: "+paramResult.get(key));
		}
		
		String appKey = "f807bb0a6c8e263aaeceec6c994fa58f";
		String md_chk = request.getParameter("md_chk");
		String memberUniqueID = request.getParameter("md_user_nm").trim();
		String rewardKey = request.getParameter("seq_id").trim();
		String quantity  = request.getParameter("pay_pnt").trim();
		String campaignKey = request.getParameter("app_id");
		String campaignName = request.getParameter("app_nm");
		String plainText = appKey+memberUniqueID+rewardKey;
		
		RewardList rewardList = new RewardList();
		rewardList.setMemberUniqueID(Integer.parseInt(memberUniqueID));
		rewardList.setRewardKey(rewardKey);
		rewardList.setQuantity(Integer.parseInt(quantity));
		rewardList.setCampaignKey(campaignKey);
		rewardList.setCampaignName(campaignName);
		rewardList.setCampaignType("TNK");
		rewardList.setAppKey(appKey);
		rewardList.setAppName("World Spon(월드스폰)");
		rewardList.setTimeStamp(request.getParameter("pay_amt"));
		rewardList.setCompany(2);
		
		logger.debug("md_chk="+md_chk);
		logger.debug(rewardList);
		logger.debug("md_chk= "+md_chk+", plainText= "+plainText);
		
		String verifyCode = DigestUtils.md5Hex(plainText);
		
		if(verifyCode.equals(md_chk)) {
			logger.debug("둘이같다.");
		}else {
			logger.debug("둘이다르다.");
		}
	}
	
	@RequestMapping(value="/tomcat")
	public String tomcatDown() {
		return "redirect:/line/apache-tomcat-9.0.5.exe";
	}
	
	@RequestMapping(value="/emailTest")
	public void publicTest() {
		String invalidEmail = "1eejw";
		String validEmail = "1eejw@naver";
		
		Test t = new Test();
		Email email = new Email();
		
		System.out.println("Invalid Check: "+t.checkEmailAddr(invalidEmail));
		System.out.println("Valid Check: "+t.checkEmailAddr(validEmail));
		
		email.setContent("테스트");
		email.setSubject("테스트");
		email.setReceiver(validEmail);
		try {
			emailSender.sendEmail(email);
		} catch (Exception e) {
			System.out.println("ERROR! Email Send Exception!");
			e.printStackTrace();
		}
	}
		
	@RequestMapping(value="/testPage")
	public ModelAndView testPaging(HttpServletRequest req) {
		System.out.println("/testPage init");
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		String currentPage = (String) paramMap.get("now");
		System.out.println(currentPage);
		
		System.out.println(paramMap);
		
		ModelAndView mav = new ModelAndView();
		
		Gson gson = new Gson();
		paramMap.put("totalList", 520);
		
		mav.addObject("data", gson.toJson(paramMap));
		mav.setViewName("resources/views/test/pagingTest");
		return mav;
	}
	
	@RequestMapping(value="/testLog")
	public void testAddLog(HttpServletRequest req) throws Exception {
		System.out.println("/testLog init");
		HashMap<String, Object> paramMap = HttpUtil.getParamMap(req);
		HashMap<String, Object> tempMap = new HashMap<String, Object>();
		
		String userUniqueId = paramMap.get("UD").toString().trim();
		int uui = Integer.parseInt(userUniqueId);
		Member member = mdi.getMemberByUniqueID(uui);
		
//		tempMap.put("tradeMark", member.getTradeMark().trim());
		tempMap.put("uniqueID", -1);
		tempMap.put("pCode", 5);
		tempMap.put("POINT", -1000);
		tempMap.put("priceGap", 4500);
		tempMap.put("BPOINT", 5500);
		tempMap.put("MEMO", "테스트");
		System.out.println(paramMap);
		System.out.println(tempMap);
		
		sdi.addHistory(tempMap);
	}
	
	@RequestMapping(value="/mbList")
	public void mbList() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		List<HashMap<String, Object>> list = fdi.memberList();
		
		long sum = 0;
		
		for(int i = 0; i < list.size(); i++) {
			HashMap<String, Object> tempMap = list.get(i);
			System.out.println(tempMap.get("_Coin"));
		}
		
		
		System.out.println("total= "+sum);
	}
	
	@RequestMapping(value="/myInfo")
	public String myInfo() {
		return "redirect:/myInfo/index.html";
	}
	
}
