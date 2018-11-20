package com.cmt.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.dao.ServerDaoInterface;

@Repository
public class ServerDao implements ServerDaoInterface {

	@Autowired
	@Qualifier("mariaSession")
	private SqlSession mariaSession;

	@Override
	public int addServer(HashMap<String, Object> paramMap) {
		return mariaSession.insert("server.addServer", paramMap);
	}

	@Override
	public List<HashMap<String, Object>> getServerList() {
		return mariaSession.selectList("server.getServerList");
	}

	@Override
	public int updateServer(HashMap<String, Object> paramMap) {
		return mariaSession.update("server.updateServer", paramMap);
	}

	@Override
	public int updateServerDelete(HashMap<String, Object> paramMap) {
		return mariaSession.update("server.deleteServer", paramMap);
	}

}
