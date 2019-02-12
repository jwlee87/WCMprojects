package com.cmt.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface TsunamiApiService {

	Map<String, Object> getAuth(String jsonString) throws Exception;
	Map<String, Object> getAuth(HttpServletRequest req) throws Exception;

}
