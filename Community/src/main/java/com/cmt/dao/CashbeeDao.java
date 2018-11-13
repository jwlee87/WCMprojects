package com.cmt.dao;

import java.util.HashMap;

public interface CashbeeDao {
	public int addCompleteCharge(HashMap<String, Object> paramMap);
	public int addCompleteCashbee(HashMap<String, Object> paramMap);
	public HashMap<String, Object> getLockLog();
	public HashMap<String, Object> getChargeLog(HashMap<String, Object> paramMap);
	public int updateLockState(HashMap<String, Object> paramMap);
}
