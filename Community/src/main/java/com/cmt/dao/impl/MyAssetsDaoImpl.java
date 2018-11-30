package com.cmt.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.dao.MyAssetsDao;

@Repository("myAssetsDaoImpl")
public class MyAssetsDaoImpl implements MyAssetsDao {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("wsSession")
	private SqlSession sqlSession;
	
	@Autowired
	@Qualifier("mariaSession")
	private SqlSession mariaSession;
	
	@Autowired
	@Qualifier("historySession")
	private SqlSession logSqlSession;

	@Override
	public List<HashMap<String, Object>> getMyAssets(HashMap<String, Object> paramMap) {
		return sqlSession.selectList("myAssets.getMyAssets", paramMap);
	}

	@Override
	public List<HashMap<String, Object>> getTransactionList(HashMap<String, Object> paramMap) {
		logger.debug(paramMap);
		return logSqlSession.selectList("myAssets.getTransactionList", paramMap);
	}

	@Override
	public int getTotalCount(HashMap<String, Object> paramMap) {
		return logSqlSession.selectOne("myAssets.getTotalCount", paramMap);
	}

	@Override
	public List<Map<String, Object>> getMapList() {
		return mariaSession.selectList("myAssets.getMapList");
	}

	@Override
	public int addTempUrl(Map<String, Object> paramMap) {
		return mariaSession.insert("myAssets.addTempUrl", paramMap);
	}

	@Override
	public int deleteTempUrl(Map<String, Object> paramMap) {
		return mariaSession.delete("myAssets.deleteTempUrl", paramMap);
	}

}
