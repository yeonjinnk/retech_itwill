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
    <style>
        .main {
            padding: 1.8rem;
        }
        .main h3 {
            text-align: left;
            margin-bottom: 30px;
        }
        .main .wrapper_top {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin-bottom: 20px;
        }
        .main .wrapper_top .search {
            width: 270px;
            position: absolute;
            left: 40%;
        }
        .main .content {
            width: 100%;
            margin-bottom: 50px;
        }
        .main .content table {
            width: 100%;
        }
        .main .content table th {
            background-color: #eee;
        }
        .main .content table .yBlack {
            background-color: red;
        }
        .main #pageList {
            text-align: center;
        }
    </style>
    <script>
    function confirmPolice(id, member_status, isPolice){
		let msg = "";
		
		if(member_status == '1') {
			msg = "블랙";
		} else {
			msg = "해제";
		}
		
		if(confirm("회원을 " + msg + "하시겠습니까?")){
			location.href="ChangeMemberAuthorize?member_id=" + id + "&member_status=" + member_status + "&isPolice=" + isPolice;
		}
	}
    </script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/admin_top.jsp"></jsp:include>
	</header>
	<div class="inner">
		<section class="wrapper">
			<jsp:include page="/WEB-INF/views/inc/admin_side_nav.jsp"></jsp:include>
			<article class="main">
				<h3>회원 블랙</h3>
				<form action="AdminPolice">
					<div class="search">
						<span>Search</span>
							<input type="search" name="searchKeyword" value="${param.searchKeyword}" >
							<input type="submit" value="검색">
					</div>
				</form>
				<div class="content">
					<table border="1">
						<tr>
							<th>회원아이디</th>
							<th>이름</th>
							<th>회원상태</th>
							<th>회원 관리</th>
						</tr>
						<c:set var="pageNum" value="1" />
						<c:if test="${not empty param.pageNum}">
							<c:set var="pageNum" value="${param.pageNum}" />
						</c:if>
						<c:forEach var="member" items="${memberList}">
							<tr align="center">
								<td>${member.member_id}</td>
								<td>${member.member_name}</td>
								<td>${member.member_status}</td>
								<td><c:choose>
										<c:when test="${member.member_status eq '1'}">
											<input type="button" value="회원 블랙 부여"
												onclick="confirmPolice('${member.member_id}', '${member.member_status}', '블랙')"
												>
										</c:when>
										<c:when test="${member.member_status eq '탈퇴'}">
											탈퇴한 회원입니다.
										</c:when>
										<c:otherwise>
											<input type="button" value="회원 블랙 해제" class="yBlack"
												onclick="confirmPolice('${member.member_id}', '${member.member_status}', '1')"
											>
										</c:otherwise>
									</c:choose></td>
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
						onclick="location.href='AdminPolice?pageNum=${pageNum - 1}'"
						<c:if test="${pageNum eq 1}"> disabled</c:if>>
					<c:forEach var="i" begin="${pageInfo.startPage}"
						end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq pageNum}">
								<b>${i}</b>
							</c:when>
							<c:otherwise>
								<a href="AdminPolice?pageNum=${i}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<input type="button" value="다음"
						onclick="location.href='AdminPolice?pageNum=${pageNum + 1}'"
						<c:if test="${pageNum eq pageInfo.endPage}"> disabled</c:if>>
				</div>
			</article>
		</section>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>
