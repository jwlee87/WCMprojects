package com.cmt.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cmt.common.DateUtil;
import com.cmt.dao.ZombieDaoInterface;

@Repository
public class ZombieDao implements ZombieDaoInterface {
	
	@Resource(name="runSession")
	SqlSession runSession;
	
	@Resource(name="breakSession")
	SqlSession breakSession;
	
	@Resource(name="fightSession")
	SqlSession fightSession;
	
	@Resource(name="historySession")
	SqlSession historySession;

	@Override
	public HashMap<String, Object> selectList(HashMap<String, Object> param) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		String gameName = (String)param.get("gameName");
		String menu = (String)param.get("menu");
		
		result.put("gameName", gameName);
		
		SqlSession useSession = null;
		if(gameName.equals("run")) {
			useSession = runSession;
		}else if(gameName.equals("break")) {
			useSession = breakSession;
		}else if(gameName.equals("fight")) {
			useSession = fightSession;
		}
		
		if(menu.equals("tList")) {
			result.put("result", useSession.selectList(gameName + ".selectList", DateUtil.today()));
		}else if(menu.equals("yList")) {
			result.put("result", useSession.selectList(gameName + ".selectList", DateUtil.yesterday()));
		}else if(menu.equals("myBet")) {
			result.put("result", useSession.selectList(gameName + ".selectBetList", (int)param.get("userNo")));
		}
		
		return result;
	}

	@Override
	public HashMap<String, Object> getHistory(HashMap<String, Object> paramMap) {
		HashMap<String, Object> tempMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		resultList = historySession.selectList("history.selectList", paramMap);
		tempMap.put("list", resultList);
		resultMap = DateUtil.transformateDate(tempMap);
		resultMap.put("resultList",resultMap.get("list"));
		return resultMap;
	}

}
