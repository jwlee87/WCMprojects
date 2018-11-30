package com.cmt.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.message.Message;

public interface MyAssetsDao {
	public List<HashMap<String, Object>> getMyAssets(HashMap<String, Object> paramMap);
	public List<HashMap<String, Object>> getTransactionList(HashMap<String, Object> paramMap);
	public int getTotalCount(HashMap<String, Object> paramMap);
	public List<Map<String, Object>> getMapList();
	public int addTempUrl(Map<String, Object> objMap);
	public int deleteTempUrl(Map<String, Object> paramMap);
}
