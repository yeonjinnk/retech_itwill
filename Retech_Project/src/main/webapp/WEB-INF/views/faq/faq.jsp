<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
		<h2>자주 찾는 질문</h2>
	<br>
	<section id="buttonArea">
    	<div class="area">
        	<a href="Notice">공지사항</a> | 
        	<a href="FAQ">자주 찾는 질문</a> | 
        	<a href="Cs">1:1 문의</a>  
    	</div>
    	<br>
    </section>
	<section id="listForm">
		<table>
			<tr id="tr_top">
				<th width="100px">글번호</th>
				<th width="100px">카테고리</th>
				<th>제목</th>
				<th width="150px">등록일</th>
			</tr>
			<c:set var="pageNum" value="1" />
	
			<c:if test="${not empty param.pageNum}">
				<c:set var="pageNum" value="${param.pageNum}" />
			</c:if>
			<c:forEach var="faq" items="${faqList}">
				<tr>
					<td>${faq.FAQ_idx}</td>
					<td>${faq.FAQ_category}</td>
					<td id="subject">
						<a href="FaqDetail?FAQ_idx=${faq.FAQ_idx}">${faq.FAQ_subject}</a>
					</td>
					<td>${faq.FAQ_create_date}</td>
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