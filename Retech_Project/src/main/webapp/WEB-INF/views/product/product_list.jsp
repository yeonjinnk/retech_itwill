<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<%-- 반응형웹페이지 위한 설정  --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Retech 상품목록</title>
<script type="text/javascript">
let isLike = $("#likeProduct").hasClass("like");
//메인페이지 카테고리 이미지에서 이동 시, 필터링 된 상품목록 불러오기
$(document).ready(function() {
    // URLSearchParams 객체를 사용하여 URL 파라미터 값을 가져오기
    let urlParams = new URLSearchParams(window.location.search);
    // URL 파라미터에서 값을 가져와서 select 박스의 값으로 설정하기
    let c_id = urlParams.get('c_id');
    let c_id2 = urlParams.get('c_id2');
    let c_id3 = urlParams.get('c_id3');
    // 해당 값에 따라 select 박스에서 선택된 상태로 변경합니다.
    if (c_id) $('#c_id').val(c_id);
    if (c_id2) $('#c_id2').val(c_id2);
    if (c_id3) $('#c_id3').val(c_id3);
    //여기서 지정
	let pageNum = 1; // 임의로 설정
	
    let resetPage = true;
// 	loadList(selectedCategory, selectedSort, resetPage); // 이 함수가 실행되서 productList가 아니라 productListJson까지 다 같이 실행이 되버려서 계속 전체 상품 목록 좋
});
</script>


<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
    const dateElements = document.querySelectorAll('.productDate');

    dateElements.forEach(function(element) {
        const dateStr = element.getAttribute('data-date');
        if (dateStr === '날짜 정보 없음') {
            return;
        }

        const date = new Date(dateStr);
        const now = new Date();

        // 날짜를 비교하기 위해 현재 시간의 날짜 부분만 사용
        const diffTime = now - date;
        const dayDiff = Math.floor(diffTime / (1000 * 60 * 60 * 24));
        const hoursDiff = Math.floor(diffTime / (1000 * 60 * 60));
        const minutesDiff = Math.floor(diffTime / (1000 * 60));

        let timeAgo;
        if (dayDiff == 0) {
        	if (hoursDiff === 0) {
        		timeAgo = minutesDiff + "분 전";
        	} else {
        		timeAgo = hoursDiff + "시간 전";
        	}
        } else {
        		timeAgo = dayDiff + "일 전";
        }

        // 텍스트를 변경
        element.textContent = timeAgo;
    });
});


let isOpen = false; // 정렬 목록에 사용할 함수 기본값 false
let pageNum = 1; // 임의로 설정
let maxPage = 1; // 최대 페이지 번호 미리 저장
let isLoading = false; // AJAX 요청이 진행 중인지 확인
let selectedCategory = "전체"; // 기본값 설정
let selectedSort = "최신순"; // 기본값 설정

