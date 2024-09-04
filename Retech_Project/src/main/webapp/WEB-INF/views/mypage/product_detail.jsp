<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 상세보기</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
        }

        .main-content {
            display: flex;
            justify-content: center;
            margin-top: 150px;
        }

        .content-area {
            padding: 20px;
            background-color: #f9f9f9;
            max-width: 800px;
            width: 100%;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .product-image {
            max-width: 100%;
            height: auto;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .product-details {
            margin-top: 20px;
        }

        .product-details h1 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }

        .product-details p {
            font-size: 16px;
            color: #666;
            margin: 10px 0;
        }

        .product-details .price {
            font-size: 20px;
            color: #FF5722;
            margin: 10px 0;
        }

        .product-details .status {
            font-size: 16px;
            color: #3F51B5;
            margin: 10px 0;
        }

        .back-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #2196F3;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #1976D2;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <div class="main-content">
        <div class="content-area">
            <c:if test="${not empty product}">
                <img src="${pageContext.request.contextPath}/resources/images/${product.pd_image1}" alt="${product.pd_content}" class="product-image"/>
                <div class="product-details">
                    <h1>${product.pd_content}</h1>
                    <p class="price">${product.pd_price} 원</p>
                    <p class="status">상태: ${product.pd_status}</p>
                    <!-- 날짜 형식이 올바른지 확인, String 타입일 경우 직접 포맷 -->
                    <p>등록날짜: ${product.pd_first_date}</p>
                    <p>${product.pd_description}</p>
                </div>
            </c:if>
            <c:if test="${empty product}">
                <p>상품 정보가 없습니다.</p>
            </c:if>
            <a href="${pageContext.request.contextPath}/SaleHistory" class="back-button">목록으로 돌아가기</a>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
