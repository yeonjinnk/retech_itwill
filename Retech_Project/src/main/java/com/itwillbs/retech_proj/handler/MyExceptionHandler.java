package com.itwillbs.retech_proj.handler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class MyExceptionHandler {
	
//	에러 시 나타낼 페이지
	@ExceptionHandler(Exception.class)
	public String myException(Exception e) {
		e.printStackTrace();
		
		return "error/error_500";
	}
}
