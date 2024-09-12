<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech_테크페이</title>

<!-- 자바스크립트 연결 -->
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- 날짜 범위 선택기 CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<!-- 부트스트랩 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<%-- 외부 CSS 파일(css/default.css) 연결 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">

<!-- FontAwesome 아이콘 CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- 수정시작 -->
<script>
let pageNum = 1; // 초기 페이지 번호
let maxPage = 0;
let isLoading = false; // 로딩 상태 플래그
let pay_history_type = "";
let start_date = "";
let end_date = "";

$(function() {
    // 게시물 목록 불러오기
    load_list(pay_history_type, start_date, end_date);

    // "더보기" 버튼 클릭 시
    $("#loadMoreBtn").click(function() {
        if (!isLoading && pageNum <= maxPage) {
            load_list(pay_history_type, start_date, end_date);
        }
    });

    // 모아보기 버튼을 클릭하면 에이젝스를 새로 요청함
    $("[name='options']").change(function() {
        pay_history_type = $(this).val();

        // div 영역과 pageNum을 초기화
        $("#payHistoryList").html(""); // 이전 데이터 초기화
        pageNum = 1; // 페이지 번호 초기화
        load_list(pay_history_type, start_date, end_date);
    });

    // 기간 선택 버튼을 클릭하면 날짜 자동 설정
    $("[name='period']").change(function() {
        // 체크박스 다중 선택 방지
        if ($(this).prop('checked')) {
            $('input[type="checkbox"][name="period"]').prop('checked', false);
            $(this).prop('checked', true);
        }

        // 체크된 체크박스 값 저장
        let period = parseInt($(this).val());

        // 오늘 날짜 설정
        let today = new Date();
        let split_end_date = today.toISOString().split("T");
        end_date = split_end_date[0];
        $("#end_date").val(end_date);

        // 선택한 기간만큼 이전 날짜 설정
        let monthAgo = new Date(today.setMonth(today.getMonth() - period));
        let split_start_date = monthAgo.toISOString().split("T");
        start_date = split_start_date[0];
        $("#start_date").val(start_date);
    });

    // 시작날짜 변경 시 유효성 검사
    $("#start_date").change(function() {
        let start_date_real = new Date($("#start_date").val());
        let end_date_real = new Date($("#end_date").val());

        if (start_date_real > end_date_real) {
            $("#start_date").val("");
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: '마지막 날짜보다 이전의 날짜를 선택해주세요.',
                showConfirmButton: false,
                timer: 2000,
                toast: true
            });
        }

        // 두 날짜 차이가 1년 이상이면 경고
        let timeDiff = Math.abs(end_date_real.getTime() - start_date_real.getTime());
        let diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));

        if (diffDays >= 365) {
            $("#start_date").val("");
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: '1년 이내의 기간만 검색 가능합니다.',
                showConfirmButton: false,
                timer: 2000,
                toast: true
            });
        }
    });

    // 끝날짜 변경 시 유효성 검사
    $("#end_date").change(function() {
        let start_date_real = new Date($("#start_date").val());
        let end_date_real = new Date($("#end_date").val());

        if (start_date_real > end_date_real) {
            $("#end_date").val("");
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: '시작 날짜보다 이후의 날짜를 선택해주세요.',
                showConfirmButton: false,
                timer: 2000,
                toast: true
            });
        }

        // 두 날짜 차이가 1년 이상이면 경고
        let timeDiff = Math.abs(end_date_real.getTime() - start_date_real.getTime());
        let diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));

        if (diffDays >= 365) {
            $("#end_date").val("");
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: '1년 이내의 기간만 검색 가능합니다.',
                showConfirmButton: false,
                timer: 2000,
                toast: true
            });
        }
    });
});

