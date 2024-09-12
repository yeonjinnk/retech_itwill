<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Retech 상품 상세페이지</title>

<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<%-- <link href="${pageContext.request.contextPath}/resources/css/defualt.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/product/product_list.css" rel="stylesheet" type="text/css">
<style type="text/css">
.container {
    max-width: 900px;
    margin: 0 auto;
    padding: 20px;
    }
.w-100 {
    width: 900px !important;
    height: 300px;    
}
img {
    vertical-align: middle;
    border-style: none;
    width: 175px;
}
</style>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<%-- 반응형웹페이지 위한 설정  --%>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Retech 상품 상세페이지</title>
<script type="text/javascript">
	//삭제작업 -- 게시물삭제확인창
	function confirmDelete() {
		let isDelete = confirm("정말 삭제하시겠습니까?");
		
		// isDelete 가 true 일 때 BoardDelete 서블릿 요청
		if(isDelete) {
			location.href='productDelete?pd_idx=${param.pd_idx}';
		}
	}
</script>



<script type="text/javascript">
//슬라이드인덱스
let slideIndex = 1;//슬라이드인덱스 기본값 1
showSlides(slideIndex);


function currentSlide(n) {
  showSlides(slideIndex = n);
}
function showSlides(n) {
	let i;
	let slides = document.getElementsByClassName("mySlides");
	let dots = document.getElementsByClassName("democursor");

	
	if (n > slides.length) {
		  slideIndex = 1
	}
	
	if (n < 1) {
		slideIndex = slides.length//인덱스 1보다 작을경우 슬라이드크기(최대치) 대입
	}
	
	for (i = 0; i < slides.length; i++) {
    	slides[i].style.display = "none";//
	}
	
	for (i = 0; i < dots.length; i++) {
		dots[i].className = dots[i].className.replace(" active", "");
	}
	
// 	slides[slideIndex-1].style.display = "block";
// 	dots[slideIndex-1].className += " active";
}



