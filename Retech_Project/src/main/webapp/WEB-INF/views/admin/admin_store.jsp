<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 목록</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/admin_default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/admin/admin_store.css" rel="stylesheet" type="text/css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/admin_top.jsp"></jsp:include>
    </header>
    <div class="inner">
        <section class="wrapper">
            <jsp:include page="/WEB-INF/views/inc/admin_side_nav.jsp"></jsp:include>
            <article class="main">
                <h3>스토어 목록</h3>
                
                <form action="AdminStore">
					<div class="search">
						<span>Search</span>
						<input type="search" name="searchKeyword" value="${param.searchKeyword}" >
						<input type="submit" value="검색">
					</div>
				</form>
                
                
                <div class="content">
                    <table border="1">
                        <tr>
                            <th>상품 번호</th>
                            <th>상품명</th>
                            <th>상품 가격</th>
                            <th>상품 이름</th>
                            <th>카테고리</th>
                        </tr>
                        <c:set var="pageNum" value="1" />
                        <c:if test="${not empty param.pageNum}">
                            <c:set var="pageNum" value="${param.pageNum}" />
                        </c:if>
                        <c:forEach var="store" items="${storeList}">
                            <tr align="center">
						    <td>${store.store_idx}</td>
						    <td>${store.store_id}</td>
						    <td>${store.store_price}</td>
						    <td>${store.store_content}</td>
						    <td>${store.store_category}</td>
						</tr>

                        </c:forEach>
                        <c:if test="${empty memberList}">
                            <tr>
                                <td align="center" colspan="7">검색 결과가 없습니다.</td>
                            </tr>
                        </c:if>
                    </table>
                </div>
                <div id="pageList">
                    <input type="button" value="이전" 
                        onclick="location.href='AdminStore?pageNum=${pageNum - 1}'" 
                        <c:if test="${pageNum eq 1}"> disabled</c:if> />
                    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                        <c:choose>
                            <c:when test="${i eq pageNum}">
                                <b>${i}</b>
                            </c:when>
                            <c:otherwise>
                                <a href="AdminStore?pageNum=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <input type="button" value="다음" 
                        onclick="location.href='AdminStore?pageNum=${pageNum + 1}'" 
                        <c:if test="${pageNum eq pageInfo.endPage}"> disabled</c:if> />
                </div>
            </article>
        </section>
    </div>
</body>
</html>
