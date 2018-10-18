package com.cmt.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface CashbeeService {
	
	public boolean validationCheck(String ipAddr);
	public HashMap<String, Object> requestReader(HttpServletRequest request) throws Exception;
	public HashMap<String, Object> requestSelectSender(HashMap<String, Object> paramMap) throws Exception;
	public HashMap<String, Object> requestCommitSender(HashMap<String, Object> paramMap) throws Exception;
	public HashMap<String, Object> communication(HashMap<String, Object> paramMap);
	public HashMap<String, Object> completeCharge(HashMap<String, Object> paramMap);
}
