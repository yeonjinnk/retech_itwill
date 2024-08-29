<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech 관리자페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/admin_top.jsp"></jsp:include>	
	</header>
	<div class="inner">
			<section class="wrapper">
				<jsp:include page="/WEB-INF/views/inc/admin_side_nav.jsp"></jsp:include>
				<article>
				</article>
			</section>
		</div>
	<footer>
<%-- 		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	 --%>
	</footer>
</body>
</html>