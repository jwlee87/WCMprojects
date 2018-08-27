package com.cmt.dao.impl;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.dao.PointDaoInterface;

@Repository
public class PointDao implements PointDaoInterface {
	
	@Autowired
	@Qualifier("wsSession")
	private SqlSession wsSession;
	
	@Override
	public HashMap<String, Object> selectList(HashMap<String, Object> param) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("state", param.get("state"));
		resultMap.put("list", wsSession.selectList("point.selectList", param));
		return resultMap;
	}

	@Override
	synchronized public HashMap<String, Object> updateState(HashMap<String, Object> param) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", wsSession.update("point.updateState", param));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> selectOneRefund(HashMap<String, Object> param) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> checkMap = wsSession.selectOne("point.selectOneRefund", param);
		resultMap.put("type", param.get("type"));
		if(checkMap.get("_ResultTime") == null) {
			resultMap.put("changeCheck", true);
		} else {
			resultMap.put("changeCheck", false);
		}
		return resultMap;
	}

//	@Override
//	public int updatePoint(HashMap<String, Object> paramMap) {
//		return wsSession.update("point.updatePoint", paramMap);
//	}

	@Override
	public HashMap<String, Object> selectOnePoint(HashMap<String, Object> paramMap) {
		return wsSession.selectOne("point.selectOneMember", paramMap);
	}

	@Override
	public int selectTotalCount(HashMap<String, Object> param) {
		return wsSession.selectOne("point.totalCount", param);
	}

}
