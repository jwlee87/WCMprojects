package com.cmt.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.dao.P2PExDaoInterface;

@Repository("p2pExDaoImpl")
public class P2PExDaoImpl implements P2PExDaoInterface {

	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("wsSession")
	private SqlSession sqlSession;
	
	@Autowired
	@Qualifier("mariaSession")
	private SqlSession mariaSession;
	
	@Override
	public int addP2PEx(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getTotalCount(Map<String, Object> paramMap) {
		return sqlSession.selectOne("p2pEx.getTotalCount", paramMap);
	}

	@Override
	public List<Map<String, Object>> getP2PExList(Map<String, Object> paramMap) {
		return sqlSession.selectList("p2pEx.getP2PExList", paramMap);
	}

}