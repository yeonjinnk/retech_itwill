<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/defaul.css" rel="stylesheet" type="text/css">
<script type="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">


function showBig(src) {
	$("#big").src = src;
}
</script>
<style>
.left {
	float:left;
}

.right {
	float:right;
}
</style>
</head>
<body>
<div class="store-view">
	<div class="left">
		<div class="img">
			<div class="bigImage">
				<img src="${Product.store_img1}" id="big"/>
			</div>
			<div class="smallImages">
				<img src="${Product.store_img2}" onclick="showBig(this.src)"/>
				<img src="${Product.store_img3}"/>
			</div>
<%-- 		${Product.store_img1} --%>
<%-- 		<img src="${Product.store_img1}"> --%>
				
<%-- 			<c:forEach var="product" items="${Product}"> --%>
<%-- 				<c:set var="" value="${Product.store_img1}"/> --%>
<%-- 				<c:set var="" value="${Product.store_img2}"/> --%>
<%-- 				<c:set var="" value="${Product.store_img3}"/> --%>
<%-- 				<c:out value="${Product.store_img[i]}"/> --%>
<%-- 			<c:if test="${not empty Product.store_img[i]}"> --%>
<%-- 				<img src="${Product.store_idx}"> --%>
<%-- 			</c:if> --%>
<%-- 				</c:set> --%>
<%-- 			</c:forEach> --%>
		</div>
	</div>
	<div class="right">
		<div class="goods-info">
			<div>
				<h2 class="title">${Product.store_id}</h2>
			</div>
			<div>
				<h3 class="price">
					<fmt:formatNumber pattern="#,###" value="${Product.store_price}"/>원
				</h3>
			</div>
			<div>
				<input type="button" value="장바구니" name="cart">
				<input type="button" value="바로구매" name="buy">
 			</div>
		</div>
	</div>
	<div class="goods_view_area">
	
	</div>
</div>

		 
	
	
	</div>
</body>
</html>