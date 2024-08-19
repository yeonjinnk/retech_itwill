<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/store/store_detail.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">

// $(function() {
// 	$("#small1").click(src) {
// 		$("#big").src = src;
// 	}
// });

//이미지 바꾸기(작은 이미지 클릭 시 큰 이미지에 띄우기)
function showBig(src) {
	console.log("src : " + src);
// 	console.log("src2 : " + $("#big").attr("src"));
	
	//id가 big인 이미지 src 속성을 클릭한 작은 이미지의 속성으로 변경
	$("#big").attr("src",src);
}

//수량 감소 버튼 클릭 시
$(function() {
	$("#minus").click(function() {
// 		console.log("minus button clicked"); // 버튼 클릭 시 표시
		let result = 1;
		result = Number($("#selected_quantity").val()); // 선택한 수량 result 변수에 저장
// 		console.log("데이터타입 : " + typeof(result));
		if(result > 1) {
// 			console.log("result : " + result + "데이터타입 : " + typeof(result));
			result = result - 1;
			let price = result * $("#unit_price").val(); //가격 = 수량 * 단위가격
			$("#selected_quantity").val(result); //증가한 수량을 입력
			$("#amount").html(result); //증가한 수량을 입력
			$("#price").html(price); //총 가격 표시 자리에 계산한 금액 출력
		} else {
			$("#minus").disabled;
		}
	});
	
	
	
});

//수량 증가 버튼 클릭 시
$(function() {
	$("#plus").click(function() {
// 		console.log("plus button clicked"); // 버튼 클릭 시 표시
		let result = 1;
		result = Number($("#selected_quantity").val()); // 선택한 수량 result 변수에 저장
		console.log("데이터타입 : " + typeof(result));
		if(result > 0) {
// 			console.log("result : " + result + "데이터타입 : " + typeof(result));
			result += 1;
			let price = result * $("#unit_price").val(); //가격 = 수량 * 단위가격
			$("#selected_quantity").val(result);
			$("#amount").html(result);
			$("#price").html(price); //총 가격 표시 자리에 계산한 금액 출력

		} else {
			$("#plus").disabled;
		}
	});
});

//바로구매 버튼 클릭 시
$(function() {
	$("#buy").click(function() {
		console.log("바로구매 버튼 클릭됨");
		let order_store_item = ${Product.store_idx};
		let order_store_quantity = $("#amount").text();
		console.log("order_store_item = " + order_store_item + " , order_store_quantity" + order_store_quantity);
		location.href="StorePay?order_store_item=" + order_store_item + "&order_store_quantity=" + order_store_quantity; 
	});
	
});

</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<article id="articleForm">
		
			<div class="left">
				<div class="img">
					<div class="bigImage">
						<img src="${Product.store_img1}" id="big"/>
					</div>
					<div class="smallImages">
						<img src="${Product.store_img1}" id="small" onclick="showBig(this.src)"/>
						<img src="${Product.store_img2}" id="small" onclick="showBig(this.src)"/>
						<img src="${Product.store_img3}" id="small" onclick="showBig(this.src)"/>
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
					<div class="price">
						<h3>
							<fmt:formatNumber pattern="#,###" value="${Product.store_price}"/>원
						</h3>
					</div>
					<hr>
					<div class="goods_plus_info">
						<dl>
							<dt>카드 혜택</dt>
							<dd>신용카드 할인 안내</dd>
						</dl>
						<dl>
							<dt>배송비</dt>
							<dd>업체 무료배송</dd>
						</dl>
					</div>
					<div class="quantity">
<%-- 						<c:if test="${ }" disabled/> --%>
						<input type="button" value="-" id="minus" >
						<input type="number" id="selected_quantity" value="1">
						<input type="button" value="+" id="plus">
						
					</div>
					<input type="hidden" value="${Product.store_price}" id="unit_price">
					<div class="amount">
						총<span id="amount">1</span>개
						<span id="price">${Product.store_price}</span>원
					</div>
					<div class="btn-Area">
						<input type="button" value="장바구니" id="cart">
						<input type="button" value="바로구매" id="buy">
		 			</div>
				</div>
			</div>
			<div class="goods_view_area">
			
			</div>
	</article>


		 
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	
</body>
</html>