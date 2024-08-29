<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 날짜 등의 출력 형식 변경을 위한 JSTL - format(fmt) 라이브러리 등록 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- hidden (where 절에 써야해서 파라미터 전달해야함 -->
<input type="hidden" name="FAQ_idx" value="${selectedFaq.FAQ_idx}" > 

<div>
	<span>카테고리</span> <br>
	<select class="category" name="FAQ_category">
	 	<option value="회원" <c:if test="${selectedFaq.FAQ_category eq '회원'}">selected</c:if>>회원</option>
	 	<option value="스토어" <c:if test="${selectedFaq.FAQ_category eq '스토어'}">selected</c:if>>스토어</option>
	</select>
</div>
<div>
	<span>제목</span> <br>
	<input type="text" name="FAQ_subject" value="${selectedFaq.FAQ_subject}">
</div>

<div>
	<span>내용</span> <br>
	<textarea rows="10" cols="40" name="FAQ_content">${selectedFaq.FAQ_content}</textarea>
</div>


















