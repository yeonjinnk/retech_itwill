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


<style>

/*---- 메인 영역 제목  ----*/
.category_subject {
	font-size: 20px;
	font-weight: bold;
}

/*---- 메인 이미지 슬라이드 ----*/

.main_slide {
    box-sizing: border-box;
    width: 100%;
    max-width: 100%;
    overflow: hidden;
    position: relative;
    height: 450px; /* 메인 슬라이드의 높이 조정 */
    display: flex;     
    align-items: stretch;     
}

.main_slide_container {
    box-sizing: border-box;
    width: 100%;
    max-width: 100%;
    overflow: hidden;
    position: relative;
    height: 450px; /* 메인 슬라이드의 높이 조정 */
    display: flex;     
    align-items: stretch;     
}

.container {
    flex: 1;    /* Flexbox를 사용 */
    height: 100%;
	object-fit: cover;
 	padding: 0px;
}

.carousel-inner, .carousel {
    display: flex;
    position: relative;
    align-items: stretch;     
}


.item {
    will-change: transform, opacity;
}

.item {
    flex: 1; 
    object-fit: cover;
}
 
.image-wrapper {
    position: relative;
    width: 100%;
    height: 100%;
} 
 
#item_bg1, #item_bg2, #item_bg3 {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
} 
 
.carousel {
 	position: static; 
}

.carousel-inner {
    height: 450px; /* 항상 고정된 높이 유지 */
}

/* 페이드효과 */
.carousel-fade .carousel-inner .item {
  opacity: 0.8;
  transition-property: opacity;
  transition-duration: 0.3s;
  transition-timing-function: ease-in-out;
}

.carousel-fade .carousel-inner .item.active {
  opacity: 1;
}

.item img {
    width: auto; /* 이미지의 고정된 너비 사용 */
    height: auto; 
    max-height: 450px; /* 슬라이드의 높이에 맞게 고정된 높이 */
    object-fit: contain;  
    object-position: center; 
}

/*---- 메인 이미지 영역 ----*/
.main_section > div:not(.main_slide) {
	width: 1200px;
	align-items: center;
    margin: auto;
}

/*---- 메인 이미지 영역 ----*/
.category_section {
	margin-bottom: 40px;
}

.area {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.photo {
    width: 32%; /* 각 사진의 크기를 3개씩 한 줄에 배치할 수 있도록 설정 */
    margin-bottom: 20px; /* 이미지 아래쪽에 여백 추가 */
}

.photo a img {
    width: 100%; /* 이미지를 div 크기에 맞게 조정 */
}

 .pd_category_photo {
    position: relative;
    overflow: hidden; /* 텍스트나 이미지가 영역을 벗어나지 않도록 설정 */
}

.pd_category_photo img {
    transition: 0.3s ease; /* 이미지가 부드럽게 변화하도록 설정 */
    transform: scale(1); /* 기본 크기 설정 */
}

.pd_category_photo:hover img {
    filter: grayscale(100%); /* 흑백으로 변경 */
    opacity: 0.2; /* 불투명도 조정 */
    transform: scale(1.1); /* 마우스를 오버할 때 10% 확대 */
}

.pd_category_photo .overlay {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: gray;
    font-size: 24px;
    font-weight: bold;
    opacity: 0;
    transition: 0.6s ease;
}

.pd_category_photo:hover .overlay {
    opacity: 1; /* 마우스를 오버할 때 글자가 나타나도록 설정 */
}  
 
/*---- 메인 이미지(상품명) ----*/
.subject {
	font-size: 15px;
	font-weight: bold;
	text-align: center;
}

</style>

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
						    <img src="${pageContext.request.contextPath}/resources/img/main_slide/blue.png" alt="Los Angeles" id="item_bg1">
						    <img src="${pageContext.request.contextPath}/resources/img/main_slide/computerNetc.png" alt="Los Angeles" style="width: 100%; height: 100%; position:sticky; z-index: 1;">
						</div>
				        <div class="carousel-caption item_inner" >
				          <h3>Re-Tech Service Open</h3>
				          <p>PC, NOTEBOOK을 합리적인 가격으로 만나보세요!</p>
				        </div>
				      </div>
				      <div class="item">
					      <div class="image-wrapper">
					        <img src="${pageContext.request.contextPath}/resources/img/main_slide/orange.png" alt="New York" id="item_bg3">
					        <img src="${pageContext.request.contextPath}/resources/img/main_slide/ny.jpg" alt="New York" style="width:100%; height:100%; position:sticky; z-index: 1;">
						</div>
				        <div class="carousel-caption item_inner" >
				          <h3>New York</h3>
				          <p>We love the Big Apple!</p>
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
				<h2 class="category_subject">카테고리</h2>
				<div class="pd_category_area area">
					<div class="pd_category_photo photo">
						<a href="ProductList?c_id=PC&c_id2=AP">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
						<div class="overlay">애플 PC</div>
					</div>
					<div class="pd_category_photo photo">
						<a href="ProductList?c_id=PC&c_id2=SA">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
						<div class="overlay">삼성 PC</div>
					</div>
					<div class="pd_category_photo photo">
						<a href="ProductList?c_id=PC&c_id2=LG">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
						<div class="overlay">LG PC</div>
					</div>
				</div>
				<div class="pd_category_area area">
					<div class="pd_category_photo photo">
						<a href="ProductList?c_id=NB&c_id2=AP">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
						<div class="overlay">애플 노트북</div>
					</div>
					<div class="pd_category_photo photo">
						<a href="ProductList?c_id=NB&c_id2=SA">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
						<div class="overlay">삼성 노트북</div>
					</div>
					<div class="pd_category_photo photo">
						<a href="ProductList?c_id=NB&c_id2=LG">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
						<div class="overlay">LG 노트북</div>
					</div>
				</div>
			</div>
			
			
			<!-- 메인 이미지 영역 2. 인기상품 -->
			<div class="pd_popular category_section">    
			    <h2 class="category_subject">인기 상품</h2>
			    <div class="pd_popular_area area">
			        <c:forEach var="product" items="${popularProducts}">
			            <div class="pd_popular_photo photo">
			                <a href="product_detail?pd_idx=${product.pd_idx}&member_id=${product.member_id}">
			                <img src="${pageContext.request.contextPath}/resources/images/${product.pd_image1}" 
    							 alt="${fn:substring(product.pd_image1, 11, fn:length(product.pd_image1))}"/>
			                </a>
					        <div class="subject">${product.pd_subject}</div>
			            </div>
			        </c:forEach>
			    </div>
			</div>			


			<!-- 메인 이미지 영역 3. 최근 업데이트 상품 -->
			<div class="pd_recent category_section">    
			    <h2 class="category_subject">최근 업데이트 상품</h2>
			    <div class="pd_recent_area area">
				    <c:forEach var="product" items="${recentProducts}">
					    <div class="photo">
							<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
					        	<img src="${pageContext.request.contextPath}/resources/images/${product.pd_image1}" 
					        		 alt="${fn:substring(product.pd_image1, 11, fn:length(product.pd_image1))}"/>
					        </a>
					        <div class="subject">${product.pd_subject}</div>
					    </div>
					</c:forEach>
			    </div>
			</div>		
		</div>
	</section>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>