// 게시물 목록을 AJAX와 JSON으로 처리하는 함수
function load_list(pay_history_type, start_date, end_date) {
    if (isLoading) return; // 이미 로딩 중이면 실행하지 않음
    isLoading = true; // 로딩 상태로 변경

    let pay_id = $("#pay_id").val();
    let type = pay_history_type;
    let start = start_date;
    let end = end_date;

    $.ajax({
        type: "GET",
        url: "PayHistoryJson",
        data: {
            "pay_id": pay_id,
            "pay_history_type": type,
            "pageNum": pageNum,
            "start_date": start,
            "end_date": end
        },
        dataType: "json",
        success: function(data) {
            console.log("AJAX 응답 데이터:", data);
            console.log("============data.payHistoryList========== : ", data.payHistoryList);

            if (data.listCount == 0) {
                $("#payHistoryList").append("<div id='list_none'>사용 내역이 없습니다</div>");
            }

            $("#info_left").html("총 <span>" + data.listCount + "</span>건");

            // 연도별로 데이터 그룹화
            let groupedData = {};
            for (let item of data.payHistoryList) {
	            console.log("============item(data.payHistoryList)========== : ", item);
                let year = new Date(item.techpay_tran_dtime).getFullYear();
                if (!groupedData[year]) {
                    groupedData[year] = [];
                }
                groupedData[year].push(item);
            }

            
            
            // 그룹화된 데이터 연도별로 표시
            let years = Object.keys(groupedData).reverse();
            for (let year of years) {
                if ($("#" + year).length === 0) {
                    $("#payHistoryList").append(
                        '<div id="' + year + '">' +
                        '<span id="year">' + year + '년</span>' +
                        '<div class="year_list" id="' + year + 'list"></div>' +
                        '</div>'
                    );
                }

                const paymentArray = groupedData[year];
                for (let history of paymentArray) {
                    let date = history.techpay_tran_dtime.slice(5, 10);
                    let time = history.techpay_tran_dtime.slice(11, 16);
                    console.log("==============history============ : ", history);
                    let pd_idx = history.pd_idx;
                    console.log("==============history.pd_idx============ : ", history.pd_idx);

                    let pay_history_type = "";
                    let subject = "";
                    if (history.techpay_type == "1") {
                        pay_history_type = "충전";
                        subject = "페이충전";
                    } else if (history.techpay_type == "2") {
                        pay_history_type = "환급";
                        subject = "페이환급";
                    } else if (history.techpay_type == "3") {
                        pay_history_type = "사용";
                        subject = '<a href="product_detail?pd_idx=' + history.pd_idx + '&member_id=' + history.id + '">' + history.pd_subject + '</a>';
                    } else if (history.techpay_type == "4") {
                        pay_history_type = "수익";
                        subject = '<a href="product_detail?pd_idx=' + history.pd_idx + '&member_id=' + history.id + '">' + history.pd_subject + '</a>';
                    }

                    let pay_amount = history.tran_amt.toLocaleString();
                    let pay_history_balance = history.pay_balance.toLocaleString();

                    $("#" + year + "list").append(
                        '<div class="row content_list">' +
                        '<div class="col-lg-2 col-md-2 col-12">' +
                        '<h5 class="pay_date">' + date + '</h5>' +
                        '</div>' +
                        '<div class="col-lg-7 col-md-7 col-12 subject-area">' +
                        '<h5 class="product-name">' + subject + '</h5>' +
                        '<p class="pay-info-sub">' + time + ' | ' + pay_history_type + '</p>' +
                        '</div>' +
                        '<div class="col-lg-3 col-md-3 col-12">' +
                        '<h5 class="pay-amount">' + pay_amount + '</h5>' +
                        '<p class="pay-balance-sub">' + pay_history_balance + '</p>' +
                        '</div>' +
                        '</div>'
                    );
                }
            }

            maxPage = data.maxPage; // 끝페이지 번호 갱신
            pageNum++; // 페이지 번호 증가

            // maxPage와 비교하여 더보기 버튼 표시/숨기기
            if (pageNum > maxPage) {
                $("#loadMoreBtn").hide(); // 마지막 페이지에 도달하면 더보기 버튼 숨김
            }

            isLoading = false; // 로딩 상태 해제
        },
        error: function(request, status, error) {
            console.log("AJAX 요청 실패:", status, error);
        }
    });
}

// 모달창에서 조회하기 버튼 눌렀을 때
function select_date() {
    start_date = $("#start_date").val();
    end_date = $("#end_date").val();

    // div 영역과 pageNum 초기화
    $("#payHistoryList").html("");
    pageNum = 1;
    load_list(pay_history_type, start_date, end_date);

    $('#date_modal').modal('hide');

    // 입력한 기간을 판별하여 표시
    if ($("input[name='period']:checked").val() != null && $("input[name='period']:checked").val() != "") {
        let checked = $("input[name='period']:checked").val();
        if (checked == 12) {
            $("#info_right").html("1년");
        } else {
            $("#info_right").html(checked + "개월");
        }
    } else if (start_date != "" && end_date != "") {
        $("#info_right").html(start_date + " ~ " + end_date);
    } else {
        $("#info_right").html("전체기간");
    }

    $('input[name="period"]').prop('checked', false);
}

