<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%-- 화면 크기에 맞춰 페이지의 뷰포트 설정 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Retech 메인페이지</title>

<%-- 외부 CSS 파일(css/default.css) 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">

<%-- Google Fonts 'Roboto' 폰트 추가 --%>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">

<%-- 부트스트랩 연결 --%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<%-- 외부 CSS 파일(css/main.css) 연결하기2 --%>
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
//버튼 클릭 시 페이지 상단으로 스크롤
function scrollToTop() {
    window.scrollTo({
        top: 0,
        behavior: "smooth" // 부드럽게 스크롤
    });
}
</script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section class="main_section">
	
		<!-- 메인 슬라이드 영역 -->
		<div class="main_slide">
			<div class="main_slide_container" >
				<div class="container">
				  <div id="myCarousel" class="carousel slide carousel-fade"  data-ride="carousel">
				   <!-- 슬라이드 효과(캐러셀) -->
				    <ol class="carousel-indicators">
				      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				      <li data-target="#myCarousel" data-slide-to="1"></li>
				      <li data-target="#myCarousel" data-slide-to="2"></li>
				    </ol>
				
				   <!-- 슬라이드 적용부분 -->
				    <div class="carousel-inner">
				      <div class="item active">
					      <div class="image-wrapper">
					        <img src="${pageContext.request.contextPath}/resources/img/main_slide/bgColor.png" alt="New York" id="item_bg3">
					        <img src="${pageContext.request.contextPath}/resources/img/main_slide/abcd123.png" alt="New York" style="width:100%; height:100%; position:sticky; z-index: 1;">
						</div>
				        <div class="carousel-caption item_inner" >
				          <h3>Better Choice, Re-tech</h3>
				          <p>더욱 스마트한 테크거래를 즐겨보세요!</p>
				        </div>
				      </div>
				      <div class="item">
					      <div class="image-wrapper">
					        <img src="${pageContext.request.contextPath}/resources/img/main_slide/darknavy.png" alt="Chicago" id="item_bg2">
					        <img src="${pageContext.request.contextPath}/resources/img/main_slide/tabletNetc2.png" alt="Chicago" style="width:100%; height:100%; position:sticky; z-index: 1;">
						</div>
				        <div class="carousel-caption item_inner" >
				          <h3>Tablet Coming Soon</h3>
				          <p>10월, 테블릿PC 카테고리 오픈 예정!</p>
				        </div>
				      </div>
				      <div class="item">
					      <div class="image-wrapper">
						    <img src="${pageContext.request.contextPath}/resources/img/main_slide/aquablue.png" alt="Los Angeles" id="item_bg1">
						    <img src="${pageContext.request.contextPath}/resources/img/main_slide/computerETC2.png" alt="Los Angeles" style="width: 100%; height: 100%; position:sticky; z-index: 1;">
						</div>
				        <div class="carousel-caption item_inner" >
				          <h3>리테크 Service Open</h3>
				          <p>PC, NOTEBOOK을 합리적인 가격으로 만나보세요!</p>
				        </div>
				      </div>
				    </div>
				
				    <!-- 슬라이드 방향 버튼 -->
				    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
				      <span class="glyphicon glyphicon-chevron-left"></span>
				      <span class="sr-only">Previous</span>
				    </a>
				    <a class="right carousel-control" href="#myCarousel" data-slide="next">
				      <span class="glyphicon glyphicon-chevron-right"></span>
				      <span class="sr-only">Next</span>
				    </a>
				  </div>
				</div>
			</div>
		</div>
		
				
		<!-- 메인 이미지 영역 -->
		<div class="main_img_area">
			<!-- 메인 이미지 영역 1. 카테고리 -->
			<div class="pd_category category_section">
			    <h3 class="category_subject">PC</h3>
			    <div class="pd_category_area area">
			        <div class="pd_category_photo photo" onclick="location.href='ProductList?c_id=PC&c_id2=AP'" style="cursor:pointer;">
			            <img src="${pageContext.request.contextPath }/resources/img/main_category/PCapple.png" style="width:50%;" class="inner_photo category_photo">
			            <div class="overlay">
			                <img src="${pageContext.request.contextPath }/resources/img/main_category/logo_apple.png" class="category_logo">
			            </div>
			        </div>
			        
			        <div class="pd_category_photo photo" onclick="location.href='ProductList?c_id=PC&c_id2=SA'" style="cursor:pointer;">
			            <img src="${pageContext.request.contextPath }/resources/img/main_category/PCsamsung.png" style="width:50%;" class="inner_photo category_photo">
			            <div class="overlay">
			                <img src="${pageContext.request.contextPath }/resources/img/main_category/logo_samsung.png" style="width:70%;" class="category_logo">
			            </div>
			        </div>
			
			        <div class="pd_category_photo photo" onclick="location.href='ProductList?c_id=PC&c_id2=LG'" style="cursor:pointer;">
			            <img src="${pageContext.request.contextPath }/resources/img/main_category/PClg.png" style="width:50%;" class="inner_photo category_photo">
			            <div class="overlay">
			                <img src="${pageContext.request.contextPath }/resources/img/main_category/logo_lg.png" style="width:70%;" class="category_logo">
			            </div>
			        </div>
			    </div>
			    
			    <h3 class="category_subject section_margin">노트북</h3>
			    <div class="pd_category_area area">
			        <div class="pd_category_photo photo" onclick="location.href='ProductList?c_id=NB&c_id2=AP'" style="cursor:pointer;">
			            <img src="${pageContext.request.contextPath }/resources/img/main_category/NBapple.png" style="width:50%;" class="inner_photo category_photo">
			            <div class="overlay">
			                <img src="${pageContext.request.contextPath }/resources/img/main_category/logo_apple.png" class="category_logo">
			            </div>
			        </div>
			
			        <div class="pd_category_photo photo" onclick="location.href='ProductList?c_id=NB&c_id2=SA'" style="cursor:pointer;">
			            <img src="${pageContext.request.contextPath }/resources/img/main_category/NBsamsung.png" style="width:50%;" class="inner_photo category_photo">
			            <div class="overlay">
			                <img src="${pageContext.request.contextPath }/resources/img/main_category/logo_samsung.png" style="width:70%;" class="category_logo">
			            </div>
			        </div>
			
			        <div class="pd_category_photo photo" onclick="location.href='ProductList?c_id=NB&c_id2=LG'" style="cursor:pointer;">
			            <img src="${pageContext.request.contextPath}/resources/img/main_category/NBlg.png" style="width:50%;" class="inner_photo category_photo">
			            <div class="overlay">
			                <img src="${pageContext.request.contextPath }/resources/img/main_category/logo_lg.png" style="width:70%;" class="category_logo">
			            </div>
			        </div>
			    </div>
			</div>
			
			<!-- 메인 이미지 영역 2. 인기상품 -->
			<div class="pd_popular category_section">    
			    <h2 class="category_subject section_margin">인기상품</h2>
			    <div class="pd_popular_area area">
			        <c:forEach var="product" items="${popularProducts}">
			            <div class="pd_popular_photo photo">
			                <a href="product_detail?pd_idx=${product.pd_idx}&member_id=${product.member_id}">
			                <img src="${pageContext.request.contextPath }/resources/img/main/${product.pd_image1}" 
    							 alt="${fn:substring(product.pd_image1, 11, fn:length(product.pd_image1))}" class="inner_photo"/>
			                </a>
					        <div class="photo_subject">${product.pd_subject}</div>
			            </div>
			        </c:forEach>
			    </div>
			</div>			

			<!-- 메인 이미지 영역 3. 최근 업데이트 상품 -->
			<div class="pd_recent category_section">    
			    <h2 class="category_subject section_margin">최근 업데이트 상품</h2>
			    <div class="pd_recent_area area">
				    <c:forEach var="product" items="${recentProducts}">
					    <div class="pd_recent_photo photo">
							<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
					        	<img src="${pageContext.request.contextPath }/resources/img/main/${product.pd_image1}" 
					        		 alt="${fn:substring(product.pd_image1, 11, fn:length(product.pd_image1))}" class="inner_photo"/>
					        </a>
					        <div class="photo_subject">${product.pd_subject}</div>
					    </div>
					</c:forEach>
			    </div>
			</div>		

			<!-- 페이지 맨 위로 이동하는 버튼 -->
			<button id="topBtn" class="scrollToTop" onclick="scrollToTop()">▲</button>

		</div>
	</section>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>