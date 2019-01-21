package com.cmt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MyAssetsService {
	public int getTotalCount(HashMap<String, Object> paramMap);
	public HashMap<String, Object> getMyAssets(HashMap<String, Object> paramMap);
	public HashMap<String, Object> getDetailContents(HashMap<String, Object> paramMap);
	public Map<String, Object> makeRandomString(String uNo);
	public boolean timeValidationChecker(long start, long end);
	public List<Map<String, Object>> getMapList();
	public int addTempUrl(Map<String, Object> paramMap);
	public int deleteTempUrl(Map<String, Object> paramMap);
}
