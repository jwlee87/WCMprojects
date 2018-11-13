package com.cmt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
import com.cmt.domain.SystemInfo;
import com.cmt.domain.Tab;
import com.cmt.service.BoardService;
import com.cmt.service.MemberService;

@Controller
public class HomeController {
	
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
	private EmailSender emailSender;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	///Constructor
	public HomeController() {
	}
	
	///Method
	
	// iframe 호출용
	@RequestMapping(value="/iframe")
	public String iframeList(Model model, HttpSession session, HttpServletRequest request) throws Exception {
		if(session.getAttribute("member")!=null) {
//			logger.debug("[HomeController] /board/ session not null");
			Member member = (Member)session.getAttribute("member");
			session.setAttribute("member", member);
		}
		
		int pageNo;
		if(request.getParameter("pageNo") == null) { pageNo=1; }
		else { pageNo = Integer.parseInt(request.getParameter("pageNo")); }
		
		int noticeRows = boardService.getNoticeRows();
		
		Page page = new Page(pageNo, interval, noticeRows, defaultRows);
		
		HashMap<String, Object> result = (HashMap<String, Object>)boardService.getBoardList(page, countTabs);
		
		model.addAttribute("noticeList", result.get("noticeList"));
		model.addAttribute("boardList", result.get("boardList"));
		model.addAttribute("pageResult", result.get("pageResult"));
		return "board/list";
	}
	
	@RequestMapping(value="/board/write")
	public String boardWrite(HttpServletRequest request) throws Exception {
		Member member = (Member)request.getSession().getAttribute("member");
		if(member==null) return "/board/login";
		return "board/write";
	}
	
	@RequestMapping(value="/board/login")
	public void boardLogin() throws Exception {
	}
	
	// frm action URI in board/login.jsp
	@RequestMapping(value="/board/loginAction")
	public String boardLoginAction() throws Exception {
		return "redirect:/";
	}
	
	/// board /index list jsp
	@RequestMapping(value="/board")
	public String boardIndex(Model model, HttpSession session, HttpServletRequest request) throws Exception {
		
		if(session.getAttribute("member")!=null) {
//			logger.debug("[HomeController] /board/ session not null");
			Member member = (Member)session.getAttribute("member");
			session.setAttribute("member", member);
		}
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		int pageNo;
		if(request.getParameter("pageNo") == null) { pageNo=1; }
		else { pageNo = Integer.parseInt(request.getParameter("pageNo")); }
		
		int noticeRows = boardService.getNoticeRows();
		
		Page page = new Page(pageNo, interval, noticeRows, defaultRows);
		
		HashMap<String, Object> result = (HashMap<String, Object>)boardService.getBoardList(page, countTabs);
		
		model.addAttribute("noticeList", result.get("noticeList"));
		model.addAttribute("boardList", result.get("boardList"));
		model.addAttribute("pageResult", result.get("pageResult"));
		
		return "/board/index";
	}
	
	@RequestMapping(value="/board/{boardUniqueID}")
	public String boardDetail(HttpSession session, HttpServletRequest request, @PathVariable int boardUniqueID, Model model) throws Exception{
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		// 로그인 여부 판단후 세션에 로그인 정보 담아주기
		if(session.getAttribute("member")!=null) {
			Member member = (Member)session.getAttribute("member");
			logger.debug("[HomeController] /board/ session not null = "+member);
			session.setAttribute("member", member);
		} else {
			logger.debug("[HomeController] /board/ session null || AccessIP= "+ request.getRemoteAddr()+ " ,requestURI= "+ request.getRequestURL());
		}
		
		//댓글 페이지 설정
		int pageNo;
		int totalComment = boardService.getTotalComment(boardUniqueID);
		
		if(request.getParameter("pageNo") == null) { pageNo=1; }
		else { pageNo = Integer.parseInt(request.getParameter("pageNo")); }
		Page page = new Page(pageNo, commentRows);
//		logger.debug("디벅= "+totalComment+" , "+commentRows);
		
		// 댓글 갯수 0이 아닐때
		if(totalComment != 0) {
			Tab tab = new Tab(pageNo, totalComment, commentRows);
//			logger.debug("탭 디벅= "+tab);
			model.addAttribute("pageResult", tab);
		}
		
		Board board = boardService.getBoard(page, boardUniqueID);
		
		// 게시글 내용 게행 되게 변경
		String texts = board.getContents();
		texts = texts.replaceAll(System.getProperty("line.separator"), "<br>");
		board.setContents(texts);
		
//		logger.debug(" reply count: "+board.getReplyCount());
		
		model.addAttribute("board", board);
		
		return "board/read";
	}
	
