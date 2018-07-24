package com.cmt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cmt.common.EmailSender;
import com.cmt.common.HashUtil;
import com.cmt.domain.Email;
import com.cmt.domain.RewardList;
import com.cmt.domain.Member;
import com.cmt.domain.ServerList;
import com.cmt.service.BoardService;
import com.cmt.service.MemberService;

@Controller
public class RewardController {
	
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
	private HashUtil hashUtil;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	///Constructor
	public RewardController() {
	}
	
	///Method
	
	////////////////////////////////////////////
	///// IGAWORKS ADPOPCORN CALL BACK URL /////
	////////////////////////////////////////////
	@RequestMapping(value="/reward", method=RequestMethod.POST)
	public void receiveParam(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		// signed_value : 리워드 요청 보안 체크 값
		String signed_value = request.getParameter("signed_value");
		//usn 리워드를 지급할 유저 ID
		String usn = request.getParameter("usn");
		// reward_key : 리워드 요청에 대한 transaction_id(각 리워드 요청당 unique)
		String reward_key = request.getParameter("reward_key");
		// quantity : 리워드 지급량
		String quantity = request.getParameter("quantity");
		// campaign_key : 참여 완료한 캠페인 키
		String campaign_key = request.getParameter("campaign_key");
		// campaign_name : 유저가 참여 완료한 캠페인의 이름
		
		String campaign_name = request.getParameter("campaign_name");
		campaign_name = campaign_name == null ? "" : campaign_name; 
		//campaign_type : 유저가 참여 완료한 캠페인의 타입
		String campaign_type = request.getParameter("campaign_type");
		campaign_type = campaign_type == null ? "" : campaign_type; 
		// app_key : IGAWorks 앱 키
		String app_key = request.getParameter("app_key");
		app_key = app_key == null ? "" : app_key; 
		// app_name : IGAWorks 앱 이름
		String app_name = request.getParameter("app_name");
		app_name = app_name == null ? "" : app_name; 
		// time_stamp : 캠페인 참여 완료 시각
		String time_stamp = request.getParameter("time_stamp");
		time_stamp = time_stamp == null ? "" : time_stamp; 
		// adid : 유저가 참여 완료한 디바이스의 구글 광고 아이디
		String adid = request.getParameter("adid");
		adid = adid == null ? "" : adid; 
		
		String plainText = usn + reward_key + quantity +  campaign_key;
		
		
		System.out.println("signed_value= "+signed_value);
		System.out.println("usn= "+usn);
		System.out.println("reward_key= "+reward_key);
		System.out.println("quantity= "+quantity);
		System.out.println("campaign_key= "+campaign_key);
		System.out.println("campaign_name= "+campaign_name);
		System.out.println("campaign_type= "+campaign_type);
		System.out.println("app_key= "+app_key);
		System.out.println("app_name= "+app_name);
		System.out.println("time_stamp= "+time_stamp);
		System.out.println("adid= "+adid);
		
		int userUniqueID = Integer.parseInt(usn.trim());
		
		RewardList rewardList = new RewardList();
		rewardList.setAdid(adid);
		rewardList.setAppKey(app_key);
		rewardList.setAppName(app_name);
		rewardList.setCampaignKey(campaign_key);
		rewardList.setCampaignName(campaign_name);
		rewardList.setCampaignType(campaign_type);
		rewardList.setMemberUniqueID(userUniqueID);
		rewardList.setQuantity(Integer.parseInt(quantity));
		rewardList.setRewardKey(reward_key);
		rewardList.setTimeStamp(time_stamp);
		rewardList.setCompany(1);
		
		logger.debug("AD POPCORN REWARD DOMAIN = "+rewardList.toString());
		
		Member member = memberService.getMemberByUniqueID(userUniqueID);
		ServerList serverURL = memberService.getServerList();
		String serverIP = serverURL.getAddress();
		
		logger.debug("=========================================================");
		logger.debug("  ip addr  "+serverIP.trim());
		logger.debug("=========================================================");
		
		String json = hashUtil.returnCheck(signed_value, plainText, usn, reward_key, member, memberService, rewardList, serverIP);
		
		logger.debug("JSON return Value = "+json);
		
		response.setHeader("Content-Type", "text/html");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
		
	}
	
