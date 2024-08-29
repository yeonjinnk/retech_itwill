<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 날짜 등의 출력 형식 변경을 위한 JSTL - format(fmt) 라이브러리 등록 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>
	<span>질문 제목</span> <br>
	<input type="text" name="cs_subject" value="${selectedCs.cs_subject}" readOnly>
</div>

<div>
	<span>질문 내용</span> <br>
	<textarea rows="5" cols="40" name="cs_content" readOnly>${selectedCs.cs_content}</textarea>
</div>

<div>
	<span>답변 내용</span> <br>
	<textarea rows="5" cols="40" name="cs_answer" readOnly>${selectedCs.cs_answer}</textarea>
</div>

<div>
	<span>답변자</span> <br>
	<input type="text" name="cs_consultant_name" value="${selectedCs.cs_consultant_name}" readOnly>
</div>
















