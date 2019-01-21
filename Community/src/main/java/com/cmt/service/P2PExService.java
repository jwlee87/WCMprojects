package com.cmt.service;

import java.util.List;
import java.util.Map;

public interface P2PExService {
	public int getTotalCount(Map<String, Object> paramMap);
	public Map<String, Object> getP2PEx(Map<String, Object> paramMap);
	public List<Map<String, Object>> getP2PExList(Map<String, Object> paramMap);
	public Map<String, Object> updateP2PEx(Map<String, Object> paramMap); 
}
