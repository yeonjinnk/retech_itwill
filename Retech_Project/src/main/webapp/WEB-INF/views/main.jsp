<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech 메인페이지</title>
<%-- 외부 CSS 파일(css/default.css) 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<%-- Google Fonts 'Roboto' 폰트 추가 --%>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
<style>
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
    
    
    
</style>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section class="main_section">
		<div class="main_slide">
		
		</div>
		<!-- 메인 이미지 -->
		<div class="main_category">
			<!-- 카테고리 -->
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
			<!-- 인기상품 -->
			<div class="pd_popular category_section">	
				<h2 class="category_subject">인기상품</h2>
				<div class="pd_popular_area area">
					<!-- 썸네일 이미지 -->
					<div class="pd_popular_photo photo">
						<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
					</div>
					<div class="pd_popular_photo photo">
						<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
					</div>
					<div class="pd_popular_photo photo">
						<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
					</div>
				</div>
			</div>		
			<!-- 최근 업데이트 상품 -->
			<div class="pd_recent category_section">	
				<h2 class="category_subject">최근 업데이트 상품</h2>
				<div class="pd_recent_area area">
					<div class="pd_recent_photo photo">
						<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
					</div>
					<div class="pd_recent_photo photo">
						<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
					</div>
					<div class="pd_recent_photo photo">
						<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
							<img src="${pageContext.request.contextPath }/resources/images/스크린샷 2024-07-17 212527.png" class="card-img-top">
						</a>
					</div>
				</div>
			</div>		
			
		</div>
	</section>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>