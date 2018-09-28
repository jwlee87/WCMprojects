package com.cmt.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.dao.FindDaoInterface;

@Repository
public class FindDao implements FindDaoInterface {

	
	@Autowired
	@Qualifier("wsSession")
	private SqlSession wsSession;

	@Override
	public List<HashMap<String,Object>> getPassword(HashMap<String, Object> paramMap) {
		return wsSession.selectList("find.", paramMap);
	}

	@Override
	public List<HashMap<String, Object>> getServerList() {
		return wsSession.selectList("find.getServerList");
	}

	@Override
	public List<HashMap<String, Object>> memberList() {
		return wsSession.selectList("find.getMemberList");
	}
	
	

}
