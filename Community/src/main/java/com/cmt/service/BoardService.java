package com.cmt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cmt.domain.ADRequest;
import com.cmt.domain.AttachFile;
import com.cmt.domain.Board;
import com.cmt.domain.Comment;
import com.cmt.domain.Line;
import com.cmt.domain.Page;
import com.cmt.domain.Promotion;
import com.cmt.domain.SystemInfo;

public interface BoardService {
	public void addBoard(Board board) throws Exception;
	public Map<String, Object> getBoardList(Page page, int countTabs) throws Exception;
	public Board getBoard(Page page, int boardUniqueID) throws Exception;
	public String deleteBoard(int boardUniqueID) throws Exception;
	public void updateBoard(Board board) throws Exception;
	public int addAttachFile(HashMap<String, Object> hm) throws Exception;
	public int getNoticeRows() throws Exception;
	public void updateAttachFile(HashMap<String, Object> hm) throws Exception;
	public String deleteBoardAttachFile(int fileUniqueID) throws Exception;
	public void addComment(Comment comment) throws Exception;
	public int getTotalComment(int boardUniqueID) throws Exception;
	public List<AttachFile> getAttachFile(int boardUniqueID) throws Exception;
	public int deleteComment(int commentUniqueID) throws Exception;
	public void addADRequest(ADRequest adr) throws Exception;
	public Map<String, Object> getADReqList(HashMap<String, Object> paramMap, int countTabs) throws Exception;
	public void deleteADReq(ADRequest adr) throws Exception;
	public ADRequest getADReqBan(int adUniqueID) throws Exception;
	public SystemInfo getSystemInfo() throws Exception;
	public void addLine(Line line) throws Exception;
	public Map<String, Object> getLineList(HashMap<String, Object> paramMap, int countTabs) throws Exception;
	public Promotion getPromotion(int memberUniqueID) throws Exception;
	public void deleteLine(int uniqueID) throws Exception;
	
	
	public Board getBoardTest(int boardUniqueID) throws Exception;
}
