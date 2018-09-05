package com.cmt.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.common.HttpUtil;
import com.cmt.dao.ApDaoInterface;

@Repository
public class ApDao implements ApDaoInterface {
	
	@Autowired
	@Qualifier("mariaSession")
	private SqlSession mariaSession;
	
	@Override
	public int addAdvertisingProvider(HashMap<String, Object> paramMap) {
		String ecPass = HttpUtil.encryptionPass((String)paramMap.get("loginPw"));
		paramMap.put("loginPw", ecPass);
		return mariaSession.insert("ap.addAp", paramMap);
	}
	
	@Override
	public List<HashMap<String, Object>> getApList() {
		return mariaSession.selectList("ap.getApList");
	}

	@Override
	public List<HashMap<String, Object>> getApList(HashMap<String, Object> paramMap) {
		return mariaSession.selectList("ap.getApList", paramMap);
	}

	@Override
	public int updateAdvertisingProvider(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAdvertisingProvider(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return 0;
	}

}
