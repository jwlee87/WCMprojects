package com.cmt.dao;

import java.util.HashMap;
import java.util.List;

public interface ServerDaoInterface {
	public int addServer(HashMap<String, Object> paramMap);
	public List<HashMap<String, Object>> getServerList();
	public int updateServer(HashMap<String, Object> paramMap);
	public int updateServerDelete(HashMap<String, Object> paramMap);
}
