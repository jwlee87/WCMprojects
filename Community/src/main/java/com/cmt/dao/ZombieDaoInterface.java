package com.cmt.dao;

import java.util.HashMap;

public interface ZombieDaoInterface {

	public HashMap<String, Object> selectList(HashMap<String, Object> param);
	public HashMap<String, Object> getHistory(HashMap<String, Object> paramMap);
}
