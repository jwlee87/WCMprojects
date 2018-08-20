package com.cmt.dao;

import java.util.HashMap;

public interface StoreDaoInterface {
	
	public int insertPayment(HashMap<String, Object> param);
	public int addHistory(HashMap<String, Object> param);
	public HashMap<String, Object> selectPayment(HashMap<String, Object> param);
	public HashMap<String, Object> getHistory(HashMap<String, Object> param);
	
}
