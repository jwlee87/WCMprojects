package com.cmt.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface ServerServiceInterface {
	public List<HashMap<String, Object>> getServerList();
	public HashMap<String, Object> addServer(HttpServletRequest req);
	public HashMap<String, Object> updateServer(HttpServletRequest req);
	public HashMap<String, Object> deleteServer(HttpServletRequest req);
}
