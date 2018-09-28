package com.cmt.service.impl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cmt.common.TimeCompare;
import com.cmt.dao.BoardDao;
import com.cmt.domain.ADRequest;
import com.cmt.domain.AttachFile;
import com.cmt.domain.Board;
import com.cmt.domain.Comment;
import com.cmt.domain.Line;
import com.cmt.domain.Page;
import com.cmt.domain.Promotion;
import com.cmt.domain.SystemInfo;
import com.cmt.domain.Tab;
import com.cmt.service.BoardService;

@Service("boardServiceImpl")
public class BoardServiceImpl implements BoardService {

	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	private TimeCompare tc;
	
	@Autowired
	@Qualifier("boardDaoImpl")
	private BoardDao boardDao;
	
	///Constructor
	public BoardServiceImpl() {
	}
	
	///Method
	@Override
	public void addBoard(Board board) throws Exception {
		boardDao.addBoard(board);
	}
	
	@Override
	public Map<String, Object> getBoardList(Page page, int countTabs) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Board> bl = boardDao.getBoardList(page);
		List<Board> nl = boardDao.getNoticeList(page);
		
		tc.listLoop(bl, page);
		tc.listLoop(nl, page);
		
		//첨부파일 여부 확인
		for(Board b: bl) {
			List<AttachFile> afl = boardDao.getAttachFile(b.getBoardUniqueID());
			b.setReplyCount(boardDao.getTotalComment(b.getBoardUniqueID()));
			
			if(afl.size() != 0) {
				b.setAttachFileList(afl);
			}else {
				b.setAttachFileList(null);
			}
		}
		
		for(Board b: nl) {
			List<AttachFile> afl = boardDao.getAttachFile(b.getBoardUniqueID());
			b.setReplyCount(boardDao.getTotalComment(b.getBoardUniqueID()));
			
			if(afl.size() != 0) {
				b.setAttachFileList(afl);
			}else {
				b.setAttachFileList(null);
			}
		}
		
		int currentTab = page.getCurrentPageNo();
		int totalCount = boardDao.getBoardCount();
		
		Tab t = new Tab(currentTab, totalCount, countTabs);
		
		resultMap.put("boardList", bl);
		resultMap.put("noticeList", nl);
		resultMap.put("pageResult", t);
		
