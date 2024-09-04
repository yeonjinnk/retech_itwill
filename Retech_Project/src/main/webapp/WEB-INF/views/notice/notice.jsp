<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
.bottom_area {
	box-sizing: border-box;
	display: block;
	width: 100%;	
	background-color: lightgray;
	margin: auto;
    bottom: 0; 
}
</style>
</head>
<body>
<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	
	<h2>공지사항</h2>
	<br>
	<section id="buttonArea">
    <div class="area">
        <a href="Notice" >공지사항</a> | 
        <a href="FAQ" >자주찾는질문</a> | 
        <a href="Cs" >1:1문의</a>  
    </div>
    <br>
    </section>   
	<section id="listForm">
		<table border="1">
			<tr id="tr_top">			
				<td width="100px">글번호</td>
				<td>제목</td>
				<td width="150px">등록일</td>

			</tr>
			<c:set var="pageNum" value="1" />
	
			<c:if test="${not empty param.pageNum}">
				<c:set var="pageNum" value="${param.pageNum}" />
			</c:if>
			<c:forEach var="notice" items="${noticeList}">
				<tr>
					<td>${notice.notice_idx}</td>
					<td><a href="NoticeDetail?notice_idx=${notice.notice_idx}">${notice.notice_subject}</a></td>					
					<td>${notice.notice_date}</td>
				</tr>
			</c:forEach>
		</table>
	</section>
	<section id="pageList">

		<input type="button" value="이전" 
				onclick="location.href='Notice?pageNum=${pageNum - 1}'"
				<c:if test="${pageNum <= 1}">disabled</c:if>>

		<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">

			<c:choose>
				<c:when test="${i eq pageNum}">
					<b>${i}</b> 
				</c:when>
				<c:otherwise>
					<a href="Notice?pageNum=${i}">${i}</a> 
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<input type="button" value="다음" 
				<c:if test="${pageNum >= pageInfo.maxPage}">disabled</c:if>
		>
	</section>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>