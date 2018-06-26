package com.cmt.zombie;

import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ZombieDao implements ZombieDaoInterface {
	
	@Resource(name="sqlSession2")
	SqlSession session;

	@Override
	public HashMap<String, Object> selectList(HashMap<String, Object> param) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("result", session.selectList(param.get("menu") + ".selectList", param.get("date")));
//		if("selectList".equals(param.get("type"))) {
//			System.out.println("debug: "+ param);
//			System.out.println(result);
//		}else if("yList".equals(param.get("type"))) {
//			System.out.println("debug: "+ param);
//			System.out.println(result);
//		}
		return result;
	}

}
