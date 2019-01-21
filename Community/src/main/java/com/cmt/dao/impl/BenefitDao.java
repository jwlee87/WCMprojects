package com.cmt.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cmt.dao.BenefitDaoInterface;

@Repository
public class BenefitDao implements BenefitDaoInterface {

	@Resource(name="wsSession")
	private SqlSession wsSession;
	@Override
	public HashMap<String, Object> selectListMap(HashMap<String, Object> param) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		
		if(((String)param.get("menu")).equals("cm")) {
			resultList = wsSession.selectList("benefit.currentMonthSelectList");
		}else if(((String)param.get("menu")).equals("pm")) {
			resultList = wsSession.selectList("benefit.priviousMonthSelectList");
		}
		resultMap.put("result", resultList);
		return resultMap;
	}

}
