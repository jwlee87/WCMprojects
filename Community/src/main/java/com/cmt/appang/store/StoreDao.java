package com.cmt.appang.store;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class StoreDao implements StoreDaoInterface {
	
	@Resource(name="sqlSessionTemplate")
	SqlSession session;
	
	@Override
	public int insertPayment(HashMap<String, Object> param) {
		System.out.println(param);
		return session.insert("store.insertPayment", param);
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
	public int updatePayment(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deletePayment(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return 0;
	}

}
