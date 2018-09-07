package com.cmt.dao;

import java.util.HashMap;
import java.util.List;

public interface ApDaoInterface {
	public int addAdvertisingProvider(HashMap<String, Object> paramMap);
	public HashMap<String, Object> getAp(HashMap<String, Object> paramMap);
	public List<HashMap<String, Object>> getApList();
	public List<HashMap<String, Object>> getApList(HashMap<String, Object> paramMap);
	public int updateAdvertisingProvider(HashMap<String, Object> paramMap);
	public int updateApDelete(HashMap<String, Object> paramMap);
}
