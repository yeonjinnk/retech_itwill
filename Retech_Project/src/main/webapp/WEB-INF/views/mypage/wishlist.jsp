<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>찜한 상품</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <style type="text/css">
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
            overflow: hidden;
        }
		
		.store-info img {
            border-radius: 50%;
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }
		
        .sidebar {
            width: 250px;
            background-color: #f4f4f4;
            padding: 20px;
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
            height: calc(100vh - 150px);
            overflow-y: auto;
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
            background-color: #34495e;
            color: #fff;
        }

        .content-area {
            flex: 1;
            padding: 20px;
            background-color: #f9f9f9;
            overflow-y: auto;
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
            background-color: #34495e;
            color: #fff;
        }

        .content {
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        .product-image {
            width: 100px;
            height: auto;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <div class="main-content">
        <div class="sidebar">
            <c:choose>
                <c:when test="${not empty param.member_id}">
                    <!-- member_id 파라미터가 있을 때 -->
                    <a href="SaleHistory?member_id=${param.member_id}">판매내역</a>
                    <a href="PurchaseHistory?member_id=${param.member_id}">구매내역</a>
                    <a href="Wishlist?member_id=${param.member_id}" class="selected">찜한상품</a>
                </c:when>
                <c:otherwise>
                    <!-- member_id 파라미터가 없을 때 -->
                    <a href="SaleHistory">판매내역</a>
                    <a href="PurchaseHistory">구매내역</a>
                    <a href="PurchaseStoreHistory">스토어 구매내역</a>
                    <a href="Wishlist" class="selected">찜한상품</a>
                    <a href="CsHistory">문의내역</a>
                    <a href="MemberInfo">회원정보수정</a>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="content-area">
             <div class="store-info">
                <div>
                    <img src="${pageContext.request.contextPath}/resources/images/${member.member_profile}">               	
                    <h2>상점 정보</h2>
                    <p>상점명: ${member.member_nickname}</p>
                    <p>지역: ${member.member_address1}</p>
                     <c:choose>
                    	<c:when test="${member.member_starRate eq 0.0}">
                    <p>신뢰지수: -     (<a href="ProductRegistForm"> !!이곳을 클릭해 판매를 시작해주세요!! )</a></p>
                    	</c:when>
                    	<c:otherwise>
                    <p>신뢰지수: ${member.member_starRate}</p>
                    	</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <ul class="tabs">
                <li><a href="#" class="selected">찜한 상품</a></li>
            </ul>

            <div class="content">
                <c:if test="${not empty productLike}">
                    <table>
                        <thead>
                            <tr>
                                <th>상품사진</th>
                                <th>상품명</th>
                                <th>상품가격</th>
                                <th>등록날짜</th>
                                <th>거래상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${productLike}">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty product.pd_image1}">
                                                <img src="${pageContext.request.contextPath}/resources/images/${product.pd_image1}" alt="${product.pd_content}" class="product-image"/>
                                            </c:when>
                                            <c:otherwise>
                                                이미지 없음
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><a href="${pageContext.request.contextPath}/productDetail?pd_idx=${product.pd_idx}">${product.pd_content}</a></td>
                                    <td>${product.pd_price}</td>
                                    <td data-date="${product.pd_first_date}"></td>
                                    <td>${product.pd_status}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty productLike}">
                    <table class="mypage">
                        <tr>
                            <td align="center" colspan="5">찜한 상품이 없습니다.</td>
                        </tr>
                    </table>
                </c:if>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // 날짜 형식 변환 함수
            function formatDate(dateString) {
                const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
                const date = new Date(dateString);
                return date.toLocaleDateString('ko-KR', options); // 'ko-KR'은 한국 날짜 형식
            }

            // 모든 날짜 셀을 찾아서 변환
            document.querySelectorAll('td[data-date]').forEach(cell => {
                const dateString = cell.getAttribute('data-date');
                if (dateString) {
                    cell.textContent = formatDate(dateString);
                }
            });
        });
    </script>
</body>
</html>
