package com.cmt.dao.impl;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.common.DateUtil;
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
	synchronized public HashMap<String, Object> pointUpdate(HashMap<String, Object> param) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", wsSession.update("point.updateState", param));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> selectOne(HashMap<String, Object> param) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> checkMap = wsSession.selectOne("point.getChangeCheck", param);
		System.out.println("CheckMap: "+checkMap);
		
		if(checkMap.get("_ResultTime") == null) {
			System.out.println("결과시간 널 트루");
			resultMap.put("changeCheck", true);
		} else {
			System.out.println("결과시간 널 펄스");
			resultMap.put("changeCheck", false);
		}
		return resultMap;
	}

}
