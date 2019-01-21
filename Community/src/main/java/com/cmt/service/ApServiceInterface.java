package com.cmt.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface ApServiceInterface {
	public List<HashMap<String, Object>> getApList();
	public HashMap<String, Object> addAp(HttpServletRequest req);
	public HashMap<String, Object> getAjaxList(HttpServletRequest req);
	public HashMap<String, Object> getCheckPw(HttpServletRequest req);
	public HashMap<String, Object> updateAp(HttpServletRequest req);
	public HashMap<String, Object> getSimplePw(HttpServletRequest req);
	public HashMap<String, Object> deleteAp(HttpServletRequest req);
}
