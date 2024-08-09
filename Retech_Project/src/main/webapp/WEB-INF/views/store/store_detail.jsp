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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">

// $(function() {
// 	$("#small1").click(src) {
// 		$("#big").src = src;
// 	}
// });

//이미지 바꾸기(작은 이미지 클릭 시 큰 이미지에 띄우기)
function showBig(src) {
// 	console.log("src : " + src);
// 	console.log("src2 : " + $("#big").attr("src"));
	
	//id가 big인 이미지 src 속성을 클릭한 작은 이미지의 속성으로 변경
	$("#big").attr("src",src);
}
</script>
<style>
#articleForm {
/* 		width: 100%; */
    margin: 30px 30px 30px 30px;
/*     padding: 40px 0 0 0; */
}

 .left { 
 	float:left; 
 	margin: 5px 50px 5px 200px;
} 

.right {
	float: right;
	padding: 5px 1000px 5px 50px;
/*     padding: 15px 0 30px 40px; */
}

/*  .img {  */
/* 	margin: 30px 30px 30px 30px; */
/*  }  */
.bigImage { /* 큰 사진 표시영역*/
	margin-bottom: 10px; /* 아래쪽 여백*/
}

#big { /* 큰 사진*/
	width: 300px;
	height: 300px;
}


#small { /* 작은 사진들*/
	width: 100px;
	height: 100px;
}



</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/inc/top2.jsp"></jsp:include>
	</header>
	<article id="articleForm">
		<div class="store-view">
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
	</article>


		 
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	
</body>
</html>