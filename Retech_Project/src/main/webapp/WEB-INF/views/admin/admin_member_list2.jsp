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
        .main .content table #yAdmin {
            background-color: orange;
        }
        .main #pageList {
            text-align: center;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/admin_top.jsp"></jsp:include>
    </header>
    <div class="inner">
        <section class="wrapper">
            <jsp:include page="/WEB-INF/views/inc/admin_side_nav.jsp"></jsp:include>
            <article class="main">
                <h3>회원 목록</h3>
                <div class="content">
                    <table border="1">
                        <tr>
                            <th>회원아이디</th>
                            <th>이름</th>
                            <th>상점이름</th>
                            <th>전화번호</th>
                            <th>생년월일</th>
                            <th>회원상태</th>
                        </tr>
                        <c:set var="pageNum" value="1" />
                        <c:if test="${not empty param.pageNum}">
                            <c:set var="pageNum" value="${param.pageNum}" />
                        </c:if>
                        <c:forEach var="member" items="${memberList}">
                            <tr align="center">
						    <td>
						        <a href="AdminMemberDetail?memberId=${member.member_id}">
						            ${member.member_id}
						        </a>
						    </td>
						    <td>${member.member_name}</td>
						    <td>${member.member_nickname}</td>
						    <td>${member.member_phone}</td>
						    <td>${member.member_birth}</td>
						    <td>
						        <c:choose>
						            <c:when test="${member.member_status eq '탈퇴'}">
						                <span class="status-x">X</span>
						            </c:when>
						            <c:otherwise>
						                <span class="status-o">O</span>
						            </c:otherwise>
						        </c:choose>
						    </td>
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
                        onclick="location.href='AdminMemberList2?pageNum=${pageNum - 1}'" 
                        <c:if test="${pageNum eq 1}"> disabled</c:if> />
                    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                        <c:choose>
                            <c:when test="${i eq pageNum}">
                                <b>${i}</b>
                            </c:when>
                            <c:otherwise>
                                <a href="AdminMemberList2?pageNum=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <input type="button" value="다음" 
                        onclick="location.href='AdminMemberList2?pageNum=${pageNum + 1}'" 
                        <c:if test="${pageNum eq pageInfo.endPage}"> disabled</c:if> />
                </div>
            </article>
        </section>
    </div>
</body>
</html>
