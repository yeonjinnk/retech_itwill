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
<link href="${pageContext.request.contextPath}/resources/css/defualt.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/product/product_list.css" rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
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
	
	slides[slideIndex-1].style.display = "block";
	dots[slideIndex-1].className += " active";
}


//거래상태 예약중일경우 채팅불가 처리하는 reservedProduct() 함수
function reservedProduct(){
	alert("예약중인 상품이므로 채팅하실 수 없습니다");
}
//찜하기 받아오기
$(function() {
	
	let sId = $("#sessionId").val();
		console.log(sId);
	$.ajax ({
		type: 'GET',
		url: 'likeProductShow',
		data: {'member_id' : sId},
		dataType: 'JSON',
		success: function(result) {
//			console.log(result);
			
			for(let i = 1; i <= 4; i++) {
				let ProductNo = $("" + $("#likeProduct" + i).data("target")).val();	
//					console.log(movieNo);
				
				for(let like of result) {
					if(like.pd_idx == ProductNo) {	// 일치하면
//							console.log(i);
// 						$("#likeMovie" + i).removeClass("btn-outline-danger");
// 						$("#likeMovie" + i).addClass("btn-danger");
// 						$("#likeMovie" + i).text("♡찜");
			    		$(element).find("images").attr("src", "${pageContext.request.contextPath}/resources/images/heartIcon.png");

						$("#clickCk" + i).attr("disabled", true);
					}
				}
			}
		},
		error: function() {
			alert("찜하기받아오기 에러!!");
// 			console.log("에러");
		}
	});
	
});// function 끝

//찜하기 기능
function checkProduct(element, i) {
	
	let sId = $("#sessionId").val();
//		console.log($(element).val());
	let secondhand_idx = $("" + $(element).data('target')).val();
	let targetId = 'clickCk' + i;
//		console.log(targetId);	// 타겟아이디
	let isLike = $("#" + targetId).prop("disabled");	// 찜 안했을 땐 false
		console.log(sId);	// 세션아이디 확인
		console.log(secondhand_idx);
		console.log(isLike);
	
	$.ajax({
		type: 'POST',
		url: 'likeProduct',
		data: {'member_id': sId, 
			   'secondhand_idx': secondhand_idx, 
			   'isLike': isLike },
		dataType: 'JSON',
		success : function(result) {
			alert("성공")
			console.log("성공!");
			console.log(isLike);
			
			if(isLike) {	// 찜 상태가 false면 => 이미지아이콘 변경하기 
// 				$(element).removeClass("btn-danger");
// 				$(element).addClass("btn-outline-danger");
// 				$(element).text("♡찜하기");
				$(element).find("images").attr("src", "${pageContext.request.contextPath}/resources/images/heartIcon.png");

				// 찜 상태 전환(false로)
				$("#" + targetId).attr("disabled", false);
				
			} else {	// 찜 상태가 true이면
// 				$(element).removeClass("btn-outline-danger");
// 				$(element).addClass("btn-danger");
// 				$(element).text("♡찜");
			    $(element).find("img").attr("src", "${pageContext.request.contextPath}/resources/images/heartIcon.png");

				
				// 찜 상태 전환(true로)
				$("#" + targetId).attr("disabled", true);
			}
		},
		error : function(xhr, status, error) {
		    console.error(error);
		}
		
	});	// ajax끝
	
} // 찜하기 버튼 클릭 함수 끝
</script>