		return resultMap;
	}

	@Override
	public Board getBoard(Page page, int boardUniqueID) throws Exception {
		
		Board b = boardDao.getBoard(boardUniqueID);

//		logger.debug(b);
		
		//조회수 업데이트
		int viewCount = b.getViewCount();
		
		logger.debug(viewCount);
		
		if(viewCount==0) {
			viewCount = 1;
		}else {
			viewCount = viewCount+1;
		}
		logger.debug(viewCount);
		b.setViewCount(viewCount);

		// 조회수 업데이트 쿼리
		boardDao.updateBoardViewCount(b);
		
		//첨부파일 여부 확인
		List<AttachFile> afl = boardDao.getAttachFile(b.getBoardUniqueID());
//		logger.debug(" 첨부파일 리스트 사이즈= "+afl.size());
		if(afl.size() != 0) {
//			logger.debug(" 첨부파일 존재 ");
			b.setAttachFileList(afl);
		}else {
//			logger.debug(" 첨부파일 없음 ");
			b.setAttachFileList(null);
		}
		
		//댓글 여부 확인
		int replyCount = boardDao.getTotalComment(boardUniqueID);
		b.setReplyCount(replyCount);
		
		if(replyCount != 0) {
			HashMap<String, Object> hm = new HashMap<String, Object>();
			hm.put("board", b);
			hm.put("page", page);
			
			List<Comment> cl = boardDao.getCommentList(hm);
			for(Comment c: cl) {
				String texts = c.getComment();
				texts = texts.replaceAll(System.getProperty("line.separator"), "<br>");
				c.setComment(texts);
				SimpleDateFormat df = new SimpleDateFormat("yyyy.MM.dd HH:mm");
				c.setDateFormat(df.format(c.getWriteDate()));
			}
			b.setCommentList(cl);
			
		}
		
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd / HH:mm");
		b.setDateFormat(df.format(b.getWriteDate()));
		return b;
	}

	@Override
	public String deleteBoard(int boardUniqueID) throws Exception {
		String returnValue = "false";
		int rv1 = boardDao.deleteBoard(boardUniqueID);
		int rv2 = boardDao.deleteAttachFile(boardUniqueID);
		String rsv = String.valueOf(rv1+rv2);
		if(rv1 == 0) {
			returnValue = "board delete error";
			if(rv2 == 0) returnValue += ", attach delete error";
		}
		
		if(rsv.trim().equals("2")) returnValue = "ok";
		
//		logger.debug(returnValue);
		
		return returnValue;
	}

	@Override
	public void updateBoard(Board board) throws Exception {
		boardDao.updateBoard(board);
	}

	@Override
	public int addAttachFile(HashMap<String, Object> hm) throws Exception {
		return boardDao.addAttachFile(hm);
	}

	@Override
	public int getNoticeRows() throws Exception {
		return boardDao.getNoticeRows();
	}

	@Override
	public void updateAttachFile(HashMap<String, Object> hm) throws Exception {
		boardDao.updateAttachFile(hm);
	}

	@Override
	public String deleteBoardAttachFile(int fileUniqueID) throws Exception {
		int rv = boardDao.deleteBoardAttachFile(fileUniqueID);
		if(rv == 1) {
			return "ok";
		} else {
			return "false";
		}
	}

	@Override
	public void addComment(Comment comment) throws Exception {
		boardDao.addComment(comment);
	}

	@Override
	public int getTotalComment(int boardUniqueID) throws Exception {
		return boardDao.getTotalComment(boardUniqueID);
	}

	@Override
	public List<AttachFile> getAttachFile(int boardUniqueID) throws Exception {
		return boardDao.getAttachFile(boardUniqueID);
	}

	@Override
	public int deleteComment(int commentUniqueID) throws Exception {
		return boardDao.deleteComment(commentUniqueID);
	}

	@Override
	public void addADRequest(ADRequest adr) throws Exception {
		boardDao.addADRequest(adr);
	}

	@Override
	public Map<String, Object> getADReqList(HashMap<String, Object> paramMap, int countTabs) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		Page page = (Page)paramMap.get("page");
		int uniqueID = (Integer)paramMap.get("uniqueID");
		
		Tab t = new Tab(page.getCurrentPageNo(), boardDao.getADReqTotalCount(uniqueID), countTabs);
		
		List<ADRequest> l = boardDao.getADReqList(paramMap);
		
		resultMap.put("req", boardDao.getADReqList(paramMap));
		resultMap.put("pageResult", t);
		return resultMap;
	}

	@Override
	public void deleteADReq(ADRequest adr) throws Exception {
		boardDao.deleteADReq(adr);
	}

	@Override
	public ADRequest getADReqBan(int adUniqueID) throws Exception {
		return boardDao.getADReqBann(adUniqueID);
	}

	@Override
	public SystemInfo getSystemInfo() throws Exception {
		return boardDao.getSystemInfo();
	}

	@Override
	public void addLine(Line line) throws Exception {
		boardDao.addLine(line);
	}

	@Override
	public Map<String, Object> getLineList(HashMap<String, Object> paramMap, int countTabs) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Page page = (Page)paramMap.get("page");
		int uniqueID = (Integer)paramMap.get("uniqueID");
		
		logger.debug(page);
		logger.debug(uniqueID);
		
		Tab t = new Tab(page.getCurrentPageNo(), boardDao.getLineTotalCount(uniqueID), countTabs);
		List<Line> l = boardDao.getLineList(paramMap);
		
		logger.debug(l);
		
		resultMap.put("req", l);
		resultMap.put("pageResult", t);
		return resultMap;
	}

	@Override
	public Promotion getPromotion(int memberUniqueID) throws Exception {
		return boardDao.getPromotion(memberUniqueID);
	}

	@Override
	public void deleteLine(int uniqueID) throws Exception {
		boardDao.deleteLine(uniqueID);
	}

	
	
	
	
	
	
	//////////
	// TEST //
	//////////
	@Override
	public Board getBoardTest(int boardUniqueID) throws Exception {
		return boardDao.getBoardTest(boardUniqueID);
	}

}
