package com.cmt.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cmt.common.DateUtil;
import com.cmt.dao.StoreDaoInterface;

@Repository
public class StoreDao implements StoreDaoInterface {
	
	@Resource(name="wsSession")
	SqlSession session;
	
	@Resource(name="historySession")
	SqlSession historySession;
	
	@Override
	public int insertPayment(HashMap<String, Object> param) {
		return session.insert("store.insertPayment", param);
	}
	
	@Override
	public int addHistory(HashMap<String, Object> param) {
		return historySession.insert("history.addPointHistory", param);
	}

	@Override
	public HashMap<String, Object> selectPayment(HashMap<String, Object> param) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> resultList = new ArrayList<Object>();
		resultList = session.selectList("store.selectListPayment", param);
		resultMap.put("resultList", resultList);
		resultMap.put("resultListCount", resultList.size());
		return resultMap;
	}

	@Override
	public HashMap<String, Object> getHistory(HashMap<String, Object> param) {
		HashMap<String, Object> tempMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		resultList = historySession.selectList("history.selectPointList", param);
		tempMap.put("list", resultList);
		resultMap = DateUtil.transformateDate(tempMap);
		resultMap.put("resultList",resultMap.get("list"));
		return resultMap;
	}

	
	
	
	
}
