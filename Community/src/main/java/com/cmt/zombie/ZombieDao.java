package com.cmt.zombie;

import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cmt.common.DateUtil;

@Repository
public class ZombieDao implements ZombieDaoInterface {
	
	@Resource(name="sqlSession2")
	SqlSession session;
	
	@Resource(name="breakSession")
	SqlSession breakSession;

	@Override
	public HashMap<String, Object> selectList(HashMap<String, Object> param) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		String gameName = (String)param.get("gameName");
		String menu = (String)param.get("menu");
		
//		System.out.println("gameName= "+gameName+", menu= "+menu);
		
		SqlSession useSession = null;
		if(gameName.equals("run")) {
			useSession = session;
		}else if(gameName.equals("break")) {
			useSession = breakSession;
		}
		
		if(menu.equals("tList")) {
			result.put("result", useSession.selectList(gameName + ".selectList", DateUtil.today()));
		}else if(menu.equals("yList")) {
			result.put("result", useSession.selectList(gameName + ".selectList", DateUtil.yesterday()));
		}
		
//		System.out.println(result);
		
		return result;
	}

}
