package com.cmt.dao;

import java.util.HashMap;
import java.util.List;

public interface FindDaoInterface {
	public List<HashMap<String, Object>> getServerList();
	public List<HashMap<String,Object>> getPassword(HashMap<String, Object> param);
	
	public List<HashMap<String, Object>> memberList();
}
