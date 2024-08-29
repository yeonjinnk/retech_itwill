<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech_테크페이</title>
<!-- 자바스크립트 연결 -->
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> <!-- Font Awesome 아이콘 라이브러리 로드 -->

<!--     Font Awesome CSS -->
<!--     <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"> -->
<!-- Bootstrap 5.0.2 버전의 CSS 파일을 외부 CDN에서 로드 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.2/css/bootstrap.min.css">
<!--     Bootstrap CSS 연결 -->
<!--     <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet"> -->

    <!-- 외부 CSS 파일(css/default.css) 연결 -->
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">

<!-- jQuery 최신 버전 CDN에서 로드 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<!-- Moment.js 라이브러리 로드 (날짜/시간 조작 라이브러리) -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<!-- DateRangePicker 라이브러리 로드 (날짜 범위 선택기) -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<!-- DateRangePicker의 CSS 파일 로드 -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


<%-- 외부 CSS 파일(css/default.css) 연결 --%>
<%-- <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css"> --%>

<%-- Font Awesome CSS 연결 --%>
<!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" > -->

<!-- ========================= CSS here ========================= -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css"> -->
<%-- <link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/resources/css/techpay_info/bootstrap.min.css" /> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/resources/css/techpay_info/LineIcons.3.0.css" /> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/resources/css/techpay_info/tiny-slider.css" /> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/resources/css/techpay_info/glightbox.min.css" /> --%>

<!-- Bootstrap JS 연결 -->
<!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet"> -->

<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.2/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://cdn.lineicons.com/3.0/LineIcons.css"> -->

<!-- ========================== 달력 ===================================== -->
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" /> -->

<script type="text/javascript">
$(document).ready(function () {
    // Datepicker 설정 (jQuery UI 사용)
    $("#start_date, #end_date").datepicker({
        dateFormat: 'yy-mm-dd', // 포맷 설정
        changeMonth: true,
        changeYear: true
    });

    // 조회 버튼 클릭 시 실행되는 함수
    $('#searchButton').click(function () {
        var startDate = $('#start_date').val();
        var endDate = $('#end_date').val();

        if (startDate && endDate) {
            // 서버로 데이터 전송
            $.ajax({
                type: 'POST',
                url: '/fetchData', // 서버의 URL
                data: { start_date: startDate, end_date: endDate },
                success: function (response) {
                    // 성공적으로 데이터를 가져온 경우, 결과를 처리
                    $('#payHistoryList').html(response);
                    $('#date_modal').modal('hide'); // 모달창 닫기
                },
                error: function (error) {
                    console.error("에러 발생:", error);
                }
            });
        } else {
            alert('날짜를 모두 선택해주세요.');
        }
    });
});
</script>

<style type="text/css">
/*---- techpay_info 영역 전체 ----*/
.payinfo_container {
	max-width: 500px;
	margin: auto;
	margin-bottom: 20px;
	margin-top: 20px;
	border: 1px solid gray;
	border-radius: 10px;
	box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.1); 
	padding: 20px 50px;
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
    border: 1px solid skyblue;  /* 스카이블루 색상으로 변경 */
    border-radius: 3px;
    overflow: hidden;
    margin-bottom: 20px;
    font-size: 14px;
}

input[type="radio"] {
    display: none;
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
    background-color: skyblue;
    color: white;
}

</style>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<section>
		<div class="payinfo_container">
	       <!-- 페이 기본 정보 표시  -->
	       <div class="pay_card">
			  <div class="title">
				<h2>${sessionScope.sName} 님</h2>
				<img src="${pageContext.request.servletContext.contextPath}/resources/images/logo.png" height="40" width="80">
			  </div>
	          <div class="pay_balance">
		        <h2>페이잔액</h2> 
		        <h2>xxxx원</h2>
	          </div>
	          <!-- 페이 충전/환급 버튼  -->
	          <div class="btn_top">
	            <button class="btn" onclick="location.href='PayCharge'">충전하기</button>
	            <button class="btn">환급하기</button>
	          </div>
	        </div>
			<!-- 페이 이용내역  -->
			<div class="pay_history">
				<!-- 페이 이용내역 탭  -->
				<div class="pay_history_tab">
				   <input type="radio" id="tab1" name="tab" checked>
				   <label for="tab1" class="tab_label">전체</label>
				 
				   <input type="radio" id="tab2" name="tab">
				   <label for="tab2" class="tab_label">충전</label>
				
				   <input type="radio" id="tab3" name="tab">
				   <label for="tab3" class="tab_label">환급</label>
				
				   <input type="radio" id="tab4" name="tab">
				   <label for="tab4" class="tab_label">사용</label>
				
				   <input type="radio" id="tab5" name="tab">
				   <label for="tab5" class="tab_label">수익</label>
				</div>
				<!-- 기간 선택 모달창  -->
                <div id="date_select">
                    <button id="select_date_modal" data-bs-toggle="modal" data-bs-target="#date_modal">
                        기간선택 <i class="fa fa-caret-down"></i>
                    </button>
                </div>				
