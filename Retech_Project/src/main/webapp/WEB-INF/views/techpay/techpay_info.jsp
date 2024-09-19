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
<script src="${pageContext.request.servletContext.contextPath}/resources/js/techpay/techpay_info.js"></script>

<!-- 날짜 범위 선택기 CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<!-- 부트스트랩 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<%-- 외부 CSS 파일 연결 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/techpay/techpay_info.css" rel="stylesheet" type="text/css">

<!-- FontAwesome 아이콘 CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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

	<section id="pay_area">
		 <div class="account-login section">
	        <div class="container" id="pay_area">
	            <div class="row">
	                <div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1 col-12">
                		<div class="title-container">
							<h2 id="techpay_title">테크페이 | 홈</h2>
						</div>
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

								<div id="date_select">
								    <button id="select_date_modal" data-bs-toggle="modal" data-bs-target="#date_modal">기간선택 <i class="fa fa-caret-down"></i></button>
								</div>
								
								<div id="period_info">
								    <div id="info_left"></div>
								    <div id="info_right" onclick="#">전체기간</div>
								</div>
								
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

	    <!-- 기간선택 모달창 -->
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
        
	</section>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>	
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
	
<!--     <a href="#" class="scroll-top"> -->
<!--         <i class="lni lni-chevron-up"></i> -->
<!--     </a> -->
	
</body>
</html>	