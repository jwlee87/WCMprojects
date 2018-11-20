package com.cmt.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.dao.CashbeeDao;

@Repository("cashbeeDaoImpl")
public class CashbeeDaoImpl implements CashbeeDao {
	
	@Autowired
	@Qualifier("mariaSession")
	private SqlSession mariaSession;
	
	@Autowired
	@Qualifier("wsSession")
	private SqlSession wsSession;

	@Override
	public int addCompleteCharge(HashMap<String, Object> paramMap) {
		return mariaSession.insert("cashbee.addCompleteCharge", paramMap);
	}

	@Override
	public int addCompleteCashbee(HashMap<String, Object> paramMap) {
		return wsSession.insert("cashbee.addCompleteCashbee", paramMap);
	}

	@Override
	public HashMap<String, Object> getLockLog() {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", wsSession.selectList("cashbee.getLockLog"));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> getChargeLog(HashMap<String, Object> paramMap) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", wsSession.selectList("cashbee.getChargeLog", paramMap));
		return resultMap;
	}

	@Override
	public int updateLockState(HashMap<String, Object> paramMap) {
		return wsSession.update("cashbee.updateLockState", paramMap);
	}

}
