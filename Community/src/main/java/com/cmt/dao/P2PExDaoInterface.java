package com.cmt.dao;

import java.util.List;
import java.util.Map;

public interface P2PExDaoInterface {
	public int addP2PEx(Map<String, Object> paramMap);
	public int getTotalCount(Map<String, Object> paramMap);
	public List<Map<String, Object>> getP2PExList(Map<String, Object> paramMap);
	
}
