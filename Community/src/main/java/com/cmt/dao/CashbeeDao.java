package com.cmt.dao;

import java.util.HashMap;

public interface CashbeeDao {
	public int addCompleteCharge(HashMap<String, Object> paramMap);
	public int addCompleteCashbee(HashMap<String, Object> paramMap);
}