//거래상태 예약중일경우 채팅불가 처리하는 reservedProduct() 함수
function reservedProduct(){
	alert("거래중인 상품이므로 채팅하실 수 없습니다");
}
//찜하기 받아오기
$(function() {
	console.log("!!!!!!페이지 로딩됨 !!!!!");
	
	   let pd_idx = "${product.pd_idx}";
	    
	    // 서버에서 찜 상태를 가져오는 AJAX 요청
	    $.ajax({
	        type: 'GET',
	        url: 'checkLikeStatus',
	        data: {
	            'member_id': "${sessionScope.sId}",
	            'pd_idx': "${param.pd_idx}"
	        },
	        dataType: 'JSON',
	        success: function(result) {
	            if (result) {
	                $("#likeImage").attr("src", "${pageContext.request.contextPath}/resources/images/heartIcon2.png");
	                $("#likeProduct").addClass("like");
	                localStorage.setItem(pd_idx, "liked");
	            } else {
	                $("#likeImage").attr("src", "${pageContext.request.contextPath}/resources/images/heartIcon3.png");
	                $("#likeProduct").removeClass("like");
	                localStorage.removeItem(pd_idx);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 오류: ", error);
	        }
	    });
	
	
	
});// function 끝


//찜하기 기능
function checkProduct(element) {
    let member_id = "${sessionScope.sId}";
    let pd_idx = "${product.pd_idx}";
    console.log("member_id 값: " + member_id);  // 이 값을 콘솔에서 확인
    console.log("pd_idx 값: " + pd_idx);  // 이 값을 콘솔에서 확인
    // 현재 버튼의 찜 상태 확인
    let isLike = $("#likeProduct").hasClass("like");
    console.log(isLike);
    $.ajax({
        type: 'POST',
        url: 'likeProduct',
        data: {
            'member_id': member_id,
            'pd_idx': pd_idx,
            'isLike': isLike
        },
        dataType: 'JSON',
        success: function(result) {
            alert("성공");
            console.log("서버 응답: ", result);

            if (isLike) { // 찜 상태일 때 해제 상태로 전환 (isLike가 true일 때)
            	$("#likeImage").attr("src", "${pageContext.request.contextPath}/resources/images/heartIcon3.png");
            	$("#likeProduct").removeClass("like"); // 좋아요 제거
            	localStorage.setItem(pd_idx, "liked"); // 클라이언트 측 저장
            } else { // 찜 해제 상태일 때 찜 상태로 전환 (isLike가 false일 때)
            	$("#likeImage").attr("src", "${pageContext.request.contextPath}/resources/images/heartIcon2.png");
            	$("#likeProduct").addClass("like"); // 좋아요 표시
            	localStorage.removeItem(pd_idx); // 클라이언트 측 저장
            }
        },
        error: function(xhr, status, error) {
        	 console.error("AJAX 오류: ", error);
        }
    }); // ajax 끝
}
//페이지 로드 시 찜 상태 복원
$(document).ready(function() {
});

</script>
<style type="text/css">


</style> 
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<%--신고작업을 위해 히든타입으로 데이터 넘기기 --%>
	<article id="mainArticle">
		<div class="container">
			<hr>
			<%-- 큰이미지 --%>
			<div class="row" style="margin-top: 20px;">
				<div class="column">
					<div id="slid">
                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="false">
                        <ol class="carousel-indicators">
                            <c:if test="${not empty product.pd_image1}">
                                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            </c:if>
                            <c:if test="${not empty product.pd_image2}">
                                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                            </c:if>
                            <c:if test="${not empty product.pd_image3}">
                                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                            </c:if>
                            <c:if test="${not empty product.pd_image4}">
                                <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                            </c:if>
                            <c:if test="${not empty product.pd_image5}">
                                <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
                            </c:if>
                        </ol>
                        <div class="carousel-inner">
                            <c:if test="${not empty product.pd_image1}">
                                <div class="carousel-item active">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image1}" class="d-block w-100" alt="Image 1">
                                </div>
                            </c:if>
                            <c:if test="${not empty product.pd_image2}">
                                <div class="carousel-item">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image2}" class="d-block w-100" alt="Image 2">
                                </div>
                            </c:if>
                            <c:if test="${not empty product.pd_image3}">
                                <div class="carousel-item">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image3}" class="d-block w-100" alt="Image 3">
                                </div>
                            </c:if>
                            <c:if test="${not empty product.pd_image4}">
                                <div class="carousel-item">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image4}" class="d-block w-100" alt="Image 4">
                                </div>
                            </c:if>
                            <c:if test="${not empty product.pd_image5}">
                                <div class="carousel-item">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image5}" class="d-block w-100" alt="Image 5">
                                </div>
                            </c:if>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
					
					<!-- 미리보기 썸네일 추가 -->
					 <div class="thumbnails">
	                    <c:if test="${not empty product.pd_image1}">
	                        <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image1}" class="thumbnail" data-target="#carouselExampleIndicators" data-slide-to="0" alt="Thumbnail 1">
	                    </c:if>
	                    <c:if test="${not empty product.pd_image2}">
	                        <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image2}" class="thumbnail" data-target="#carouselExampleIndicators" data-slide-to="1" alt="Thumbnail 2">
	                    </c:if>
	                    <c:if test="${not empty product.pd_image3}">
	                        <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image3}" class="thumbnail" data-target="#carouselExampleIndicators" data-slide-to="2" alt="Thumbnail 3">
	                    </c:if>
	                    <c:if test="${not empty product.pd_image4}">
	                        <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image4}" class="thumbnail" data-target="#carouselExampleIndicators" data-slide-to="3" alt="Thumbnail 4">
	                    </c:if>
	                    <c:if test="${not empty product.pd_image5}">
	                        <img src="${pageContext.request.contextPath}/resources/upload/${product.pd_image5}" class="thumbnail" data-target="#carouselExampleIndicators" data-slide-to="4" alt="Thumbnail 5">
	                    </c:if>
	                </div>
					<%-- 1행 1열 -- 왼쪽 column끝 --%>
				<!--------------------------------------------------------------------------------------------- -->
				<%--1행 2열 -- 오른쪽 column 추가하기 --%>
				<div class="column">
					<!-- 거래상태 -->
					<div class="row" style="padding: 20px;">
						<button class="btn btn-dark">${product.pd_status }</button>
					</div>
					<!--------------------------------------------------------------------------------------------- -->
					<h3>${product.pd_subject}</h3>
					<p>
						<fmt:formatNumber pattern="#,###" value="${product.pd_price }" />
						원
					</p>
					<hr>
					<div class="row" style="margin-left: 2px;">
						<span class="readcount">조회수 ${product.pd_readcount } </span> 
					</div>
					<hr>
					<div class="row" style="margin-left: 2px;">
						<span class="registDate">등록일 ${product.pd_first_date }</span>
					</div>
					<hr>
					<p>${product.pd_content }</p>
					<br>
					<hr>
					<%-- sessionId 일치하는경우 (판매자본인일경우) - 수정하기 / 삭제하기 버튼 활성화 
						-> 페이지이동시 상품번호,페이지번호 파라미터로 전달
						sessionId 일치하지 않는경우 or 없는경우 : 채팅하기 버튼 보여줌
						=> 없는경우 채팅버튼 누를경우 : 로그인알람창 -> 로그인페이지 이동 --%>
						
