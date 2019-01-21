package com.cmt.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cmt.domain.Member;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("member");
		
		if (obj == null) {
			response.sendRedirect("/board/login");
		} else {
			Member member = (Member) obj;
			if( member.get_class() == 3 ) {
				return true;
			} else {
				response.sendRedirect("/");
			}
		}
		return false;
	}
}