<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/store/store_pay.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
<script type="text/javascript">
	$(function (){
		$("#buyOrderStoreHistory").on('click', function() {
	//         var productId = $C(this).data('id');
	        window.location.href = '${pageContext.request.contextPath}/PurchaseStoreHistory';
	    });
		
	});
	
</script>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<article id="articleForm">
		<h1>결제 완료!</h1>
		<button type="button" id="buyOrderStoreHistory">구매내역 보기</button>
		
	</article>
		<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>