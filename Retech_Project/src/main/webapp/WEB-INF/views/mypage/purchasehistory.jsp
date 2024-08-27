<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>index</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <style type="text/css">
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        display: flex;
        flex-direction: column;
        font-family: Arial, sans-serif;
    }

    .main-content {
        display: flex;
        flex: 1;
        margin-top: 150px; /* Header의 높이만큼 여백을 추가 */
        overflow: hidden;
    }

    .sidebar {
        width: 250px;
        background-color: #f4f4f4;
        padding: 20px;
        box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
        height: calc(100vh - 150px); /* Header 높이를 제외한 전체 화면 높이 */
        overflow-y: auto; /* 사이드바의 스크롤을 활성화 */
    }

    .sidebar a {
        display: block;
        padding: 10px;
        text-decoration: none;
        color: #333;
        border-radius: 5px;
        margin-bottom: 10px;
        transition: background-color 0.3s ease;
    }

    .sidebar a:hover {
        background-color: #ddd;
    }

    .sidebar a.selected {
        background-color: #FF0000;
        color: #fff;
    }

    .content-area {
        flex: 1;
        padding: 20px;
        background-color: #f9f9f9;
        overflow-y: auto; /* 콘텐츠 영역의 스크롤을 활성화 */
    }

    .store-info {
        background-color: #f5f5f5;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
    }

    .store-info h2 {
        margin-top: 0;
    }

    .tabs {
        margin-bottom: 20px;
        list-style-type: none;
        padding: 0;
        display: flex;
    }

    .tabs li {
        margin-right: 10px;
    }

    .tabs a {
        display: block;
        padding: 10px 20px;
        text-decoration: none;
        color: #000;
        background-color: #eee;
        border: 1px solid #ccc;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .tabs a.selected {
        background-color: #FF0000;
        color: #fff;
    }

    .content {
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 10px;
    } 
</style>

    
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <div class="main-content">
        <div class="sidebar">
            <a href="SaleHistory">판매내역</a>
            <a href="PurchaseHistory" class="selected">구매내역</a>
            <a href="Wishlist">찜한상품</a>
            <a href="MemberInfo">회원정보수정</a>
        </div>

        <div class="content-area">
            <div class="store-info">
                <h2>상점 정보</h2>
                <p>상점명: ${member.member_nickname}</p>
                <p>신뢰지수: </p>
            </div>

            <ul class="tabs">
                <li><a href="#" class="selected">구매내역</a></li>
                <li><a href="#">리뷰</a></li>
            </ul>

            <div class="content">
                <%-- 본문 내용은 여기에 삽입됩니다 --%>
                <c:if test="${empty orderticket2}">
                    <table class="mypage">
                        <tr>
                            <td align="center" colspan="8">검색결과가 없습니다.</td>
                        </tr>
                    </table>
                </c:if>
                <ul class="list-movie"></ul>
                <a href="#" class="btn-more" style="display: none;">더보기 +</a>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
