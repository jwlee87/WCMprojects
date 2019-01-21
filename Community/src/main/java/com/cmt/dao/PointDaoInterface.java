package com.cmt.dao;

import java.util.HashMap;

public interface PointDaoInterface {
	public HashMap<String, Object> selectList(HashMap<String, Object> param);
	public HashMap<String, Object> selectOneRefund(HashMap<String, Object> param);
	public HashMap<String, Object> selectOnePoint(HashMap<String, Object> param);
	public HashMap<String, Object> updateState(HashMap<String, Object> param);
//	public int updatePoint(HashMap<String, Object> paramMap);
	public int selectTotalCount(HashMap<String, Object> param);
}
