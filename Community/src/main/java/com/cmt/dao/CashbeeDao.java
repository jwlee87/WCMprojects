package com.cmt.dao;

import java.util.HashMap;
import java.util.List;

public interface CashbeeDao {
	public int addCompleteCharge(HashMap<String, Object> paramMap);
	public int addCompleteCashbee(HashMap<String, Object> paramMap);
	public List<HashMap<String, Object>> getLockLog();
	public HashMap<String, Object> getChargeLog(HashMap<String, Object> paramMap);
}
