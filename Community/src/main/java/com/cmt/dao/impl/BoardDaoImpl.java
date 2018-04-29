package com.cmt.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.dao.BoardDao;
import com.cmt.domain.ADRequest;
import com.cmt.domain.AttachFile;
import com.cmt.domain.Board;
import com.cmt.domain.Comment;
import com.cmt.domain.Line;
import com.cmt.domain.Page;
import com.cmt.domain.Promotion;
import com.cmt.domain.SystemInfo;

@Repository("boardDaoImpl")
public class BoardDaoImpl implements BoardDao {

	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	///Constructor
	public BoardDaoImpl() {
	}
	
	///Method
	@Override
	public void addBoard(Board board) throws Exception {
		sqlSession.insert("BoardMapper.addBoard", board);
	}
	@Override
	public List<Board> getBoardList(Page page) throws Exception {
		return sqlSession.selectList("BoardMapper.selectBoardList", page);
	}

	@Override
	public int getBoardCount() throws Exception {
		return sqlSession.selectOne("BoardMapper.selectBoardCount");
	}

	@Override
	public Board getBoard(int boardUniqueID) throws Exception {
		return sqlSession.selectOne("BoardMapper.selectBoard", boardUniqueID);
	}

	@Override
	public int deleteBoard(int boardUniqueID) throws Exception {
		return sqlSession.delete("BoardMapper.deleteBoard", boardUniqueID);
	}

	@Override
	public void updateBoard(Board board) throws Exception {
		sqlSession.update("BoardMapper.updateBoard", board);
	}

	@Override
	public void updateBoardViewCount(Board b) throws Exception {
		sqlSession.update("BoardMapper.updateBoardViewCount", b);
	}

	@Override
	public int addAttachFile(HashMap<String, Object> hm) throws Exception {
		return sqlSession.insert("BoardMapper.addAttachFile", hm);
	}

	@Override
	public int deleteAttachFile(int boardUniqueID) throws Exception {
		return sqlSession.delete("BoardMapper.deleteAttachFile", boardUniqueID);
	}

	@Override
	public int getNoticeRows() throws Exception {
		return sqlSession.selectOne("BoardMapper.selectNoticeRows");
	}

	@Override
	public List<Board> getNoticeList(Page page) throws Exception {
		return sqlSession.selectList("BoardMapper.selectNoticeList", page);
	}

	@Override
	public List<AttachFile> getAttachFile(int boardUniqueID) throws Exception {
		return sqlSession.selectList("BoardMapper.selectAFList", boardUniqueID);
	}

	@Override
	public void updateAttachFile(HashMap<String, Object> hm) throws Exception {
		sqlSession.update("BoardMapper.updateAttachFile", hm);
	}

	@Override
	public int deleteBoardAttachFile(int fileUniqueID) throws Exception {
		return sqlSession.delete("BoardMapper.deleteBoardAttachFile", fileUniqueID);
	}

	@Override
	public void addComment(Comment comment) throws Exception {
		sqlSession.insert("BoardMapper.addComment", comment);
	}

	@Override
	public List<Comment> getCommentList(HashMap<String, Object> hm) throws Exception {
		return sqlSession.selectList("BoardMapper.getCommentList", hm);
	}

	@Override
	public int getTotalComment(int boardUniqueID) throws Exception {
		return sqlSession.selectOne("BoardMapper.getTotalComment", boardUniqueID);
	}

	@Override
	public int deleteComment(int commentUniqueID) throws Exception {
		return sqlSession.delete("BoardMapper.deleteComment", commentUniqueID);
	}

	@Override
	public void addADRequest(ADRequest adr) throws Exception {
		sqlSession.insert("BoardMapper.addADRequest", adr);
	}

	@Override
	public List<ADRequest> getADReqList(HashMap<String, Object> paramMap) throws Exception {
		return sqlSession.selectList("BoardMapper.getADReqList", paramMap);
	}

	@Override
	public int getADReqTotalCount(int uniqueID) throws Exception {
		return sqlSession.selectOne("BoardMapper.getADReqTotalCount", uniqueID);
	}

	@Override
	public void deleteADReq(ADRequest adr) throws Exception {
		sqlSession.delete("BoardMapper.deleteADReq", adr);
	}

	@Override
	public ADRequest getADReqBann(int adUniqueID) throws Exception {
		logger.debug("@!#$@#$="+adUniqueID);
		ADRequest a = sqlSession.selectOne("BoardMapper.getADReuest", adUniqueID);
		logger.debug("디벅= "+a);
		return a;
	}

	@Override
	public SystemInfo getSystemInfo() throws Exception {
		return sqlSession.selectOne("BoardMapper.getSystemInfo");
	}

	@Override
	public void addLine(Line line) throws Exception {
		sqlSession.insert("BoardMapper.addLine", line);
	}

	@Override
	public List<Line> getLineList(HashMap<String, Object> paramMap) throws Exception {
		return sqlSession.selectList("BoardMapper.getLineList", paramMap);
	}

	@Override
	public int getLineTotalCount(int uniqueID) throws Exception {
		return sqlSession.selectOne("BoardMapper.getLineTotalCount", uniqueID);
	}

	@Override
	public Promotion getPromotion(int memberUniqueID) throws Exception {
		return sqlSession.selectOne("BoardMapper.getPromotion", memberUniqueID);
	}

	@Override
	public void deleteLine(int uniqueID) throws Exception {
		sqlSession.delete("BoardMapper.deleteLine", uniqueID);
	}

}
