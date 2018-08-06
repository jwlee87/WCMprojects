package com.cmt.dao;

import java.util.HashMap;

public interface PointDaoInterface {
	public HashMap<String, Object> selectList(HashMap<String, Object> param);
	public HashMap<String, Object> selectOne(HashMap<String, Object> param);
	public HashMap<String, Object> pointUpdate(HashMap<String, Object> param);
}
