package com.cmt.interceptor;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cmt.service.CashbeeService;

public class NewCheckingInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	private CashbeeService cashbeeService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HashMap<String, Object> paramMap = cashbeeService.getLockLog(request);
		@SuppressWarnings("unchecked")
		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) paramMap.get("list");
		HttpSession session = request.getSession();
		if( list.size() == 0 ) {
			session.setAttribute("newCheck", false);
		} else {
			session.setAttribute("newCheck", true);
		}
		return true;
	}
}