$(function() {
    // 정렬 목록 open/close 함수
    $(".listInfoBtn").on("click", function() {
        if (!isOpen) {
            $(".listSort").css("display", "initial");
            isOpen = true;
        } else {
            $(".listSort").css("display", "none");
            isOpen = false;
        }
    });

    $(document).on("click", function(event) {
        const target = $(event.target);
        if (!target.closest(".listInfoBtn").length && !target.closest(".listSort").length) {
            $(".listSort").css("display", "none");
            isOpen = false;
        }
    });

    $(".listSort li").on("click", function() {
    	pageNum = 1;
        selectedSort = $(this).text().trim();
        loadList(selectedCategory, selectedSort, true);
        $('.listInfoBtn').text(selectedSort + ' ');
        $('.listSort').hide();
        isOpen = false;
    });

    // 카테고리 변경 이벤트 핸들러
    $("#categoryNav select").on("change", function () {
    	pageNum = 1; // pageNum을 카테고리를 클릭하면 1로 고정해서 처음행부터 해당 페이지 행까지 다시 불러옴
        selectedCategory = $("#c_id option:selected").val();   // 첫 번째 select 박스에서 선택된 값
        var selectedManufacturer = $("#c_id2 option:selected").val();  // 두 번째 select 박스에서 선택된 값
        var selectedPdStatus = $("#c_id3 option:selected").val();  // 세 번째 select 박스에서 선택된 값



        // 목록 로드
        loadList(selectedCategory, selectedSort, true);
	 });
	
	    $(window).on("scroll", function() {
	        if (isLoading) return;
			console.log("스크롤 작동함!");
	        let scrollTop = $(window).scrollTop();
	        let windowHeight = $(window).height();
	        let documentHeight = $(document).height();
	        let threshold = 50;
	
	        if (scrollTop + windowHeight + threshold >= documentHeight) {
			console.log("첫번째 if문 진입!");
			console.log("pageNum" + pageNum);
			console.log("maxPage" + maxPage);
			
			//연진 수정 부분!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	        	let param = "${param.searchKeyword}";
			console.log("param 파라미터어어!!!!!!!" + param);
	            if (param == "") {
			console.log("두번째 if문 진입!");
	                pageNum++;
	                isLoading = true;
	                loadList(selectedCategory, selectedSort, false);
	            }
	        }
	    	//연진 수정 부분!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	    });
	    
});

function loadList(selectedCategory, selectedSort, resetPage) {
	console.log("loadList");
    let url;
    var selectedCategory = $("#c_id option:selected").val();
    var selectedManufacturer = $("#c_id2 option:selected").val();
    var selectedPdStatus = $("#c_id3 option:selected").val();
//     let searchKeyword = $("#searchKeyword").val(); 

    url = "productListJson?pageNum=" + pageNum 
//     	+ "&searchKeyword=" + searchKeyword
        + "&pd_category=" + selectedCategory
        + "&pd_selectedManufacturer=" + selectedManufacturer
        + "&pd_selectedPdStatus=" + selectedPdStatus
        + "&sort=" + encodeURIComponent(selectedSort);

    $.ajax({
        type: "GET",
        url: url,
        dataType: "JSON",
        success: function(data) {
        	console.log("loadList ajax 진입함!!!!");
            maxPage = data.maxPage;
            $("#listCount").text(data.listCount);

            if (resetPage) {
                $(".productListArea").empty();
            }

            for (let product of data.changedProductList) {
                let price = product.pd_price;
                let formatted_price = Number(price).toLocaleString('en');

                let productDate = new Date(product.pd_first_date);
                let dateDisplay = "날짜 정보 없음"; // 기본값 설정

				console.log("!!!!!!!!!!!! productDate !!!!!!!!: " + productDate);
                if (!isNaN(productDate.getTime())) {  // 유효한 날짜인지 확인
                    let currentDate = new Date();
                    let timeDiff = currentDate - productDate;

                    let dayDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
                    let hoursDiff = Math.floor(timeDiff / (1000 * 60 * 60));
                    let minutesDiff = Math.floor(timeDiff / (1000 * 60));
                    console.log("!!!!!!!! dayDiff !!!!!!!!!!!!! : " + dayDiff);
                    console.log("!!!!!!!! hoursDiff !!!!!!!!!!!!! : " + hoursDiff);

                    if (dayDiff === 0) {
                        if (hoursDiff === 0) {
//                     console.log("${minutesDiff}분 전: " + minutesDiff);
                            dateDisplay = minutesDiff + "분 전";
                        } else {
                            dateDisplay = hoursDiff + "시간 전";
                        }
                    } else {
                        dateDisplay = dayDiff + "일 전";
                    }
                } else {
                    console.log("Invalid date format: " + product.pd_first_date);
                }

                console.log("dateDisplay: " + dateDisplay);

                $(".productListArea").append(
                    '<div class="col-lg-3 col-mid-4">'
                    + '    <div class="card border-0">'
                    + '        <div class="photoDiv">'
                    + '            <a href="product_detail?pd_idx=' + product.pd_idx + '&member_id=' + product.member_id + '">'
                    + '                <img src="${pageContext.request.contextPath}/resources/upload/' + product.pd_image1 + '" class="card-img-top">'
                    + '            </a>'
                    + '            <span class="dealStatus"><button class="btn btn-dark">' + product.pd_status + '</button></span>'
                    + '        </div>'
                    + '        <div class="card-body">'
                    + '            <div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: ellipsis;">'
                    + '                <a href="product_detail?pd_idx=' + product.pd_idx + '&member_id=' + product.member_id + '">'
                    + '                    ' + product.pd_subject
                    + '                </a>'
                    + '            </div>'
                    + '            <p>' + formatted_price + '원 </p>'
                    + '            <p>' + dateDisplay + '</p>'
                    + '        </div>'
                    + '    </div>'
                    + '</div>'
                );
            }
            isLoading = false;
        }, 
        error: function() {
            alert("글 목록 요청 실패!");
            isLoading = false;
        }
    }); //ajax끝부분
    
}

//==================================================================



</script>
<style type="text/css">
/* 헤더 스타일 */
/* 카테고리 선택 영역 */

/* 카테고리 선택, 제조사 선택, 거래상태 선택 영역 */
/* 각 select box의 너비를 5cm로 설정하고 높이를 유지 */
#categoryNav {
    margin-top: 20px; /* 위쪽 여백 추가 */
}

#categoryNav .select {
    width: 5cm;
    height: 35px; /* 높이 유지 */
    margin-right: 10px; /* 각 select box 사이에 여백 추가 */
}

#c_id, #c_id2, #c_id3 {
    width: 5cm;
    height: 35px; /* 높이 유지 */
    margin-right: 10px; /* 각 select box 사이에 여백 추가 */
}


header {
    position: relative; /* 다른 요소들과 겹치지 않도록 설정 */
    z-index: 1000; /* 다른 요소들 위에 표시되도록 설정 */
    background-color: #fff; /* 배경색 설정 */
    padding: 20px; /* 여백 설정 */
    width: 100%; /* 전체 너비 사용 */
}

/* 상품 목록 영역 스타일 */
.productListArea {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    margin: 0 auto;
    padding: 0 10px;
    box-sizing: border-box;
    margin-top: 80px; /* 헤더 높이에 따라 조정 */
}