</script>



<!-- 수정끝 -->







<style type="text/css">

.container {
	max-width:1600px;
 	width: 100%;
}
/*---- techpay_info 영역 전체 ----*/
.payinfo_container {
	width:100%;
/* 	max-width: 900px; */
	margin: 0 auto;
	margin-bottom: 20px;
	margin-top: 20px;
	border: 1px solid gray;
	border-radius: 10px;
	box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.1); 
	padding: 20px 10px;
	box-sizing: border-box;
	display: block;
}

.title, .pay_balance {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

/*---- 충전/환급 버튼 ----*/
.btn_top {
	display: flex;
	justify-content: space-between;
	gap: 10px;
	margin-bottom: 20px;
}

.btn_top .btn { 
	padding: 10px 20px; 
	border: none; 
	border-radius: 2px; 
	background-color: skyblue; 
	color: white; 
	cursor: pointer; 
	font-size: 14px;  
	width: 100%;
} 

/*---- 페이내역 탭 ----*/
.pay_history_tab {
    display: flex;
    border: 1px #34495E; 
    border-radius: 3px;
    overflow: hidden;
    margin-bottom: 20px;
    font-size: 18px;
}

input[type="radio"] {
    display: none;
}

#techpay_manage_btn {
	padding: 10px 20px;
	font-size: 20px;
	border: 2px solid #34495E;
	background-color: #F0F0F0;
	border-radius: 5px;
}

#techpay_manage_btn:hover {
	background-color: #34495E;
	color: #ffffff;
}

#loadMoreBtn {
	background-color: #34493E;
	color: #ffffff;
}

h5.product-name {
	color: #0064FF;
}

.tab_label {
    flex: 1;
    padding: 10px;
    cursor: pointer;
    background-color: white;
    border: none;
    text-align: center;
    color:black;  /* 기본 상태에서의 글자 색상 */
    transition: background-color 0.3s ease, color 0.3s ease; /* 배경과 글자 색 전환 효과 추가 */
}

input[type="radio"]:checked + .tab_label {
    background-color: #34495E;
    color: white;
}

.card-body {
/* 	font-size : 2em; */
	padding: 20px 20px;
}

/*---- 기간선택 모달창 ----*/
.ui-datepicker {
    z-index: 9999 !important;
}

.container {
/* 	max-width: 500px; */
	padding: 20px 30px 40px 30px;
}

/* 개월 선택 탭(1개월, 3개월..) 가로로 꽉 차게 */
.btn-group {  
    display: flex;
}

/* 날짜선택 영역 가로로 꽉 차게 */
.date_area {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
}

.date_area input {
    flex-grow: 2; /* 입력 필드가 가로 공간을 최대한 차지하도록 설정 */
}

.btn-group .btn-check {
	font-size: 30px;
}

.btn2 {
	font-size:24px;
    width: 100%; /* 버튼이 부모의 너비를 꽉 채우도록 설정 */
    padding: 10px 0; /* 버튼의 상하 여백 */
    text-align: center; /* 텍스트 중앙 정렬 */
    background-color: #34495E; /* 버튼 배경색 */
    color: white; /* 버튼 텍스트 색상 */
    border: none; /* 기본 테두리 제거 */
    border-radius: 5px; /* 버튼의 둥근 모서리 */
}


.btn22 {
    display: flex;
    gap: 10px; /* 버튼 사이의 간격 */
/*     height: 70px; */
}

#date_select {
    display: flex;
    justify-content: flex-end; /* 버튼을 오른쪽에 정렬 */
    margin-bottom: 5px; /* 아래에 약간의 간격 추가 */
}

@media (max-width: 768px) {
    #date_select {
        float: none; /* 작은 화면에서는 float 제거 */
        text-align: right; /* 작은 화면에서 오른쪽 정렬 */
        margin-top: 10px; /* 여백 추가 */
    }
}

#period_info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

#info_left {
    font-size: 22px;
    color: #555; /* 약간 어두운 회색 */
}

#info_right {
    font-size: 22px;
/*     color: #007bff; /* 파란색 텍스트 */ */
    cursor: pointer; /* 클릭할 수 있음을 나타내는 포인터 커서 */
/*     text-decoration: underline; /* 밑줄 추가 */ */
}

#period_info {
	margin-bottom: 20px;
}

h5.pay_date {
	font-size: 22px;
}

.pay-info #pay_balance_text {
	font-size: 25px;
}

#sName {
	color: #0064FF;
}

