package com.cmt.appang.store;

import java.util.HashMap;

public interface StoreDaoInterface {
	
	public int insertPayment(HashMap<String, Object> param);
	public HashMap<String, Object> selectPayment(HashMap<String, Object> param);
	
}
