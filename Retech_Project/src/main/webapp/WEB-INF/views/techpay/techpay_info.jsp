<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech_테크페이</title>
<%-- 외부 CSS 파일(css/default.css) 연결 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">

<!-- 자바스크립트 연결 -->
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- 날짜 범위 선택기 CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<!-- 부트스트랩 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- FontAwesome 아이콘 CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script>
let pageNum = "1";
let maxPage = "";
let pay_history_type = "";
let start_date = "";
let end_date = "";

$(function() {
	
    console.log("아이디 " +  "${id}");
    
	// 목록 표시 함수 호출
	load_list(pay_history_type, start_date, end_date);	

	
	$(window).scroll(function() {
		let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
		let windowHeight = $(window).height(); // 브라우저 창 높이
		let documentHeight = $(document).height(); // 문서 높이
		console.log("scrollTop : " + scrollTop + ", windowHeight : " + windowHeight + ", documentHeight : "+ documentHeight);
			
		if(scrollTop + windowHeight + 1 >= documentHeight) {
			pageNum++; // 페이지번호 1 층가
			
			// 페이지 번호를 계속 불러오는 현상 막기
			if(maxPage != "" && pageNum <= maxPage) {
				load_list(pay_history_type, start_date, end_date);
			}
		}
		
	});	
	
	
	// 전체, 충전, 환급, 사용, 수익 탭 클릭 시 pay_history_type 값 재할당
	$("[name='options']").change(function() {
		pay_history_type = $(this).val();
		console.log("---------------------pay_history_type : " + pay_history_type);
		
		// div영역과 pageNum을 초기화
		$("#payHistoryList").html("");
		pageNum = "1";
		load_list(pay_history_type, start_date, end_date);
	});	
	
	
	
	
	// 기간선택 모달창
	// 1, 3, 6개월 탭 선택 시, 오늘날짜 기준으로 해당 날짜 자동 입력
	$("[name='period']").change(function() {
		// 체크박스 다중선택 막기
		if($(this).prop('checked')){	 
			$('input[type="checkbox"][name="period"]').prop('checked',false);
			$(this).prop('checked',true);
		}

		// 체크된 체크박스의 값을 가져와서 변수에 저장
		let period = parseInt($(this).val());
		
		// 오늘 날짜를 불러와서 end_date에 저장
		let today = new Date();
		let split_end_date = today.toISOString().split("T");
		let end_date = split_end_date[0];
		console.log(end_date);

		$("#end_date").val(end_date);

		// 오늘 날짜에서 버튼에 적힌 개월수만큼을 빼서 start_date에 저장
		var monthAgo = new Date(today.setMonth(today.getMonth() - period));
		console.log(monthAgo);
		let split_stert_date = monthAgo.toISOString().split("T");
		let start_date = split_stert_date[0];
		console.log(start_date);

		$("#start_date").val(start_date);
		
	});

	// 시작일시
	$("#start_date").click(function() {
		// 현재 날짜보다 미래이면 안됨
		var now_utc = Date.now() // 지금 날짜를 밀리초로
		// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
		var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
		// new Date(today-timeOff).toISOString()은 '2024-01-30T11:48'를 반환
		var today = new Date(now_utc-timeOff).toISOString().substring(0, 10);
		
		$("#start_date").attr("max", today);
	});

	$("#start_date").change(function() {
		// 끝날짜보다 미래이면 안됨
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
		
		
		// 간격이 1년 이상 벌어지면 안됨
		// 두 날짜 사이의 차이를 계산
		let timeDiff = Math.abs(end_date_real.getTime() - start_date_real.getTime());
		
		// 계산한 값을 일 단위로 변환
		let diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
		
		// 1년(365일) 이상 차이나는지 판별합니다.
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
	
	// 종료일시
	$("#end_date").click(function() {
		// 현재날짜보다 미래이면 안됨
		var now_utc = Date.now() // 지금 날짜를 밀리초로
		// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
		var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
		// new Date(today-timeOff).toISOString()은 '2024-01-30T11:48'를 반환
		var today = new Date(now_utc-timeOff).toISOString().substring(0, 10);
		
		$("#end_date").attr("max", today);
		
	});
	
	$("#end_date").change(function() {
		// 시작날짜보다 과거이면 안됨
		var start_date_real = new Date($("#start_date").val());
		var end_date_real = new Date($("#end_date").val());
		
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
		
		console.log("체크 " + start_date);
		
		// 간격이 1년 이상 벌어지면 안됨
		// 두 날짜 사이의 차이를 계산
		let timeDiff = Math.abs(end_date_real.getTime() - start_date_real.getTime());
		
		// 계산한 값을 일 단위로 변환
		let diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
		
		// 1년(365일) 이상 차이나는지 판별합니다.
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
	
	// 기간선택 모달창 달력 열기
    $('#start_date').daterangepicker({
        locale: {
            format: 'YYYY-MM-DD'
        },
        opens: 'right'  // 달력 위치를 오른쪽에 열리게 설정
    });
    
    $('#end_date').daterangepicker({
        locale: {
            format: 'YYYY-MM-DD'
        },
        opens: 'right'  // 달력 위치를 오른쪽에 열리게 설정
    });
    
});

// 테크페이 내역 불러오기(AJAX와 JSON으로 처리)
function load_list(pay_history_type, start_date, end_date) {
	
 	// 회원 id 저장
	let id = "${id}";
	console.log("load_list---------id = "  + id);
	
	// 테크페이 타입 저장(충전, 환급, 사용, 수익)
	let  techpay_type = pay_history_type;
	console.log("load_list---------techpay_type = " + techpay_type + ", id = " + id + ", pageNum = " + pageNum);
	
	let start = start_date;
	let end = end_date;
	console.log("load_list---------start_date = " + start + ", end_date = " + end);
	
	
	$(".btn-check").each(function() {
		if ($(this).val() === pay_history_type) {
			$(this).prop("checked", true);
			return false; // 반복문 종료
		}
	});
	
	
	$.ajax({
		type: "GET",
		url: "PayHistoryJson",
		data: {
			"id": id,
			"techpay_type": techpay_type,
			"pageNum": pageNum,
			"start_date": start,
			"end_date": end
		},
		dataType: "json",
		success:  function(data) {
			
			console.log(data.payHistory);
			
			if(data.listCount == 0) {
				$("#payHistoryList").append("<div id='list_none'>사용 내역이 없습니다</div>");
			}
	
			$("#info_left").html("총 <span>" + data.listCount + "</span>건");
			
			// 연도별로 그룹화할 객체 생성
			let groupedData = {};

			// payHistoryList를 순회하며 연도별로 그룹화
			for (let item of data.payHistoryList) {
				let year = new Date(item.techpay_tran_dtime).getFullYear();
  
				if (!groupedData[year]) {
					groupedData[year] = [];
				}
  
				groupedData[year].push(item);
			}

			// 그룹화된 데이터를 이용하여 각 연도별로 div 영역에 추가
			let years = Object.keys(groupedData).reverse(); // 연도 속성을 반대로 순회할 배열 생성
			for (let year of years) {
				
				if($("#" + year).length === 0) {
					$("#payHistoryList").append(
						'<div id="'+ year +'">'
						+	'<span id="year">' + year + '</span>년'
						+	'<div class="year_list" id="' + year + 'list"></div>'
						+ '</div>'
					);
				}
				
				const paymentArray = groupedData[year]; // 데이터 배열

				for (let history of paymentArray) {
					console.log("history:" + history.buy_product_id);
					// pay_history_date 값을 분리하여 날짜와 시간을 추출
					let date = history.techpay_tran_dtime.slice(5, 10);
					let time = history.techpay_tran_dtime.slice(11, 16);
					
					// pay_history_type 값에 따라 다른 결과 출력
					let pay_history_type = "";
					let subject = "";
					if(history.pay_history_type == "1") {
						pay_history_type = "충전";
						subject = history.pay_history_message;
					} else if(history.pay_history_type == "2") {
						pay_history_type = "환급";
						subject = history.techpay_idx;
					} else if(history.pay_history_type == "3") {
						pay_history_type = "사용";
// 						if (!history.buy_product_id || history.buy_product_id === 'null') {
// 						    subject = "취소된 거래입니다";
// 						} else {
// 							subject = '<a href="ProductDetail?product_id=' + history.buy_product_id +'">' + history.buy_product_name + '</a><i class="fa fa-angle-right"></i>';
// 						}
					} else if(history.pay_history_type == "4") {
						pay_history_type = "수익";
						subject = '<a href="ProductDetail?product_id=' + history.sell_product_id +'">' + history.sell_product_name + '</a><i class="fa fa-angle-right"></i>';
					}
					
					let pay_amount = history.pay_amount.toLocaleString();
					let pay_history_balance = history.pay_history_balance.toLocaleString();
			    	  
			    	  $("#" + year + "list").append(
	 						'<div class="row content_list">'
	  				        +     '<div class="col-lg-2 col-md-2 col-12">'
	  				        +         '<h5 class="pay_date">' + date + '</h5>'
	  				        +     '</div>'
	  				        +     '<div class="col-lg-7 col-md-7 col-12 subject-area">'
	  				        +         '<h5 class="product-name">' 
	  				        + 				subject 
	  				        +		  '</h5>'
	  				        +         '<p class="pay-info-sub">'
	  				        +        		time + ' | '
	  				        +               pay_history_type
	  				        +         '</p>'
	  				        +     '</div>'
	  				        +     '<div class="col-lg-3 col-md-3 col-12">'
	  				        +          '<h5 class="pay-amount">' + pay_amount + '</h5>'
	  				        +          '<p class="pay-balance-sub">'
	  				        +				pay_history_balance
	  				        +         '</p>'
	  				        +     '</div>'
	  				        +'</div>'

						);
// 				
// 					// 끝페이지 번호(maxPage) 값을 변수에 저장
					maxPage = data.maxPage;
// 					console.log("maxPage" + maxPage);			
				}	
			}
		},
		error: function(request, status, error) {
	      // 요청이 실패한 경우 처리할 로직
	      console.log("AJAX 요청 실패:", status, error); // 예시: 에러 메시지 출력
		}
	});
	
}


</script>

<script>
$(function() {
	
	// 모달버튼 클릭 시 날짜 초기화
	$('#select_date_modal').on('click', function() {
	    // 시작일과 종료일 초기화
	    $('#start_date').val("");
	    $('#end_date').val("");
	});	
	
	
	// 테크페이 내역 불러오기
	load_list(pay_history_type, start_date, end_date);
	
	$(window).scroll(function() {
		let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
		let windowHeight = $(window).height(); // 브라우저 창 높이
		let documentHeight = $(document).height(); // 문서 높이
			
		if(scrollTop + windowHeight + 1 >= documentHeight) {
			pageNum++; // 페이지번호 1 층가
			
			// 페이지 번호를 계속 불러오는 현상 막기
			if(maxPage != "" && pageNum <= maxPage) {
				load_list(pay_history_type, start_date, end_date);
			}
		}
		
	});
	
	
	// 기간선택 모달 창 닫으면서 이벤트 처리
    // '조회하기' 버튼 클릭 시 
    $('#searchButton').on('click', function() {
        // 모달 창 내의 시작일과 종료일 가져오기
        var startDate = $('#start_date').val();
        var endDate = $('#end_date').val();

        // 시작일과 종료일 값이 제대로 들어갔는지 확인
        if (!startDate || !endDate) {
            alert("날짜를 선택하세요.");
        } else {
            console.log("시작일: " + startDate + ", 종료일: " + endDate);
        }

        // 모달 창 닫기
        $('#date_modal').modal('hide');
        
        // 임시로 넣어보기
//         $('#payHistoryList').append('<hr>');
// 		<div align="right"></div>
//         $('#payHistoryList').append('<div align="center">' + startDate + ' ~ ' + endDate + '</div>');
//         $('#payHistoryList').append('<hr>');
        $('#payHistoryList').append('<p><strong>선택한 기간: </strong>' + startDate + ' ~ ' + endDate + '</p>');
        $('#payHistoryList').append('<p><strong>선택한 기간: </strong>' + startDate + ' ~ ' + endDate + '</p>');
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


/*---- 기간선택 모달창 ----*/
.ui-datepicker {
    z-index: 9999 !important;
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
	<section>
		<div class="payinfo_container">
	       <!-- 페이 기본 정보 표시  -->
	       <div class="pay_card">
			  <div class="title">
				<h2>${sessionScope.sName} 님</h2>
				<input type="button" value="테크페이 관리" onclick="location.href='PayManage'">
			  </div>
	          <div class="pay_balance">
		        <h2>페이잔액</h2> 
	        	<h2><fmt:formatNumber value="${sessionScope.pay_balance}" pattern="#,###" />원</h2>
	          </div>
	          <!-- 페이 충전/환급 버튼  -->
	          <div class="btn_top">
	            <button class="btn" onclick="location.href='PayCharge'">충전하기</button>
	            <button class="btn" onclick="location.href='PayRefund'">환급하기</button>
	          </div>
	        </div>
			<!-- 페이 이용내역  -->
			<div class="pay_history">
				<!-- 페이 이용내역 탭  -->
				<div class="pay_history_tab">
				   <input type="radio" id="tab1" name="options" class="btn-check" value="" checked>
				   <label for="tab1" class="tab_label">전체</label>
				 
				   <input type="radio" id="tab2" name="options" class="btn-check" value="1">
				   <label for="tab2" class="tab_label">충전</label>
				
				   <input type="radio" id="tab3" name="options" class="btn-check" value="2">
				   <label for="tab3" class="tab_label">환급</label>
				
				   <input type="radio" id="tab4" name="options" class="btn-check" value="3">
				   <label for="tab4" class="tab_label">사용</label>

				   <input type="radio" id="tab5" name="options" class="btn-check" value="4">
				   <label for="tab5" class="tab_label">수익</label>
				</div>
				<!-- 기간 선택 모달창  -->
                <div id="date_select">
		            <button id="select_date_modal" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#date_modal">
		                기간선택 <i class="fa fa-caret-down"></i>
		            </button>
                </div>				
				
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
		                        <br>
	                        <div class="date_area col">
	                            <div class="start_date"><input type="date" id="start_date"></div>
	                            <div class="pattern"> ~ </div>
	                            <div class="end_date"><input type="date" id="end_date"></div>
	                        </div>
		                    </div>
		                    <div class="modal-footer">
		                        <button type="button" class="btn btn-primary" id="searchButton">조회하기</button>
		                    </div>
		                </div>
		            </div>
        		</div>
			</div>
        </div>
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