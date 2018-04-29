package com.cmt.dao;

import java.util.HashMap;
import java.util.List;

import com.cmt.domain.ADRequest;
import com.cmt.domain.AttachFile;
import com.cmt.domain.Board;
import com.cmt.domain.Comment;
import com.cmt.domain.Line;
import com.cmt.domain.Page;
import com.cmt.domain.Promotion;
import com.cmt.domain.SystemInfo;

public interface BoardDao {
	public void addBoard(Board board) throws Exception;
	public List<Board> getBoardList(Page page) throws Exception;
	public int getBoardCount() throws Exception;
	public Board getBoard(int boardUniqueID) throws Exception;
	public int deleteBoard(int boardUniqueID) throws Exception;
	public int deleteAttachFile(int boardUniqueID) throws Exception;
	public void updateBoard(Board board) throws Exception;
	public void updateBoardViewCount(Board b) throws Exception;
	public int addAttachFile(HashMap<String, Object> hm) throws Exception;
	public int getNoticeRows() throws Exception;
	public List<Board> getNoticeList(Page page) throws Exception;
	public List<AttachFile> getAttachFile(int boardUniqueID) throws Exception;
	public void updateAttachFile(HashMap<String, Object> hm) throws Exception;
	public int deleteBoardAttachFile(int fileUniqueID) throws Exception;
	public void addComment(Comment comment) throws Exception;
	public List<Comment> getCommentList(HashMap<String, Object> hm) throws Exception;
	public int getTotalComment(int boardUniqueID) throws Exception;
	public int deleteComment(int commentUniqueID) throws Exception;
	public void addADRequest(ADRequest adr) throws Exception;
	public List<ADRequest> getADReqList(HashMap<String, Object> paramMap) throws Exception;
	public int getADReqTotalCount(int uniqueID) throws Exception;
	public void deleteADReq(ADRequest adr) throws Exception;
	public ADRequest getADReqBann(int adUniqueID) throws Exception;
	public SystemInfo getSystemInfo() throws Exception;
	public void addLine(Line line) throws Exception;
	public List<Line> getLineList(HashMap<String, Object> paramMap) throws Exception;
	public int getLineTotalCount(int uniqueID) throws Exception;
	public Promotion getPromotion(int memberUniqueID) throws Exception;
	public void deleteLine(int uniqueID) throws Exception;
}