	@RequestMapping(value="/board/update/{bID}")
	public String boardUpdate(HttpServletRequest request, @PathVariable int bID, Model model) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		//댓글 페이지 설정
		int pageNo;
		if(request.getParameter("pageNo") == null) { pageNo=1; }
		else { pageNo = Integer.parseInt(request.getParameter("pageNo")); }
		Page page = new Page(pageNo, commentRows);
		
		Board board = boardService.getBoard(page, bID);
		model.addAttribute("board", board);
		return "board/update";
	}
	
	// frm action URI in board/write.jsp
	// @RequestParam("uploadFile") MultipartFile uploadFile
	@RequestMapping(value="/board/writeAction", method=RequestMethod.POST)
	public String boardWriteAction(HttpServletRequest request, MultipartRequest mRequest, @ModelAttribute Board board) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		Member member = (Member)request.getSession().getAttribute("member");
//		logger.debug(member);
		if(member == null) {
			return "redirect:/board/login";
		}
		
		boardService.addBoard(board);
		
		List<MultipartFile> fileList = mRequest.getFiles("uploadFile"); 
		
		for(MultipartFile uploadFile : fileList) {
			
			ArrayList<String> fileNames = new ArrayList<String>();
			fileNames.add(uploadFile.getOriginalFilename()); 
			
			for(String fileName: fileNames) {
			
				if(fileName != null && fileName != "") {
					logger.debug("[HomeController] uploadFile : " + uploadFile);
					UtilFile utilFile = new UtilFile();
//					파일 업로드 결과값을 path로 받아온다
					HashMap<String, Object> hm = utilFile.fileUpload(request, uploadFile, board);
//					해당 경로만 받아 db에 저장
					AttachFile af = new AttachFile();
					af.setBoardUniqueID(board.getBoardUniqueID());
					af.setFileName((String)hm.get("fileName"));
					af.setFilePath((String)hm.get("filePath"));
					hm.put("attachFile", af);
					boardService.addAttachFile(hm);
				}
			}
		}
		
		return "redirect:/board";
	}
	
	// frm action URI in board/update.jsp
	@RequestMapping(value="/board/updateAction", method=RequestMethod.POST)
	public String boardUpdateAction(HttpSession session, HttpServletRequest request, MultipartRequest mRequest, @ModelAttribute Board board) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
//		logger.debug("[HomeController] /board/updateAction :: Board="+board);
		Member member = (Member)session.getAttribute("member");
//		logger.debug(member);
		if(member == null) {
			return "redirect:/board/login";
		}
		
		boardService.updateBoard(board);
		
		List<MultipartFile> fileList = mRequest.getFiles("uploadFile"); 
		for(MultipartFile uploadFile : fileList) {
			
			ArrayList<String> fileNames = new ArrayList<String>();
			fileNames.add(uploadFile.getOriginalFilename()); 
			
			for(String fileName: fileNames) {
			
				if(fileName != null && fileName != "") {
//					logger.debug("[HomeController] uploadFile : " + uploadFile);
					UtilFile utilFile = new UtilFile();
//					파일 업로드 결과값을 path로 받아온다
					HashMap<String, Object> hm = utilFile.fileUpload(request, uploadFile, board);
//					해당 경로만 받아 db에 저장
					AttachFile af = new AttachFile();
					af.setBoardUniqueID(board.getBoardUniqueID());
					af.setFileName((String)hm.get("fileName"));
					af.setFilePath((String)hm.get("filePath"));
					hm.put("attachFile", af);
					boardService.addAttachFile(hm);
				}else {
					logger.debug("변경없음");
				}
			}
		}
		return "redirect:/board";
	}
	
	// Form action URI in read.jsp
	@RequestMapping(value="/board/cmtAction", method=RequestMethod.POST)
	public String cmtAction(HttpServletRequest request, @ModelAttribute Comment comment) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		Member member = (Member)request.getSession().getAttribute("member");
