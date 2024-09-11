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
.@charset "UTF-8";
/* ------- 공통 ------- */
/* 하이퍼링크 밑줄 제거 */
a {
	text-decoration: none;
}
/*/
/* ----- top.jsp, bottom.jsp 공통 ----- */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;	
}
.main_section {
 	flex: 1;	
}
body {
    display: flex;
    flex-direction: column;
}

/* header 고정 */
header {
	position: fixed;
	width: 100%;
	height: 150px;
	top:0;
	z-index: 50;
	background-color: white;
	margin-bottom: 500px;
}

#header_top{
		margin-bottom: 500px;
	}

/* header 고정 후 다음 section 시작 */
section {
	margin-top: 150px;
}
/* header 고정 후 다음 section 시작 */
section {
	margin-top: 150px;
}
footer {
	display: block;
}
/*---- header 영역 시작 ----*/
/*---- top 최상단 ----*/
.header_top {
	box-sizing: border-box;
	display: block;
	margin-left: 50px;
	margin-right: 50px;
	max-width: 1000px;
	max-height: 60px;
	margin: auto;
}
.header_top li {
	list-style-type: none;
}
.top_inner {
	box-sizing: border-box;
	display: flex;
	justify-content: space-between;
	padding: 10px 40px;
	white-space: nowrap;
}
.top_menu {
	box-sizing: border-box;
	display: flex;
	justify-content: flex-end;	
}
.top_menu_container {
	box-sizing: border-box;
	display: block;	
}
.top_area {
	box-sizing: border-box;
	display: flex;
	margin-top: auto;
	margin-bottom: 10px;
	
}
.top_link {
	font-size: 12px;
	margin-left: 40px;
}
/*---- top 메뉴 ----*/
.header_main {
	box-sizing: border-box;
	display: block;
	margin-left: 50px;
	margin-right: 50px;
	max-width: 1000px;
	max-height: 100px;
	margin: auto;
}
.header_main li {
	list-style-type: none;
}
.main_inner {
	box-sizing: border-box;
/* 	height: 64px; */
	display: flex;
	justify-content: space-between;
	padding: 20px 40px;
	align-items: center;
	white-space: nowrap;
}
.main_menu {
	box-sizing: border-box;
	display: flex;
	justify-content: flex-end;
}
.menu_container {
	box-sizing: border-box;
	display: block;
}
.menu_area {
	box-sizing: border-box;
	display: flex;
	margin-bottom: 10px;
}
.menu_link {
	font-size: 16px;
	margin-left: 40px;
	display:block;
	
}
.main_search {
	box-sizing: border-box;
	display: flex;
	justify-content: flex-end;
	margin-bottom: 0;
	margin-top: 0;
}


.menu_list {
    position: relative; /* 서브메뉴 위치를 조정하기 위해 */
}
/*서브메뉴*/
.sub_menu {
	display:none; /*서브메뉴 숨기기*/
	position:absolute; /*부모메뉴 위치 따라 이동 */
	top: 50%; /* 부모 메뉴 항목 바로 아래에 위치 */
    left: 1200px; /* 부모 메뉴 항목의 왼쪽에 정렬 */
    background-color: white; /* 배경색 설정 */
    border: 1px solid black; /* 테두리 추가 */
    list-style: none; /* 리스트 스타일 제거 */
    padding: 0;
    margin: 0;
    font-size: 0.5em;
}

.sub_menu li:hover{
	background: lime;
}

.menu_list:hover .sub_menu {
    display: block; /* 마우스 오버 시 서브메뉴 표시 */
}

.sub_menu li {
    padding: 10px;
}

.sub_menu li a {
    text-decoration: none;
    color: #333;
}

/*---- header 영역 끝 ----*/
/*---- body 영역 시작 ----*/





/*---- body 영역 끝 ----*/
/*---- bottom 영역 시작 ----*/
.bottom_area {
	box-sizing: border-box;
	display: block;
	width: 100%;	
	background-color: lightgray;
	margin: auto;
    bottom: 0; 
}
.inc_info {
	box-sizing: border-box;
	padding-bottom: 40px;
	padding-top: 30px;
	padding-bottom: 40px; 
	padding-top: 30px; 
	padding-left: 35px;
    white-space: pre-line;	
    display: flex;
    font-size: 10px;
   	max-width: 1280px;
   	margin: auto;
}
.inc_info > div:not(.bottom_logo) {
	 margin-left: 40px;
}
.inc_intro1, .inc_intro2 {
    width: 30%;
}
/*---- bottom 영역 끝 ----*/
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
				<td>조회수</td>

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
					<td>${notice.notice_readcount}</td>
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