#info_right:hover {
    color: #0056b3; /* 호버 시 텍스트 색상 변경 */
}

.btn-group {
	margin-bottom: 20px;
}


/* ajax 데이터 받는 부분 css */
/* 연도별 그룹 제목 */
#payHistoryList #year {
    font-weight: bold;
    font-size: 1.5rem;
/*     color: #007bff; /* 파란색 */ */
    width: calc(100% - 40px); /* 좌우 20px 여백을 고려하여 너비 조정 */
    margin-bottom: 12px;
    margin-left: auto;   
	padding: 10px 20px;
}

/* 각 항목을 담고 있는 행 (row) */
.row.content_list {
    padding: 10px 0px; /* 상하 및 좌우에 적절한 패딩 추가 */
    border-bottom: 1px solid #e0e0e0; /* 아래쪽에 구분선 추가 */
    margin-bottom: 10px;
    width: calc(100% - 40px); /* 좌우 20px 여백을 고려하여 너비 조정 */
    margin-left: auto;
    margin-right: auto;
}

/* #pay_area { */
/*     max-width: 700px; /* 컨테이너의 최대 너비를 700px로 수정 */ */
/*     padding: 20px 20px; /* 좌우 padding을 줄여서 여백을 줄임 */ */
/* } */

/* 날짜 부분 */
.pay_date {
    font-size: 1.6rem;
    font-weight: bold;
    color: #333;
}

/* 제목 (상품명 등) */
.product-name {
    font-size: 1.5rem;
    font-weight: bold;
    color: #007bff; /* 파란색 */
    text-decoration: none;
    margin-bottom: 5px;
}

.product-name a {
    color: inherit; /* 링크 상태에서도 동일한 색 유지 */
    text-decoration: none; /* 밑줄 제거 */
}

.product-name a:hover {
    text-decoration: underline; /* 마우스 오버 시 밑줄 추가 */
}

/* 상세 설명 (시간 및 사용/충전 등 정보) */
.pay-info-sub {
    font-size: 1.1rem;
    color: #666;
}

/* 금액 부분 */
.pay-amount {
    font-size: 1.5rem;
    font-weight: bold;
/*     color: #28a745; /* 초록색 */ */
}

.btn-group .label {
	font-size: 22px;
}

/* 잔액 정보 */
.pay-balance-sub {
    font-size: 1.3rem;
    color: #888;
}

.btn-outline-primary {
    color: #0d6efd;
    border-color: #0d6efd;
}

@media (min-width: 1200px) {
    .h2, h2 {
	font-size: 18px;
    }
}

.h2, h2 {
	font-size: 18px;
}

.title-container {
	margin-top: 50px;
    display: flex;
    justify-content: flex-end; /* 오른쪽 정렬 */
    padding-right: 345px; /* 오른쪽 여백 추가 (원하는 대로 조정) */
	color: #34495E;
	font-size: 18px !important;
	font-weight: 1000;
}

.pay-info.col-lg-6.col-md-6.col-12 {
	padding-left: 30px;
}
#pay_balance_amt {
	font-size: 40px;
}
</style>
</head>
<body>
<!-- jQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Moment.js 라이브러리 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/moment/min/moment.min.js"></script>

