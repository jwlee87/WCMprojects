package com.cmt.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cmt.dao.P2PExDaoInterface;
import com.cmt.service.P2PExService;

@Service("p2pExServiceImpl")
public class P2PExServiceImpl implements P2PExService {

	@Autowired
	@Qualifier("p2pExDaoImpl")
	private P2PExDaoInterface pdi;
	
	@Override
	public int getTotalCount(Map<String, Object> paramMap) {
		return 0;
	}

	@Override
	public Map<String, Object> getP2PEx(Map<String, Object> paramMap) {
		return null;
	}

	@Override
	public List<Map<String, Object>> getP2PExList(Map<String, Object> paramMap) {
		return pdi.getP2PExList(paramMap);
	}

	@Override
	public Map<String, Object> updateP2PEx(Map<String, Object> paramMap) {
		return null;
	}

}