//		logger.debug(member);
		if(member == null) {
			return "redirect:/board/login";
		}
		
//		logger.debug(comment);
		boardService.addComment(comment);
		return "redirect:/board/"+comment.getBoardUniqueID();
	}
	
	// ajax in board/list.jsp Line 117 function logout()
	@RequestMapping(value="/board/logout")
	public @ResponseBody void logout(HttpSession session) throws Exception {
		session.invalidate();
	}
	
	// ajax in board/list.jsp
	@RequestMapping(value="/board/loginChk")
	public @ResponseBody Map<String, Object> boardLoginChk(HttpSession session, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(session.getAttribute("member")==null) {
//			logger.debug("session member null");
			resultMap.put("check", "false");
			
		}else if(session.getAttribute("member")!=null){
//			logger.debug("session member not null");
			resultMap.put("check", "true");
			
		}
		return resultMap;
	}
	
	// ajax in board/login.jsp ->  controller /loginAction
	@RequestMapping(value="/board/idChk")
	public @ResponseBody Map<String, Object> boardIdChk(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String iTradeMark = (String)paramMap.get("tradeMark");
		String iPassword = (String)paramMap.get("password");
		
		HashMap<String, Object> sMap = memberService.getMemberByTM(iTradeMark, iPassword);
		String key = (String)sMap.get("check");
		
		if(key.equals("noTM")) {
			resultMap.put("check", "noTM");
			
		}else if(key.equals("ok")) {
			Member member = (Member)sMap.get("member");
			session.setAttribute("member", member);
			resultMap.put("check", "ok");
			
		}else if(key.equals("noPW")) {
			resultMap.put("check", "noPW");
			
		}else {
			resultMap.put("check", "error");
		}
		
		return resultMap;
	}
	
	// ajax in board/read.jsp
	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> boardDelete(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		int boardUniqueID = Integer.parseInt((String)paramMap.get("bID"));
		
		int totalComment = boardService.getTotalComment(boardUniqueID);
		if(totalComment != 0) {
			System.out.println("0이아님");
			resultMap.put("check", "comment");
		}else {
			System.out.println("0");
			boardService.deleteBoard(boardUniqueID);
		}
		
		return resultMap;
	}
	
	// ajax in board/update.js
	@RequestMapping(value="/board/deleteAttachFile", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteAttachFile(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int fileUniqueID = Integer.parseInt((String)paramMap.get("fID"));
		int boardUniqueID = Integer.parseInt((String)paramMap.get("bID"));
		
		List<AttachFile> afl = boardService.getAttachFile(boardUniqueID);
		
		UtilFile utilFile = new UtilFile();
		String rv = utilFile.deleteFile(afl);
		String cv = "false";
		if(rv.equals("success")) {
			cv = boardService.deleteBoardAttachFile(fileUniqueID);
		} else if (rv.equals("fail")) {
		} else if (rv.equals("null")) {
		}
		
//		logger.debug(cv);
		
		if(cv.equals("ok")) {
			resultMap.put("check", "ok");
		}else{
			resultMap.put("check", "false");
		}
		return resultMap;
	}
	
	// ajax in board/read.jsp read.js
	@RequestMapping(value="/board/deleteCmt", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteCmt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int commentUniqueID = Integer.parseInt((String)paramMap.get("cID"));
		int rv = boardService.deleteComment(commentUniqueID);
		if(rv == 0) {
			logger.debug("대상이 존재하지 않습니다.");
			resultMap.put("check", "false");
		} else {
			logger.debug("댓글 삭제 완료");
			resultMap.put("check", "true");
		}
		
		return resultMap;
	}
	
	
	
	/////////////////////////////////////////////////////////
	///////////////////// AD CONTROLLER /////////////////////
	/////////////////////////////////////////////////////////
	@RequestMapping(value="/bann")
	public String goAd(HttpSession session, HttpServletRequest request, Model model) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		Member member = (Member)session.getAttribute("member");
		
		int pageNo;
		
		if(request.getParameter("pageNo") == null) { pageNo=1; }
		else { pageNo = Integer.parseInt(request.getParameter("pageNo")); }
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Page page = new Page(pageNo, defaultRows);
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uniqueID", member.getUniqueID());
		paramMap.put("page", page);
		
		resultMap = boardService.getADReqList(paramMap, countTabs);
		
		model.addAttribute("adList", resultMap.get("req"));
		model.addAttribute("pageResult", resultMap.get("pageResult"));
		return "bann/index";
	}
	
	@RequestMapping(value="/bann/adReq")
	public void goADReq() throws Exception {
	}
	
	@RequestMapping(value="/adReqAction", method=RequestMethod.POST)
	public String reqAction(HttpServletRequest request, MultipartRequest mRequest, @ModelAttribute ADRequest adr) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		Member member = (Member)request.getSession().getAttribute("member");