<link href="${pageContext.request.contextPath}/resources/css/product/product_detail.css" rel="stylesheet" type="text/css">
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
					<%-- 상품이미지영역 - 슬라이드 --%>
					<div id="slid">
						<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="false">
							<ol class="carousel-indicators">
								<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
								<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
								<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
							</ol>
							<div class="carousel-inner">
								<div class="carousel-item active">
									<img src="${pageContext.request.contextPath }/resources/upload/${product.pd_image1}" class="d-block w-100" alt="Image 1">
								</div>
								<div class="carousel-item">
									<img src="${pageContext.request.contextPath }/resources/upload/${product.pd_image2}" class="d-block w-100" alt="Image 2">
								</div>
								<div class="carousel-item">
									<img src="${pageContext.request.contextPath }/resources/upload/${product.pd_image3}" class="d-block w-100" alt="Image 3">
								</div>
								<div class="carousel-item">
									<img src="${pageContext.request.contextPath }/resources/upload/${product.pd_image4}" class="d-block w-100" alt="Image 4">
								</div>
								<div class="carousel-item">
									<img src="${pageContext.request.contextPath }/resources/upload/${product.pd_image5}" class="d-block w-100" alt="Image 5">
								</div>
							</div>
							<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev"> <span
								class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span>
							</a> <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next"> <span
								class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span>
							</a>
						</div>
					</div>
				</div>
				<%-- 1행 1열 -- 왼쪽 column끝 --%>
				<!--------------------------------------------------------------------------------------------- -->
				<%--1행 2열 -- 오른쪽 column 추가하기 --%>
				<div class="column">
					<!-- 거래상태 -->
					<div class="row" style="padding: 20px;">
						<button class="btn btn-dark">${product.pd_status }</button>
						<span class="icon"> <%-- 신고 모달로 해보기 --%> <%-- 모달 출력 버튼 --%> <%-- 1.세션아이디 없을경우(미로그인) -> 로그인 모달창띄우고 로그인페이지로 이동 --%> <c:choose>
								<c:when test="${empty sessionScope.sId }">
									<button style="border: none;" data-toggle="modal" data-target="#needLogin">
										<img src="https://ccimage.hellomarket.com/img/web/item/detail/ico_report.png" alt="신고하기" class="TopNavigationIcon report" width="35px"
											height="35px">
									</button>
								</c:when>
								<%-- 2. 세션아이디 존재하는 경우(로그인상태) - 신고하기 모달창 --%>
								<c:otherwise>
									<button style="border: none;" data-target="#layerpop" data-toggle="modal">
										<img src="https://ccimage.hellomarket.com/img/web/item/detail/ico_report.png" alt="신고하기" class="TopNavigationIcon report" width="35px"
											height="35px">
									</button>
								</c:otherwise>
							</c:choose> 
						</span>
					</div>
					<!--------------------------------------------------------------------------------------------- -->
					<h3>${product.pd_subject}</h3>
					<p>
						<fmt:formatNumber pattern="#,###" value="${product.pd_price }" />
						원
					</p>
					<div class="row" style="margin-left: 2px;">
						<span class="readcount">조회수 ${product.pd_readcount } </span> <span class="registDate">등록일 ${product.pd_first_date }</span>
					</div>
					<hr>
					<p>${product.pd_content }</p>
					<br>
					<hr>
					<%-- 
					sessionId 일치하는경우 (판매자본인일경우) - 수정하기 / 삭제하기 버튼 활성화 
					-> 페이지이동시 상품번호,페이지번호 파라미터로 전달
					
					sessionId 일치하지 않는경우 or 없는경우 : 채팅하기 버튼 보여줌
					=> 없는경우 채팅버튼 누를경우 : 로그인알람창 -> 로그인페이지 이동
				--%>
					<c:choose>
						<%-- 1. 세션아이디 존재하고, 세션아이디=판매자아이디 동일할 경우 --%>
						<%-- 1-1. 수정하기, 삭제하기, 끌어올리기 영역 노출 --%>
						<c:when test="${not empty sessionScope.sId && sessionScope.sId eq product.member_id}">
							<button class="btn btn-dark col-3" style="font-size: 1em; margin: 10px 10px"
								onclick="location.href='productModifyForm?pd_idx=${product.pd_idx}&member_id=${product.member_id }'">수정하기</button>

							<button class="btn btn-dark col-3" style="font-size: 1em; margin: 10px 10px" onclick="confirmDelete()">삭제하기</button>

							<button class="btn btn-dark col-3" style="font-size: 1em; margin: 10px 10px"
								onclick="location.href='productUpdateDate?pd_idx=${product.pd_idx}&member_id=${product.member_id }'">끌어올리기</button>
						</c:when>
						<%-- 2.판매자 본인 아닐경우 - 채팅하기 가능 --%>
						<c:otherwise>
							<div class="chatButtonArea row">
								<%-- 2-1.세션아이디 없을경우(미로그인) -> 로그인알람창띄우고 로그인페이지로 이동 --%>
								<c:if test="${empty sessionScope.sId }">
									<%--찜하기기능 --%>
									<%-- 찜하기 버튼 클릭 시 pd_idx 파라미터로 받아 전달 --%>
									<input type="hidden" name="member_id" value="${sessionScope.sId }" id="sessionId">
									<input type="hidden" name="pd_idx" value="${product.pd_idx}" id="pd_idx${i.count }">
									<c:choose>
										<%--회원이나 직원이('비회원'이 아닐 때) 세션 아이디가 있을 때(로그인o) 찜하기 기능--%>
										<%-- 찜하기 목록에 있으면 찜 표시
									     찜하기 목록에 없으면 그대로 표시--%>
										<%--세션 아이디가 없을 때(로그인x) 모달창으로 로그인권유--%>
										<c:when test="${not empty sessionScope.sId}">
											<button type="button" id="likeProduct${i.count }" data-target="secondhand_idx${i.count }" value="${i.count }"
												onclick="checkProduct(this, ${i.count })">
												<img src="${pageContext.request.contextPath }/resources/images/heartIcon.png" width="40px" height="40px">
											</button>
											<input type="hidden" id="clickCk${i.count }">
										</c:when>
										<%-- 세션아이디가 없거나 비회원일 때 -> 클릭 시 모달창 팝업 --%>
										<c:otherwise>
											<%-- 찜하기 버튼과 버튼 클릭 시 상태 변경용 히든 타입 태그 --%>
											<button type="button" id="likeProductNo${i.index }" data-toggle="modal" data-target="#needLogin">
												<img src="${pageContext.request.contextPath }/resources/images/heartIcon.png" width="40px" height="40px">
											</button>
										</c:otherwise>
									</c:choose>
									<div class="d-grid gap-2 col-10">
										<button class="btn btn-lg btn-dark col-12" id="chatting" data-toggle="modal" data-target="#needLogin"
											style="font-size: 1em; margin: 10px 10px">거래하기</button>
									</div>
								</c:if>
								<%--2.2 세션아이디 있을경우(판매자아닌 일반회원) -> 채팅하기 누를경우 채팅창으로 이동 --%>
								<c:if test="${not empty sessionScope.sId && sessionScope.sId ne product.member_id }">
									<%-- 찜하기 버튼 클릭 시 pd_idx 파라미터로 받아 전달 --%>
									<input type="hidden" name="member_id" value="${sessionScope.sId }" id="sessionId">
									<input type="hidden" name="product_idx" value="${product.pd_idx}" id="pd_idx${i.count }">
									<c:choose>
										<%--
								회원이나 직원이('비회원'이 아닐 때)
								세션 아이디가 있을 때(로그인o) 찜하기 기능
									- 찜하기 목록에 있으면 찜 표시
									- 찜하기 목록에 없으면 그대로 표시
								세션 아이디가 없을 때(로그인x) 모달창으로 로그인권유,
								--%>
										<c:when test="${not empty sessionScope.sId}">
											<button type="button" id="likeProduct${i.count }" data-target="pd_idx${i.count }" value="${i.count }"
												onclick="checkProduct(this, ${i.count })">
												<img src="${pageContext.request.contextPath }/resources/images/heartIcon.png" width="40px" height="40px">
											</button>
											<input type="hidden" id="clickCk${i.count }">
										</c:when>
										<%-- 세션아이디가 없거나 비회원일 때 -> 클릭 시 모달창 팝업 --%>
										<c:otherwise>
											<%-- 찜하기 버튼과 버튼 클릭 시 상태 변경용 히든 타입 태그 --%>
											<button type="button" id="likeProductNo${i.index }" data-toggle="modal" data-target="#needLogin">
												<img src="${pageContext.request.contextPath }/resources/images/heartIcon.png" width="40px" height="40px">
											</button>
										</c:otherwise>
									</c:choose>
									<%--
							 거래상태 '예약중'일경우, 채팅하기 버튼 누를경우 
							'예약중인상품이므로 채팅하기를 하실 수 없습니다' 알람창만 띄우기 
							--%>
									<c:choose>
										<c:when test="${product.pd_status eq '거래중' }">
											<input type="button" class="btn btn-lg btn-dark col-10" style="font-size: 1em;" value="채팅하기" onclick="reservedProduct()">
										</c:when>
										<%--- 거래상태 예약중이아닐경우 채팅하기로 정상적으로 이동 --%>
										<c:otherwise>
										<button type="button" class="btn btn-lg btn-dark col-12" style="font-size: 1em;" onclick="openChat()">
												채팅하기
											</button>
											<%--- <form action="doChat" method="POST" class="col col-10">
												<input type="hidden" value="${product.member_id }" name="seller_id"> <input type="hidden" value="${product.pd_idx }" name="pd_idx">
												<div class="d-grid gap-2">
													<input type="submit" class="btn btn-lg btn-dark col-12" style="font-size: 1em;" value="채팅하기">
												</div>
											</form>	--%>
										</c:otherwise>
									</c:choose>
								</c:if>
							</div>
						</c:otherwise>
					</c:choose>
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
				<hr>
				<hr>
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
								<c:when test="${not empty seller.member_image }">
									<img src="${pageContext.request.contextPath }/resources/upload/${seller.member_image}" width="120px" height="120px"
										style="margin: 20px; border-radius: 50%;">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" width="120px" height="120px"
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
						<a href="MyPageMain?sId=${product.member_id}"> 더보기 </a>
					</div>
					<%--썸네일이미지 --%>
					<%-- 판매자의 물품 개수만큼 반복표시 --%>
					<div class="row">
						<c:forEach var="sellerProductList" items="${sellerProductList }" varStatus="loop">
							<c:if test="${loop.index lt 4}">
								<%--판매자의 첫번째상품의 첫번째이미지(썸네일이미지)만 보여줌 --> 판매상품여러개일수도 -> 리스트로 받아옴 --%>
								<%--네개까지만 받아오기 --%>
								<%--각이미지마다 상품 상세페이지로 이동하는 하이퍼링크 --%>
								<span class="sumnail"> <a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}"> <img
										class="democursor" src="${pageContext.request.contextPath }/resources/upload/${product.pd_image1}" style="width: 130px; height: 160px;">
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
								<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath }/member_login'">로그인</button>
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
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>