<!-- 날짜 범위 선택기 JS -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>


	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
		<div class="title-container">
			<h2 id="techpay_title">테크페이 > 테크페이 홈</h2>
		</div>
	<section id="pay_area">
		 <div class="account-login section">
	        <div class="container" id="pay_area">
	            <div class="row">
	                <div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1 col-12">
	                    <div class="card login-form pay-card">
	                        <div class="card-body">
	                            <div class="title paytitle">
		                            <h3 class="user-name">
										<a href="SaleHistory" id="sName">
			                                ${sessionScope.sName} 님
										</a>								
		                            </h3>
	                                <h3 class="pay-name">
										<input type="button" id="techpay_manage_btn"  value="테크페이 관리" onclick="location.href='PayManage'">
	                                </h3>
	                            </div>
	                            <div class="row">
		                           	<div class="pay-info col-lg-6 col-md-6 col-12">
										<h3 id="pay_balance_text">페이잔액</h3>
							        	<h2 id="pay_balance_amt"><fmt:formatNumber value="${sessionScope.pay_balance}" pattern="#,###" />원</h2><br>							
									</div>
									<div class="btn22">
										<input type="hidden" value="${sessionScope.sId}" id="pay_id">
	<%-- 									<input type="hidden" value="${payInfo.pay_id}" id="pay_id"> --%>
			                            <div class="button col-lg-6 col-md-6 col-12">
			                                <button class="btn2" onclick="location.href='PayCharge'">충전하기</button>
			                            </div>
			                            <div class="button col-lg-6 col-md-6 col-12">
			                                <button class="btn2" onclick="location.href='PayRefund'">환급하기</button>
			                            </div>
									</div>
	                            </div>
	                        </div>
	                     </div>   
	                     <div class="card login-form">   
	                        <div class="card-body">
	                           	<div class="btn-group col">
							        <input type="radio" name="options" class="btn-check" id="btn-check1" value="" autocomplete="off">
								    <label class="btn btn-outline-primary label" for="btn-check1">전체</label>
							        <input type="radio" name="options" class="btn-check" id="btn-check2" value="1" autocomplete="off">
								    <label class="btn btn-outline-primary label" for="btn-check2">충전</label>
							        <input type="radio" name="options"class="btn-check" id="btn-check3" value="2" autocomplete="off">
								    <label class="btn btn-outline-primary label" for="btn-check3">환급</label>
							        <input type="radio" name="options" class="btn-check" id="btn-check4" value="3" autocomplete="off">
								    <label class="btn btn-outline-primary label" for="btn-check4">사용</label>
							        <input type="radio" name="options" class="btn-check" id="btn-check5" value="4" autocomplete="off">
								    <label class="btn btn-outline-primary label" for="btn-check5">수익</label>
								</div>
<!-- 								<div id="date_select"><button id="select_date_modal" data-bs-toggle="modal" data-bs-target="#date_modal">기간선택<i class="fa fa-caret-down"></i></button></div> -->



								<div id="date_select">
								    <button id="select_date_modal" data-bs-toggle="modal" data-bs-target="#date_modal">기간선택 <i class="fa fa-caret-down"></i></button>
								</div>
								
								<div id="period_info">
								    <div id="info_left"></div>
								    <div id="info_right" onclick="#">전체기간</div>
								</div>
								
<!-- 								<div id="period_info"> -->
<!-- 									<div id="info_left"></div> -->
<!-- 									<div id="info_right" onclick="#">전체기간</div> -->
<!-- 								</div> -->
								
								<div id="payHistoryList">
									<%-- 페이사용 내역이 출력되는 영역 --%>
								</div>
							    <div class="text-center mt-4">
							        <button id="loadMoreBtn" class="btn btn-primary">더보기</button>
							    </div>
	                        </div>
	                    </div>
	                    
	                </div>
	            </div>
	        </div>
	    </div>

	    <!-- Review Modal -->
	    <div class="modal review-modal" id="date_modal" tabindex="-1" aria-labelledby="exampleModalLabel"
	        aria-hidden="true">
	        <div class="modal-dialog">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <h5 class="modal-title" id="exampleModalLabel">조회 기간을 선택해주세요</h5>
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div class="modal-body">
	                    <div class="row">
	                        <div class="col-sm-12">
	                            <div class="btn-group col">
							        <input type="checkbox" name="period" class="btn-check" id="btn-date1" value="1" autocomplete="off">
								    <label class="btn btn-outline-primary" for="btn-date1">1개월</label>
							        <input type="checkbox" name="period" class="btn-check" id="btn-date2" value="3" autocomplete="off">
								    <label class="btn btn-outline-primary" for="btn-date2">3개월</label>
							        <input type="checkbox" name="period"class="btn-check" id="btn-date3" value="6" autocomplete="off">
								    <label class="btn btn-outline-primary" for="btn-date3">6개월</label>
							        <input type="checkbox" name="period" class="btn-check" id="btn-date4" value="12" autocomplete="off">
								    <label class="btn btn-outline-primary" for="btn-date4">최대(1년)</label>
								</div>
	                        </div>
	                        <div class="date_area col">
	                            <div class="start_date"><input type="date" id="start_date"></div>
	                            <div class="pattern"> ~ </div>
	                            <div class="end_date"><input type="date" id="end_date"></div>
	                        </div>
	                    </div>
	                </div>
	                <div class="modal-footer button">
	                    <button type="button" class="btn" id="passwd-btn" onclick="select_date()">조회하기</button>
	                </div>
	            </div>
	        </div>
	    </div>
	    <!-- End Review Modal -->
		
        
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
	
    <a href="#" class="scroll-top">
        <i class="lni lni-chevron-up"></i>
    </a>
	

</body>
</html>	