<%--=========================================================================================================================== --%>

						<%-- 1. 세션아이디 존재하고, 세션아이디=판매자아이디 동일할 경우 --%>
						<%-- 1-1. 수정하기, 삭제하기, 끌어올리기 영역 노출 --%>
<%-- 					<input type="hidden" name="member_id" value="${sessionScope.sId }" id="sessionId"> --%>
<%-- 					<input type="hidden" name="pd_idx" value="${product.pd_idx}" id="pd_idx"> --%>
					
					<c:choose>
						<%-- 로그인 안 했을 경우 --%>
						<c:when test="${empty sessionScope.sId}">
							
							<button type="button" id="likeProduct" data-toggle="modal" data-target="#needLogin" class="" onclick="checkProduct(this)">
							    <img src="${pageContext.request.contextPath}/resources/images/heartIcon3.png" id="likeImage" width="40px" height="40px">
							</button>
							
							<div class="d-grid gap-2 col-10">
								<button class="btn btn-lg btn-dark col-12" id="chatting" data-toggle="modal" data-target="#needLogin"
									style="font-size: 1em; margin: 10px 10px">거래하기</button>
							</div>
						</c:when>
						<c:when test="${not empty sessionScope.sId}">
							<%-- 로그인 했을 경우 --%>
							<c:choose>
								<c:when test="${sessionScope.sId eq product.member_id}"> <%-- 접속자가 현재 상품의 판매자일 경우 --%>
									<button class="btn btn-dark col-3" style="font-size: 1em; margin: 10px 10px"
										onclick="location.href='productModifyForm?pd_idx=${product.pd_idx}&member_id=${product.member_id }'">수정하기</button>
		
									<button class="btn btn-dark col-3" style="font-size: 1em; margin: 10px 10px" onclick="confirmDelete()">삭제하기</button>
		
									<button class="btn btn-dark col-3" style="font-size: 1em; margin: 10px 10px"
										onclick="location.href='productUpdateDate?pd_idx=${product.pd_idx}&member_id=${product.member_id }'">끌어올리기</button>
								</c:when>
								<c:otherwise> <%-- 접속자가 현재 상품의 판매자가 아닐 경우--%>
									<%-- 찜하기 버튼 --%>
									<button type="button" id="likeProduct" data-target="pd_idx" class="" onclick="checkProduct(this)">
									    <img src="${pageContext.request.contextPath}/resources/images/heartIcon3.png" id="likeImage" width="40px" height="40px">
									</button>
									
									<%-- 거래하기 버튼 --%>
									<c:choose>
										<c:when test="${product.pd_status eq '거래중' }">
												<input type="button" class="btn btn-lg btn-dark col-10" style="font-size: 1em;" value="거래하기" onclick="reservedProduct()">
										</c:when>
											<%--- 거래상태 거래중이아닐경우 채팅하기로 정상적으로 이동 --%>
										<c:otherwise>
											<button type="button" class="btn btn-lg btn-dark col-12" style="font-size: 1em;" onclick="openChat()">
												거래하기
											</button>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:when>
					</c:choose>	
