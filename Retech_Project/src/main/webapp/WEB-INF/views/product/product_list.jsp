<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/defualt.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<%-- 반응형웹페이지 위한 설정  --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Retech 상품목록</title>

<script type="text/javascript">
// 전역 변수 (함수바깥에 정의)
let pd_category;
let pd_status;
let isOpen = "false"; // 정렬 목록에 사용할 함수 기본값 false
let pageNum = 1; // 임의로 설정
let maxPage = 1; // 최대 페이지 번호 미리 저장

// 카테고리(최신순) 변수 정의
let selectedCategory = "전체";
let selectedSort = "최신순";
// (처음 상품 페이지에 들어왔을 시) 목록 불러오기
$(function() {
	//정렬 목록 open/close 함수
	$(".listInfoBtn").on("click", function() {
	    if(!isOpen) { // 정렬 목록이 열려있지 않다면
	        $(".listSort").css("display", "initial");
	        isOpen = true;
	    } else { // 정렬 목록이 열려 있다면
	        $(".listSort").css("display", "none");
	        isOpen = false;
	    }
	});

	

	$(document).on("click", function(event) {
       const target = $(event.target); // 클릭된 요소를 jQuery객체로 저장
       // 클릭된 요소(target)가 .listInfoBtn 또는 .listSort 내부에 포함되지 않은 경우(즉, 이들 외의 요소를 클릭한 경우)      
       if (!target.closest(".listInfoBtn").length && !target.closest(".listSort").length) {
           $(".listSort").css("display", "none"); //정렬 목록을 숨김
           isOpen = false; //목록이 닫힌 상태로 전환
       } 
	});	 // 정렬 목록이 열려있을 때 다른 곳을 누르면 목록 닫히게 하는 함수
	
	// 목록 정렬 순서 클릭 이벤트
	$(".listSort li").on("click", function() {
	    $(".listSort li").find('i').remove();
	    selectedSort = $(this).text().trim();
	    console.log("selectedCategory : " + selectedCategory);
	    console.log("selectedSort : " + selectedSort);
	    loadList(selectedCategory, selectedSort);
	    $('.listInfoBtn').text(selectedSort + ' ');
	    $('.listSort').hide();
	    isOpen = false; // 목록을 닫았으므로 isOpen을 false로 설정
	});

	
	// 카테고리 클릭 이벤트 함수
	$(document).ready(function() {
    // 카테고리 선택 이벤트
	    $("#categoryNav select").on("change", function () {
	        var selectedCategory = $("#c_id option:selected").val();  // 첫 번째 select 박스에서 선택된 값
	        console.log("선택된 카테고리: " + selectedCategory);
	        
	        // 선택된 카테고리 값을 화면에 출력
	        $("#selectedCategorySpan").text("선택된 카테고리: " + selectedCategory);
	        
	        // 카테고리 값에 따라 동작 수행 (예: 상품 목록 로드)
	        if(selectedCategory) {
	            loadList(selectedCategory, selectedSort);
	        }
	    });
	});
	
	// 제한없이 내려가는 스크롤 기능 추가
	// 웹브라우저의 스크롤바가 바닥에 닿으면 다음 목록 조회를 위해 loadList() 함수 호출
	$(window).on("scroll", function() {
		// window객체(웹페이지 내의 전체 브라우저 창)와 document 객체를 활용하여 
		// 스크롤 관련 값을 가져와 제어
		// => 스크롤바의 현재 위치, 문서가 표시되는 창(window)의 높이, 문서 전체 높이
		let scrollTop = $(window).scrollTop(); // 스크롤 바의 현재 높이를 가지고 옴
		let windowHeight = $(window).height(); // 브라우저 창의 높이를 가지고 옴
		let documentHeight = $(document).height(); // 문서의 높이를 가지고 옴(창의 높이보다 크거나 같음)
		let x = 50; // 여유값(픽셀 단위)
		//스크롤바의 위치값 + 창의 높이 + x가 문서 전체 높이(documentHeight)보다 클 경우
		//다음 페이지의 게시물 목록 로딩, 목록 하단에 추가
		if(scrollTop + windowHeight + x >= documentHeight){
			//최대 페이지 번호를 초과하면
			if(pageNum < maxPage) {
				pageNum++;
				loadList(selectedCategory, selectedSort);
			}
		}
		
	}); //window() 끝
}); // $(function(){}) 끝 => 28행에 있는 제이쿼리 시작부분

