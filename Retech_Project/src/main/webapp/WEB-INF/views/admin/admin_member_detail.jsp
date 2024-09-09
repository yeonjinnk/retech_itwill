<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세 정보</title>
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
        .main .content {
            width: 100%;
            margin-bottom: 50px;
        }
        .main .content table {
            width: 100%;
        }
        .main .content table th {
            background-color: #eee;
            padding: 10px;
            text-align: left;
        }
        .main .content table td {
            padding: 10px;
        }
        .main .button-group {
            text-align: center;
            margin-top: 20px;
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
                <h3>회원 상세 정보</h3>
                <div class="content">
                    <table border="1">
                        <tr>
                            <th>회원아이디</th>
                            <td>${member.member_id}</td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td>${member.member_name}</td>
                        </tr>
                        <tr>
                            <th>상점이름</th>
                            <td>${member.member_nickname}</td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td>${member.member_phone}</td>
                        </tr>
                        <tr>
                            <th>생년월일</th>
                            <td>${member.member_birth}</td>
                        </tr>
                        <tr>
                            <th>회원 상태</th>
                            <td>
                                <c:choose>
                                    <c:when test="${member.member_status eq '탈퇴'}">탈퇴</c:when>
                                    <c:otherwise>활동 중</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="button-group">
                    <button type="button" onclick="location.href='AdminMemberList2'">목록으로 돌아가기</button>
                </div>
            </article>
        </section>
    </div>
    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
