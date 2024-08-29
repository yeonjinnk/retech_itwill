<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 날짜 등의 출력 형식 변경을 위한 JSTL - format(fmt) 라이브러리 등록 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- hidden (where 절에 써야해서 파라미터 전달해야함 -->
<input type="hidden" name="notice_idx" value="${selectedNotice.notice_idx}" > 

<div>
	<span>제목</span> <br>
	<input type="text" name="notice_subject" value="${selectedNotice.notice_subject}">
</div>

<div>
	<span>공지내용</span> <br>
	<textarea rows="10" cols="40" name="notice_content">${selectedNotice.notice_content}</textarea>
</div>


















