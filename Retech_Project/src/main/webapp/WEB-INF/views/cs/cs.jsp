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
	<h2>1:1 문의</h2>
	<br>
	<section id="buttonArea">
	    <div class="area">
	        <a href="Notice">공지사항</a> | 
	        <a href="FAQ">자주 찾는 질문</a> | 
	        <a href="Cs">1:1 문의</a>  
	    </div>
	    <br>
    </section>
    <div style="text-align: center; margin-bottom: 20px;">
			<button class="registBtn" onclick="csRegist('${sessionScope.sId}')">문의 등록</button>
		</div>
	<section id="listForm">
		<table>
    <tr id="tr_top">
        <th width="200px">글번호</th>
        <th width="200px">제목</th>
        <th width="400px">문의내용</th>
        <th width="100px">확인여부</th>
        <th width="200px">등록일자</th>
    </tr>
    <c:set var="pageNum" value="1" />
    
    <c:if test="${not empty param.pageNum}">
        <c:set var="pageNum" value="${param.pageNum}" />
    </c:if>
	<c:if test="${not empty csList}">
	
	
	    <c:set var="listLimit" value="5" /> <!-- 한 페이지에 표시되는 게시글 수 -->
	
	    <!-- 현재 페이지의 글번호 시작값 계산 -->
	    <c:set var="startNum" value="${(pageNum - 1) * listLimit}" />
	
	    <!-- 게시글 목록을 순서대로 표시, varStatus를 이용하여 글번호 추가 -->
	    <c:forEach var="cs" items="${csList}" varStatus="status">
	        <tr>
	            <!-- startNum에 현재 인덱스를 더해 글번호 계산 -->
	            <td>${startNum + status.index + 1}</td> 
	            <td id="subject">
	                <a href="CsContent?cs_idx=${cs.cs_idx}&pageNum=${pageNum}">
	                    ${cs.cs_subject}
	                </a>
	            </td>
	            <td>${cs.cs_content}</td>
	            <td>${cs.cs_check}</td>
	            <td>${cs.cs_date}</td>
	        </tr>
	    </c:forEach>
    </c:if>
</table>
	</section>
	<section id="pageList">

		<input type="button" value="이전" 
				onclick="location.href='Cs?pageNum=${pageNum - 1}'"
				<c:if test="${pageNum <= 1}">disabled</c:if>>

		<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">

			<c:choose>
				<c:when test="${i eq pageNum}">
					<b>${i}</b> 
				</c:when>
				<c:otherwise>
					<a href="Cs?pageNum=${i}">${i}</a> 
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<input type="button" value="다음" 
				onclick="location.href='Cs?pageNum=${pageNum + 1}'"
				<c:if test="${pageNum >= pageInfo.maxPage}">disabled</c:if>>
	</section>
	
	<script type="text/javascript">
		function csRegist(id){
			location.href="CsForm?cs_member_id=" + id;
		}
	</script>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>