<%--=========================================================================================================================== --%>
						
				</div>
				<%-- 오른쪽 column끝 --%>
				<hr>
			</div>
			<%-- 첫번째 row끝 ----%>

<script type="text/javascript">
	function openChat() {
		console.log("채팅하기 클릭 시 openChat 함수 호출됨!");
		let receiver_id = "${param.member_id}";
		let pd_idx = "${param.pd_idx}";
		
		window.open('ChatRoom?receiver_id=' + receiver_id + '&pd_idx=' + pd_idx, receiver_id + ', ' + pd_idx, 'width=600px,height=600px');
	}
</script>
			<%-------------------- 두번째 row 시작 ------------------------------%>
			<div class="row" style="margin-top: 30px;">
				<%-- 2행 1열 (카테고리 결제방법 거래방법) --%>
				<div class="column">
					<hr>
					<p>
						<b>카테고리</b>
						<button class="btn btn-light" style="align: left;">${product.pd_category }</button>
						<br>
					</p>
				</div>
				<!-- 판매자탭--------------------------------------------------------------------------------- -->
				<%-- 2행 2열 (판매자정보) --%>
				<div class="column">
					<hr>
					<%-- 판매자 프로필, 닉네임, 판매상품수 --%>
					<div class="row">

						<%-- 판매자 프로필 --%>
						<div class="column">
							<c:choose>
								<c:when test="${not empty seller.member_profile }">
									<img src="${pageContext.request.contextPath }/resources/upload/${seller.member_profile}" width="120px" height="120px"
										style="margin: 20px; border-radius: 50%;">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath }/resources/images/blank_profile.png" width="120px" height="120px"
										style="margin: 20px; border-radius: 50%;">
								</c:otherwise>
							</c:choose>
						</div>

						<%-- 판매자 닉네임 --%>
						<div class="column">
							<b><a href="productSeller?member_id=${member.member_id }">${member.member_nickname } </a></b>
							<%-- 판매자의 판매하는 상품의 개수 --%>
							<br>판매상품 ${sellerProduct } 개
						</div>
					</div>
					<%-- 판매자의 판매중 다른상품정보 --%>
					<br>
					<div class="row" style="margin-left: 10px; margin-bottom: 10px;">
						<b>${seller.member_nickname }</b> 님의 판매중인 상품 ... 
						<a href="SaleHistory?member_id=${product.member_id}"> 더보기 </a>
					</div>
					<%--썸네일이미지 --%>
					<%-- 판매자의 물품 개수만큼 반복표시 --%>
					<div class="row">
						<c:forEach var="sellerProductList" items="${sellerProductList }" varStatus="loop">
							<c:if test="${loop.index lt 4}">
								<%--판매자의 첫번째상품의 첫번째이미지(썸네일이미지)만 보여줌 --> 판매상품여러개일수도 -> 리스트로 받아옴 --%>
								<%--네개까지만 받아오기 --%>
								<%--각이미지마다 상품 상세페이지로 이동하는 하이퍼링크 --%>
								<span class="sumnail"> 
									<a href="product_detail?pd_idx=${sellerProductList.pd_idx }&member_id=${sellerProductList.member_id}"> <img
									class="democursor" src="${pageContext.request.contextPath }/resources/upload/${sellerProductList.pd_image1}" style="width: 130px; height: 160px;">
								</a>
								</span>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>

		</div>
		<%--container 끝 --%>

		<!-- 모달 --------------------------------------------------------------------------------- -->

		<%-- 찜하기 안내 모달 영역 --%>
		<div class="modal fade" id="needLogin" tabindex="-1" role="dialog" aria-labelledby="needSessionId" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="needSessionId">로그인 안내</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body text-center" id="modalMsg">
						<%-- 메세지가 표시되는 부분 --%>
						회원 로그인이 필요한 작업입니다. 로그인 하시겠습니까?
					</div>
					<div class="modal-footer justify-content-center">
						<c:choose>
							<c:when test="${empty sessionScope.member_id}">
								<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath }/MemberLogin'">로그인</button>
								<button type="button" class="btn btn-light" data-dismiss="modal" aria-label="Close">아니오</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">확인</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>