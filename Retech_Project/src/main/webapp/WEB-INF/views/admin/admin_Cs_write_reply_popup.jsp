<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 날짜 등의 출력 형식 변경을 위한 JSTL - format(fmt) 라이브러리 등록 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- hidden (where 절에 써야해서 파라미터 전달해야함 -->
<input type="hidden" name="cs_idx" value="${selectedCs.cs_idx}">

<div>
	<span>질문 제목</span> <br>
	<input type="text" name="cs_subject"  value="${selectedCs.cs_subject}" readOnly>
</div>

<div>
	<span>질문 내용</span> <br>
	<textarea rows="5" cols="40" name="cs_content" readOnly>${selectedCs.cs_content}</textarea>
</div>

<div>
 	<span>첨부 파일</span>
<c:if test="${not empty fileList}">
    <c:forEach var="file" items="${fileList}">
        <c:if test="${not empty file}">
            <c:set var="originalFileName" value="${fn:substringAfter(file, '_')}" />
            ${originalFileName}
            <a href="${pageContext.request.contextPath}/resources/upload/${file}" download="${originalFileName}">
                <input type="button" value="다운로드">
            </a>
            <br>
        </c:if>
    </c:forEach>
</c:if>
<c:if test="${empty fileList}">
    파일이 없습니다.
</c:if>
</div>

<div>
	<span>답변 작성(필수)</span> <br>
	<textarea rows="5" cols="40" name="cs_answer" required></textarea>
</div>

<div>
	<span>답변자(선택)</span> <br>
	<input type="text" name="cs_member_id">
</div>
