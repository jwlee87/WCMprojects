package com.cmt.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface StoreServiceInterface {
	public HashMap<String, Object> payment(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> refund(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getHis(HttpServletRequest req);
}