/* 개별 상품 스타일 */
.productListArea .col-lg-3 {
    flex: 1 1 calc(25% - 20px);
    box-sizing: border-box;
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
}

/* 썸네일 이미지 */
.photoDiv {
    flex: 1;
    overflow: hidden;
    position: relative;
}

.photoDiv img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    display: block;
}

/* 거래상태 버튼 */
.pd_status {
    position: absolute;
    bottom: 10px;
    left: 10px;
    z-index: 10;
}

/* 카드 본문 */
.card-body {
    padding: 10px;
    display: flex;
    flex-direction: column;
}

/* 제목 링크 */
.card-title {
    font-size: 1rem;
    margin-bottom: 10px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.listInfo {
    display: flex;
    justify-content: space-between; /* 아이템들을 양 끝으로 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
    margin-bottom: 20px; /* 하단 여백 */
}

.listInfoCount {
     font-size: 18px;
}

.listInfoSort {
    position: relative; /* listSort의 위치를 relative로 설정하여 하위 요소에 위치 조정을 가능하게 함 */
}

.listInfoBtn {
    background-color: #f0f0f0; /* 버튼 배경색 */
    border: 1px solid #ccc; /* 버튼 테두리 */
    padding: 5px 10px; /* 버튼 안쪽 여백 */
    font-size: 14px; /* 버튼 폰트 크기 */
    cursor: pointer; /* 커서 모양 변경 */
    border-radius: 5px; /* 버튼 모서리 둥글게 */
    transition: background-color 0.3s ease; /* 배경색 변경 애니메이션 */
    margin-left: auto; /* 왼쪽 여백 자동 설정으로 오른쪽으로 정렬 */
    margin-right: 0.5cm; /* 오른쪽 여백 0.5cm 설정 */
}

.listInfoBtn:hover {
    background-color: #e0e0e0; /* 버튼 호버시 배경색 */
}

.listSort {
    list-style: none; /* 리스트 스타일 제거 */
    padding: 0; /* 패딩 제거 */
    margin: 0; /* 마진 제거 */
    display: none; /* 기본적으로 숨김 */
    position: absolute; /* 리스트를 버튼 바로 아래에 위치시키기 위해 */
    top: 100%; /* 버튼 아래에 위치 */
    left: 0; /* 버튼 왼쪽에 정렬 */
    background-color: white; /* 배경색 설정 */
    border: 1px solid #ccc; /* 테두리 설정 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 그림자 설정 */
    z-index: 1000; /* 버튼과 리스트가 겹치지 않도록 설정 */
}

.listSort li {
    padding: 10px 15px; /* 리스트 항목 안쪽 여백 */
    cursor: pointer; /* 커서 모양 변경 */
}

.listSort li:hover {
    background-color: #f0f0f0; /* 리스트 항목 호버시 배경색 */
}



</style>

<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
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
				    <select class="select" id="c_id" name="c_id">
				        <option value="">카테고리 선택</option>
				        <option value="PC">PC</option>
				        <option value="NB">노트북</option>
				    </select>
				    <select class="select" id="c_id2" name="c_id2">
				        <option value="">제조사 선택</option>
				        <option value="SA">삼성</option>
				        <option value="AP">애플</option>
				        <option value="LG">LG</option>
				        <option value="ET">기타</option>
				    </select> 
				    <select class="select" id="c_id3" name="c_id3">
				        <option value="">거래상태 선택</option>
				        <option value="판매중">판매중</option>
				        <option value="거래중">거래중</option>
				        <option value="결제완료">결제완료</option>
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
			    
			    <div class="listInfoSort">
			        <button class="listInfoBtn">
			            최신순 
			        </button>
			        <!-- 정렬 방법 -->
			        <ul class="listSort">
			            <li id="list1">최신순 </li>
			            <li id="list2">가격순 </li>
			            <li id="list3">조회순 </li>
			        </ul>
			    </div>
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
								<!-- 거래상태 버튼 -->
								<span class="pd_status">
									<button class="btn btn-dark">${product.pd_status}</button>
								</span>
							</div>
							<div class="card-body">
							
<!-- 								//연진 수정 부분!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1 -->
<!-- 			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
								<!-- 카테고리 가져오기 -->
<!-- 								<div class="category" style="font-size:0.8rem;"> -->
<%-- 									${product.pd_category } --%>
<!-- 								</div> -->

<!-- 	//연진 수정 부분!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1 -->
<!-- 			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
								<!-- 제목 링크 -->
								<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
									<a href="product_detail?pd_idx=${product.pd_idx}&member_id=${product.member_id}">
										${product.pd_subject}
									</a>
								</div>
								<p><fmt:formatNumber pattern="#,###" value="${product.pd_price }"/>원</p>
								<p class="productDate" data-date="${product.pd_first_date != null ? product.pd_first_date : '날짜 정보 없음'}">${product.pd_first_date != null ? product.pd_first_date : '날짜 정보 없음'}</p>							</div>
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