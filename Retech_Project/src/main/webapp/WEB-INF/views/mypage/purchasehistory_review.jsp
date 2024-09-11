<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매내역</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/mypage/purchasehistory.css" rel="stylesheet" type="text/css">
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
            margin-top: 150px;
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
            background-color: #FF0000;
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
            background-color: #FF0000;
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
        }

        .status-buttons {
            display: flex;
            gap: 10px;
        }

        .status-buttons button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            font-size: 14px;
        }

        .cancel-request {
            background-color: #f44336; 
        }

        .confirm-request {
            background-color: #4caf50; 
        }

        .review-request {
            background-color: #2196F3; 
        }

        .cancel-request:hover {
            background-color: #d32f2f;
        }

        .confirm-request:hover {
            background-color: #388e3c;
        }

        .review-request:hover {
            background-color: #1976D2;
        }
        
        
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    		
            
    </script>
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
                    <a href="PurchaseHistory?member_id=${param.member_id}" class="selected">구매내역</a>
                     <a href="PurchaseStoreHistory?member_id=${param.member_id}">스토어 구매내역</a>
                    <a href="Wishlist?member_id=${param.member_id}">찜한상품</a>
                </c:when>
                <c:otherwise>
                    <!-- member_id 파라미터가 없을 때 -->
                    <a href="SaleHistory">판매내역</a>
                    <a href="PurchaseHistory" class="selected">구매내역</a>
                    <a href="PurchaseStoreHistory">스토어 구매내역</a>
                    <a href="Wishlist">찜한상품</a>
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
                <li><a href="PurchaseHistory">구매내역</a></li>
                <li><a href="BuyerReview" class="selected">작성한 리뷰</a></li>
            </ul>

            <div class="content">
                <c:if test="${not empty myReview}">
                    <table>
                        <thead>
                            <tr>
                                <th>상품사진</th>
                                <th>상품명</th>
                                <th>리뷰별점</th>
                                <th>리뷰내용</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${myReview}">
<%--                                 <c:if test="${product.pd_status == '결제완료' ||  --%>
<%--                                              product.pd_status == '거래취소 요청' ||  --%>
<%--                                              product.pd_status == '거래취소 확정' ||  --%>
<%--                                              product.pd_status == '거래확정'}"> --%>
                                    <tr>
                                        <td> <!-- 상품사진 -->
                                            <c:choose>
                                                <c:when test="${not empty product.pd_image1}">
                                                    <img src="${pageContext.request.contextPath}/resources/images/${product.pd_image1}" alt="${product.pd_content}" class="product-image"/>
                                                </c:when>
                                                <c:otherwise>
                                                    No Image
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <!-- 상품명 -->
                                        <td><a href="${pageContext.request.contextPath}/productDetail?pd_idx=${product.pd_idx}">${product.pd_content}</a></td>
<%--                                         <td>${product.pd_content}</td> --%>
  										 <!-- 리뷰별점 -->
                                        <td>
                                        <c:choose>
                                        	<c:when test="${product.review_star_rating eq 1}">
                                        	★
                                        	</c:when>
                                        	<c:when test="${product.review_star_rating eq 2}">
                                        	★★
                                        	</c:when>
                                        	<c:when test="${product.review_star_rating eq 3}">
                                        	★★★
                                        	</c:when>
                                        	<c:when test="${product.review_star_rating eq 4}">
                                        	★★★★
                                        	</c:when>
                                        	<c:when test="${product.review_star_rating eq 5}">
                                        	★★★★★
                                        	</c:when>
                                        </c:choose>
                                        
                                        </td>
                                         <!-- 리뷰내용 -->
                                        <td>${product.review_content}</td>
                                    </tr>
<%--                                 </c:if> --%>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty myReview}">
                    <table class="mypage">
                        <tr>
                            <td align="center" colspan="6">검색결과가 없습니다.</td>
                        </tr>
                    </table>
                </c:if>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
 