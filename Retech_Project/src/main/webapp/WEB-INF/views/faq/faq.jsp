<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주찾는질문</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
#listForm table {
    width: 80%;
    margin: auto;
    border-collapse: collapse;
    background-color: #f0f4f8;
}

#listForm table th {
    padding: 15px;
    text-align: center;
    border: 1px solid #ccc;
    font-size: 1rem;
    background-color: #3498db;
    color: white;
}

#listForm table td {
    padding: 15px;
    text-align: center;
    border: 1px solid #ccc;
    font-size: 1rem;
}

#listForm table td a {
    color: #2c3e50;
    text-decoration: none;
    font-weight: bold;
}

#pageList {
    text-align: center;
    margin: 20px 0;
}

#pageList input, #pageList a {
    padding: 10px 15px;
    margin: 0 5px;
    background-color: #2c3e50;
    color: white;
    border: none;
    cursor: pointer;
    text-decoration: none;
}

#pageList b {
    padding: 10px 15px;
    background-color: #2c3e50;
    color: white;
}

#pageList input:disabled {
    background-color: #95a5a6;
    cursor: default;
}

#pageList a:hover, #pageList input:hover {
    background-color: #34495e;
}

h2, h3 {
    text-align: center;
    color: #2c3e50;
}

.area {
    text-align: center;
}

.area a {
    padding: 10px 20px;
    text-decoration: none;
    color: #333;
    border: 1px solid #ccc;
    background-color: #f9f9f9;
    margin: 0 5px;
    cursor: pointer;
}

.area a.selected {
    background-color: #34495e;
    color: #fff;
}

.area a.active {
    background-color: #2980b9;
    color: white;
    border-radius: 5px;
    padding: 5px 10px;
}

#listForm {
    width: 900px;
    margin: 0 auto;
}

#buttonArea {
    margin-top: 10px;
}
</style>
</head>
<body>
<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>

<section>
    <h3>자주찾는질문</h3>
</section>

<section id="buttonArea">
    <div class="area">
        <a href="Notice" data-page="Notice">공지사항</a> | 
        <a href="FAQ" data-page="FAQ" class="selected">자주찾는질문</a> | 
        <a href="Cs" data-page="Cs">1:1문의</a>  
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
                <td>${faq.faq_idx}</td>
                <td>${faq.faq_category}</td>
                <td id="subject">
                    <a href="FaqDetail?faq_idx=${faq.faq_idx}">${faq.faq_subject}</a>
                </td>
                <td>${faq.faq_date}</td>
            </tr>
        </c:forEach>
    </table>
</section>

<section id="pageList">
    <input type="button" value="이전" 
           onclick="location.href='FAQ?pageNum=${pageNum - 1}'"
           <c:if test="${pageNum <= 1}">disabled</c:if> >
    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
        <c:choose>
            <c:when test="${i eq pageNum}">
                <b>${i}</b> 
            </c:when>
            <c:otherwise>
                <a href="FAQ?pageNum=${i}">${i}</a> 
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <input type="button" value="다음" 
           <c:if test="${pageNum >= pageInfo.maxPage}">disabled</c:if> >
</section>

<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
</footer>
</body>
</html>
