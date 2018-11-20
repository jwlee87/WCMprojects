package com.cmt.dao;

import java.util.HashMap;
import java.util.List;

public interface MyAssetsDao {
	public List<HashMap<String, Object>> getMyAssets(HashMap<String, Object> paramMap);
}
