package com.cmt.service;

import java.util.HashMap;

public interface MyAssetsService {
	public int getTotalCount(HashMap<String, Object> paramMap);
	public HashMap<String, Object> getMyAssets(HashMap<String, Object> paramMap);
	public HashMap<String, Object> getDetailContents(HashMap<String, Object> paramMap);
}