<!-- 				<div id="date_select"><button id="select_date_modal" data-bs-toggle="modal" data-bs-target="#date_modal">기간선택<i class="fa fa-caret-down"></i></button></div> -->
				
				<!-- 조회 기간/조회된 건수  -->
				<div id="period_info">
					<div id="info_left"></div>
					<div id="info_right" onclick="#">전체기간</div>
				</div>
				
				<!-- 이용내역 조회 결과  -->
				<div id="payHistoryList">
					
				</div>
				
				<!-- 기간 선택 모달 구조 -->
                <!-- 기간 선택 모달 -->
<div class="modal fade" id="date_modal" tabindex="-1" aria-labelledby="dateModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="dateModalLabel">조회 기간을 선택해주세요</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="btn-group col">
                    <input type="radio" name="period" class="btn-check" id="btn-date1" value="1" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btn-date1">1개월</label>
                    <input type="radio" name="period" class="btn-check" id="btn-date2" value="3" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btn-date2">3개월</label>
                    <input type="radio" name="period" class="btn-check" id="btn-date3" value="6" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btn-date3">6개월</label>
                    <input type="radio" name="period" class="btn-check" id="btn-date4" value="12" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btn-date4">최대(1년)</label>
                </div>
                <div class="date_area col">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" id="start_date" placeholder="시작일자">
                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                    </div>
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" id="end_date" placeholder="종료일자">
                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="searchButton">조회하기</button>
            </div>
        </div>
    </div>
</div>	
				
				  <!-- Review Modal -->
<!-- 				    <div class="modal review-modal" id="date_modal" tabindex="-1" aria-labelledby="exampleModalLabel" -->
<!-- 				        aria-hidden="true"> -->
<!-- 				        <div class="modal-dialog"> -->
<!-- 				            <div class="modal-content"> -->
<!-- 				                <div class="modal-header"> -->
<!-- 				                    <h5 class="modal-title" id="exampleModalLabel">조회 기간을 선택해주세요</h5> -->
<!-- 				                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 				                </div> -->
<!-- 				                <div class="modal-body"> -->
<!-- 				                    <div class="row"> -->
<!-- 				                        <div class="col-sm-12"> -->
<!-- 				                            <div class="btn-group col"> -->
<!-- 										        <input type="checkbox" name="period" class="btn-check" id="btn-date1" value="1" autocomplete="off"> -->
<!-- 											    <label class="btn btn-outline-primary" for="btn-date1">1개월</label> -->
<!-- 										        <input type="checkbox" name="period" class="btn-check" id="btn-date2" value="3" autocomplete="off"> -->
<!-- 											    <label class="btn btn-outline-primary" for="btn-date2">3개월</label> -->
<!-- 										        <input type="checkbox" name="period"class="btn-check" id="btn-date3" value="6" autocomplete="off"> -->
<!-- 											    <label class="btn btn-outline-primary" for="btn-date3">6개월</label> -->
<!-- 										        <input type="checkbox" name="period" class="btn-check" id="btn-date4" value="12" autocomplete="off"> -->
<!-- 											    <label class="btn btn-outline-primary" for="btn-date4">최대(1년)</label> -->
<!-- 											</div> -->
<!-- 				                        </div> -->
<!-- 				                        <div class="date_area col"> -->
<!-- 				                            <div class="start_date"><input type="date" id="start_date"></div> -->
<!-- 				                            <div class="pattern"> ~ </div> -->
<!-- 				                            <div class="end_date"><input type="date" id="end_date"></div> -->
<!-- 				                        </div> -->
<!-- 				                    </div> -->
<!-- 				                </div> -->
<!-- 				                <div class="modal-footer button"> -->
<!-- 				                    <button type="button" class="btn" id="passwd-btn" onclick="select_date()">조회하기</button> -->
<!-- 				                </div> -->
<!-- 				            </div> -->
<!-- 				        </div> -->
<!-- 				    </div> -->
				    <!-- End Review Modal -->
							
			</div>
        </div>
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
	
    <!-- ========================= JS here ========================= -->
<%--     <script src="${pageContext.request.servletContext.contextPath}/resources/js/techpay_info/bootstrap.min.js"></script> --%>
<%--     <script src="${pageContext.request.servletContext.contextPath}/resources/js/techpay_info/tiny-slider.js"></script> --%>
<%--     <script src="${pageContext.request.servletContext.contextPath}/resources/js/techpay_info/glightbox.min.js"></script> --%>
<!--     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script> -->
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script> -->
    <!-- Bootstrap JS 연결 -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>

</body>
</html>