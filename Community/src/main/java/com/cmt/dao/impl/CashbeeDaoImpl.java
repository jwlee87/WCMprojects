package com.cmt.dao.impl;

import java.util.HashMap;

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

	@Override
	public int addCompleteCharge(HashMap<String, Object> paramMap) {
		return mariaSession.insert("cashbee.addCompleteCharge", paramMap);
	}

}
