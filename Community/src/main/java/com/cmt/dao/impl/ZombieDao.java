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
	
	@Resource(name="sqlSession2")
	SqlSession session;
	
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
//		System.out.println("gameName= "+gameName+", menu= "+menu);
		
		SqlSession useSession = null;
		if(gameName.equals("run")) {
			useSession = session;
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
		
//		System.out.println(result);
		
		return result;
	}

	@Override
	public HashMap<String, Object> getHistory(HashMap<String, Object> paramMap) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		
		System.out.println(paramMap);
		
		resultList = historySession.selectList("history.selectList", paramMap);
		
		System.out.println(resultList);
		resultMap.put("resultList", resultList);
		return resultMap;
	}

}