//목록 불러오는 함수 정의
function loadList(selectedCategory, selectedSort) {
	let url;
	
	// 컨트롤러로 보낼때 파라미터 처리
	url = "productListJson?pageNum=" + pageNum + "&pd_category=" + selectedCategory + "&sort=" + selectedSort;
	
	
	
	
	$.ajax({
		type: "GET",
		url: url,
		dataType: "JSON",
		success: function(data) {
// 			alert("글목록요청 성공");

			// 1. 
			maxPage = data.maxPage;
// 			console.log("maxPage : " + maxPage);
			// => 무한스크롤 시 
			
			
			//목록별 상품의 개수 조회 출력
			$("#listCount").text(data.listCount);
			
			// 기존에 있던 리스트 삭제
			$(".productListArea").empty();
			
			//ajax로받아온리스트 for문으로 반복출력하기
			for(let product of data.changedProductList) {
				let price = product.pd_price;
				let formatted_price = Number(price).toLocaleString('en');
				
				
				// 목록에 표시할 JSON 객체 1개 출력문 생성(= 1개 게시물) => 반복
				$(".productListArea").append(
						
						'<div class="col-lg-3 col-mid-4">'
						+'	<div class="card border-0" >'
						<!-- 썸네일이미지 -->
						+'		<div class="photoDiv">	'
						+'			<a href="product_detail?pd_idx=' + product.pd_idx + '&member_id= ' + product.member_id + '">'
						+'				<img src="${pageContext.request.contextPath }/resources/upload/' + product.pd_image1 +'" class="card-img-top" >'
						+'			</a>	'
						<!-- 찜하기 버튼 -->
						+'			<span class="likebtn" data-product-idx="' + product.pd_idx + '">'	
						+'				<a href="#" style="align:right;">'	
						+'					<img src="${pageContext.request.contextPath }/resources/images/heartIcon.png" width="30px" height="30px">'	
						+'				</a>'	
						+'			</span>'		
						<!-- 거래상태 버튼 -->
						+'			<span class="dealStatus"><button class="btn btn-dark">' + product.pd_status + '</button></span>'			
						+'		</div>'			
						+'		<div class="card-body">'		
									<!-- 카테고리 가져오기 -->
						+'			<div class="category" style="font-size:0.8rem; ">'
						+				product.pd_category
						+'			</div>'			
						+'			<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">'
										<!-- 제목 링크 -->
						+'				<a href="product_detail?pd_idx=' + product.pd_idx + '&member_id=' + product.member_id + '">'
						+					product.pd_subject		
						+'				</a>'
						+'			</div>'			
						+'			<p>' + product.pd_price + '원 </p>'			
						+'			<p>' + product.product_first_date + '</p>'
						+'		</div>'
						+'	</div>'
						+'</div>'
								
						
				); //append끝
			}	// for문 종료
			
		}, error: function() {
			alert("글 목록 요청 실패!");
		}
	});	// ajax 끝
	
} // loadList() 끝

</script>
<link href="${pageContext.request.contextPath}/resources/css/product/product_list.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
</header>
<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1로 설정) --%>
<c:set var="pageNum" value="1" />
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }"></c:set>
</c:if>
	<article id="mainArticle">
		<div class="container">
			<!-- 카테고리 선택 영역 -->
			<div id="category">
    <!-- 카테고리 및 거래상태 필터링 -->
	   <nav id="categoryNav">
		    <select class="select" id="c_id" name="c_id" style="width: 30%; height: 35px;">
		        <option value="">카테고리 선택</option>
		        <option value="PC">PC</option>
		        <option value="NB">노트북</option>
		    </select>
		    <select class="select" id="c_id2" name="c_id2" style="width: 30%; height: 35px;">
		        <option value="">제조사 선택</option>
		        <option value="SA">삼성</option>
		        <option value="AP">애플</option>
		        <option value="LG">LG</option>
		        <option value="ET">기타</option>
		    </select> 
		    <select class="select" id="c_id3" name="c_id3" style="width: 30%; height: 35px;">
		        <option value="">거래상태 선택</option>
		        <option value="판매중">판매중</option>
		        <option value="거래중">거래중</option>
		        <option value="판매완료">판매완료</option>
		    </select> 
		    <input type="hidden" name="pd_category" id="pd_category_hidden" value="${product.pd_category}">
		    <span id="selectedCategorySpan">
		        <!-- 선택된 카테고리 값을 여기에 출력 -->
		    </span>
		</nav>

</div><!-- 카테고리 끝 -->

			<!-- 상품갯수, 정렬 -->
			<div class="listInfo">
			    <span class="listInfoCount">전체 상품 <span id="listCount">${listCount}</span>개</span>
			    
			    <button class="listInfoBtn">
			        최신순 
			    </button>
			    <!-- 정렬 방법 (기본 형태는 보이지 않음, 클릭시 style 지우기) -->
			    <ul class="listSort" style="display: none;">
			        <li id="list1">최신순 </li>
			        <li id="list2">가격순 </li>
			        <li id="list3">인기순 </li>
			    </ul>
			</div>

			
			
			<!-- 목록표시 영역 -->
			<div class="row" align="left">
				<div class="productListArea">
					<c:forEach var="product" items="${productList}">
						<div class="col-lg-3 col-mid-4">
							<!-- 썸네일 이미지 -->
							<div class="photoDiv">
								<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
									<img src="${pageContext.request.contextPath }/resources/upload/${product.pd_image1}" class="card-img-top">
								</a>
							<!-- 찜하기 버튼 -->
								<span class="likebtn" data-product-idx="${product.pd_idx }">
									<a href="#" style="align:right;">
										<!-- 찜하기 버튼 이미지 찾아서 삽입 -->
										<img src="${pageContext.request.contextPath }/resources/images/heartIcon.png" width="30px" height="30px">'
									</a>
								</span>
								<!-- 거래상태 버튼 -->
								<span class="pd_status">
									<button class="btn btn-dark">${product.pd_status}</button>
								</span>
							</div>
							<div class="card-body">
								<!-- 카테고리 가져오기 -->
								<div class="category" style="font-size:0.8rem;">
									${product.pd_category }
								</div>
								<!-- 제목 링크 -->
								<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
									<a href="product_detail?pd_idx=${product.pd_idx}&member_id=${product.member_id}">
										${product.pd_subject}
									</a>
								</div>
								<p><fmt:formatNumber pattern="#,###" value="${product.pd_price }"/>원</p>
										
								<p>${product.pd_first_date }</p>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>			
		</div><%-- id container 부분 끝 --%>
	</article>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>