	////////////////////////////////////////////
	///// APPPANG ADPOPCORN CALL BACK URL //////
	////////////////////////////////////////////
	// 보상형
	@RequestMapping(value="/appang")
	public void appangCallback(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		String testIP = "127.0.0.1";
		String nasIP = "222.122.49.171";
		String sentAddr = request.getRemoteAddr().trim();
		logger.debug("보내는곳: "+sentAddr);

		if(sentAddr.equals(testIP) || sentAddr.equals(nasIP)) {
//		if(sentAddr.equals(nasIP)) {
			// [SEQ_ID] 적립 고유아이디 (적립금 중복지급을 방지를 위해 사용)	- rewardKey
			String s	= request.getParameter("s");
			// [USER_DATA]										- memberUniqueID
			String ud	= request.getParameter("ud");
			// [PRICE] : 광고 단가 (매체 수익금)
//			String p	= request.getParameter("p");
			// [REWARD] : 리워드 금액 (오퍼월에서 참여한 경우에만 값이 있음)	- quantity
			String r	= request.getParameter("r");
			// [AI_ID] : 광고 ID									- campaignKey
			String ai	= request.getParameter("ai");
			// [AD_KEY] : 32자리 광고 KEY							- timestamp
			String ak	= request.getParameter("ak");
			// [AD_NAME] : 광고명									- campaignName
			String n	= request.getParameter("n");
			// [AD_TYPE] : 광고구분 (CPI, CPE, CPA, CPC)			- campaignType
			String t	= request.getParameter("t");			
			// [USER_ADID] : 사용자 기기 36자리 광고 ID				- adid
			String adid	= request.getParameter("adid");
			// [USER_IP] : 사용자 IP주소
//			String ip	= request.getParameter("ip");
			String appKey = "78fc99a71bcbdca32d569265c91c9b24";
			String appName = "월드스폰 - 구글플레이";
			int userUniqueID = Integer.parseInt(ud.trim());
			
			
			RewardList rewardList = new RewardList();
			rewardList.setMemberUniqueID(userUniqueID);
			rewardList.setRewardKey(s.trim());
			rewardList.setQuantity(Integer.parseInt(r));
			rewardList.setCampaignKey(ai);
			rewardList.setCampaignName(n);
			rewardList.setCampaignType(t);
			rewardList.setAppKey(appKey);
			rewardList.setAppName(appName);
			rewardList.setAdid(adid);
			rewardList.setTimeStamp(ak);
			rewardList.setCompany(3);
			
			logger.debug("APPANG REWARD DOMAIN = "+rewardList.toString());
			
			Member member = memberService.getMemberByUniqueID(userUniqueID);
			ServerList serverURL = memberService.getServerList();
			String serverIP = serverURL.getAddress();
			
			logger.debug("=========================================================");
			logger.debug("  ip addr  "+serverIP.trim());
			logger.debug("=========================================================");
			
			String returnValue = hashUtil.returnCheckForAppang( ud.trim(), s.trim(), ai.trim(), member, memberService, rewardList, serverIP);
			logger.debug(returnValue);
			
		} else {
			logger.debug("!!! WRONG ACCEESS !!!");
		}
		
		response.setStatus(200);
	}
	
	////////////////////////////////////////////
	///// TNK CALL BACK URL /////
	////////////////////////////////////////////
	@RequestMapping(value="/tnkCallBack", method=RequestMethod.POST)
	public void tnkCallBack(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
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
		logger.debug("TNK REWARD DOMAIN = "+rewardList.toString());
		
		String verifyCode = DigestUtils.md5Hex(plainText);
		
		int userUniqueID = Integer.parseInt(memberUniqueID);
		Member member = memberService.getMemberByUniqueID(userUniqueID);
		ServerList serverURL = memberService.getServerList();
		String serverIP = serverURL.getAddress();
		
		logger.debug("=========================================================");
		logger.debug("  ip addr  "+serverIP.trim());
		logger.debug("=========================================================");
		// 지급절차로직 진행
		if (verifyCode.equals(md_chk)) {
			String returnCode = hashUtil.tnkLogic( memberUniqueID, rewardKey, member, memberService, rewardList, serverIP);
			logger.debug("returnCode = "+returnCode);
		} else {
			logger.debug(" 지급절차 중지 - 비정상적인 접근 - 사용자: "+request.getRemoteAddr());
		}
		
		response.setStatus(200);
	
	}
	
}