//		logger.debug(member);
		if(member == null) {
			return "redirect:/board/login";
		}
		
//		logger.debug("파일 경로 저장전 디버깅= "+adr);
		
		List<MultipartFile> fileList = mRequest.getFiles("uploadFile"); 
		
		for(MultipartFile uploadFile : fileList) {
			
			ArrayList<String> fileNames = new ArrayList<String>();
			fileNames.add(uploadFile.getOriginalFilename()); 
			
			for(String fileName: fileNames) {
			
				if(fileName != null && fileName != "") {
//					logger.debug("[HomeController] uploadFile : " + uploadFile);
					UtilFile utilFile = new UtilFile();
//					파일 업로드 결과값을 path로 받아온다
					HashMap<String, Object> hm = utilFile.fileUpload(request, uploadFile, adr);
//					해당 경로만 받아 db에 저장
					
					adr.setFileName((String)hm.get("fileName"));
					adr.setFilePath((String)hm.get("filePath"));
//					logger.debug("파일 경로 저장 후 디버깅= "+adr);
				}
			}
		}
		
		boardService.addADRequest(adr);
		
		return "redirect:/bann";
	}
	
	@RequestMapping(value="/bann/delete/{memberUniqueID}/{adUniqueID}", method=RequestMethod.POST)
	public void deleteADReq(@PathVariable int memberUniqueID, @PathVariable int adUniqueID, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
//		logger.debug(memberUniqueID+", "+adUniqueID);
		ADRequest adr = boardService.getADReqBan(adUniqueID);
//		logger.debug("@@@"+adr);
		
		UtilFile uf = new UtilFile();
		uf.deleteADReq(adr);
		
		boardService.deleteADReq(adr);
	}
	
	
	////////////////////////////
	////	한줄 광고 신청		////
	////////////////////////////
	@RequestMapping(value="/line", method=RequestMethod.GET)
	public String lindAD(Model model, HttpSession session, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		Member member = (Member)session.getAttribute("member");
		int pageNo;
		
		if(request.getParameter("pageNo") == null) { pageNo=1; }
		else { pageNo = Integer.parseInt(request.getParameter("pageNo")); }
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Page page = new Page(pageNo, defaultRows);
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("uniqueID", member.getUniqueID());
		paramMap.put("page", page);
		
		resultMap = boardService.getLineList(paramMap, countTabs);
		
		model.addAttribute("lineList", resultMap.get("req"));
		model.addAttribute("pageResult", resultMap.get("pageResult"));
		return "line/index";
	}
	
	@RequestMapping(value="/line/add", method=RequestMethod.GET)
	public String lineAdd(Model model, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		SystemInfo si = boardService.getSystemInfo();
		model.addAttribute("onedayPirce", si.getPromotionOnedayPay());
		return "line/add";
	}
	
	@RequestMapping(value="/line/addAction", method=RequestMethod.POST)
	public String lineAddAction(@ModelAttribute Line line, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
//		logger.debug("add Line :: "+line);
		
		boardService.addLine(line);
		return "redirect:/line";
	}
	
	@RequestMapping(value="/line/auth", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> authCheck(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int memberUniqueID = Integer.parseInt((String)paramMap.get("userUniqueID"));
		Promotion pm = boardService.getPromotion(memberUniqueID);
		if(pm != null) {
			if(pm.getPromotionLevel() >= promotionLevel) {
				resultMap.put("check", "ok");
			}else {
				resultMap.put("check", "short");
			}
		}else {
			resultMap.put("check", "not");
		}
		return resultMap;
	}
	
	@RequestMapping(value="/line/delete/{uniqueID}", method=RequestMethod.POST)
	public void deleteLine(@PathVariable int uniqueID, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
//		logger.debug(uniqueID);
		boardService.deleteLine(uniqueID);
	}
	
	
	
	//////////////////////////////////////////////////////////////////
	/////////////	비	밀	번	호	찾	기	//////////////////////////
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value="/find", method=RequestMethod.GET)
	public String goFindPw(HttpServletRequest request) throws Exception {
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		return "account/find";
	}
	
	@RequestMapping(value="/change/{userUniqueID}/{authkey}", method=RequestMethod.GET)
	public String goPwChange(@PathVariable int userUniqueID, @PathVariable int authkey, Model model, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		Email emailCheck = memberService.getMailCheck(userUniqueID);
		if(emailCheck.getAuthKey() == authkey) {
			
			if(authkey == 0) {
				resultMap.put("check",false);
			} else {
				try {
					memberService.updateAuthKey(userUniqueID);
				} catch(Exception e) {
					resultMap.put("check", false);
					e.printStackTrace();
				}
				resultMap.put("check", true);
				resultMap.put("userUniqueID", userUniqueID);
			}
		} else {
			resultMap.put("check", false);
		}
		model.addAttribute("resultMap", resultMap);
		return "account/change";
	}
	
	@RequestMapping(value="/changeAction/{userUniqueID}/{pass}", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeAction(@PathVariable int userUniqueID, @PathVariable String pass, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userUniqueID", userUniqueID);
		paramMap.put("pass", pass);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int rv = memberService.updatePass(paramMap);
//		logger.debug(rv);
		if(rv != 0) {
			resultMap.put("key", "true");
		}else {
			resultMap.put("key", "false");
		}
		return resultMap;
	}
	
	/*ajax로 입력한 닉네임을 받아온다.*/
	@RequestMapping(value="/find/pw", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> sendMain(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// phone 이지만 메일주소가 넘어옴
		Member member = memberService.getMemberByNick((String)paramMap.get("nickName"));
//		logger.debug(member);
		
		if (member == null) {
//			logger.debug("member null 일 경우");
			resultMap.put("check", "null");
		} else {
			
			if(member.geteMail() == null || member.geteMail().equals("") || member.geteMail().equals(" ")) {
				resultMap.put("check", "emailNull");
			} else {
				
				int authKey = emailSender.generateAuthKey();
				try {
					
					if(emailSender.checkEmailAddr(member.geteMail())) {
						int userUniqueID = member.getUniqueID();
						memberService.deleteCheck(userUniqueID);
						String uri = "http://worldspon.net/change/"+userUniqueID+"/"+authKey;
						email.setAuthKey(authKey);
						email.setContent(emailSender.generateEmailContents(member.getTradeMark(), uri));
						email.setSubject("[월드스폰] "+member.getTradeMark()+"님의 요청 결과입니다.");
						email.setReceiver(member.geteMail());
						email.setUserUniqueID(member.getUniqueID());
						emailSender.sendEmail(email);
						memberService.addAuthKey(email);
						resultMap.put("mail", member.geteMail());
						resultMap.put("check", "validEmail");
					} else {
						resultMap.put("mail", member.geteMail());
						resultMap.put("check", "invalidEmail");
					}
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
//		System.out.println("final check: "+resultMap);
		
		return resultMap;
	}
	@RequestMapping(value="/msg", method=RequestMethod.GET)
	public String goMsg(HttpServletRequest request) throws Exception {
		logger.debug(request.getRemoteAddr()+" : "+request.getRequestURL());
		return "account/msg";
	}
}
