package com.cmt.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

//@ControllerAdvice
public class GlobalDefaultExceptionHandler {

	@ExceptionHandler(value = Exception.class)
	public ModelAndView defaultErrorHandler(HttpServletRequest req, Exception e) throws Exception {
		
		if(AnnotationUtils.findAnnotation(e.getClass(), ResponseStatus.class) != null)
			throw e;
		
		ModelAndView mav = new ModelAndView("resources/views/exception/exception");
		mav.addObject("exception", e);
		mav.addObject("url", req.getRequestURL());
		mav.addObject("name", e.getClass().getSimpleName());
		mav.addObject("message", e.getMessage());
		return mav;
	}

}
