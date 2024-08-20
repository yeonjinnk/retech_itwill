<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/store/store_pay.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<!-- 포트원 결제 연동 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript">
	//공동현관 출입방법 따라 비밀번호 입력창 노출 제어
	$(function() {
		$('input:radio[name=enter]').click(function() {
			//공동현관 비밀번호에 체크시 입력창 노출
			if($("input[name=enter]:checked").val() == "lock") {
				$(".input_pw").css("display", "block");
			} else {
				//그 외엔 입력창 숨기기
				$(".input_pw").css("display", "none");
			}
		})
	});
	
	//포트원 결제 코드
	//1. SDK 초기화하기
	IMP.init("imp50610540"); // 예: 'imp00000000'

	//2. 결제창 불러오기
	IMP.request_pay(
		{
			pg: "{PG사 코드}.{상점 ID}",
			pay_method: "card",
			merchant_uid: `payment-${crypto.randomUUID()}`, // 주문 고유 번호
			name: "노르웨이 회전 의자",
			amount: 64900,
			buyer_email: "gildong@gmail.com",
			buyer_name: "홍길동",
			buyer_tel: "010-4242-4242",
			buyer_addr: "서울특별시 강남구 신사동",
			buyer_postcode: "01181",
	 	},
		 function (response) {
		 	// 결제 종료 시 호출되는 콜백 함수
		 	// response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,
		 	// 결제 결과를 처리하는 로직을 작성합니다.
		 	},
	 );
	
	
	
</script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<article id="articleForm">
		<h1>주문/결제</h1>
		<div class="left">
			<div class="deliver">
				<table class="tbl_row">
					<tr>
						<th width="150px">배송지 정보</th>
						<td>
							<input type="button" value="배송지 정보 입력">						</td>
					</tr>
					<tr class="table">
						<th>공동현관 출입방법</th>
						<td>
						<input type="radio" id="doorPassword_01" name="enter" value="lock">
						<label for="doorPassword_01">공동현관 비밀번호</label>
						<input type="radio" id="doorPassword_02" name="enter" value="free">
						<label for="doorPassword_02">자유출입 가능</label>
						<input type="text" size="50" class="input_pw" placeholder="정확한 공동현관 출입번호(비밀번호)를 입력 해 주세요."
						maxlength="32">
						</td>
					</tr>
				</table>
				<table class="tbl_row">
					<tr>
						<th>주문상품</th>
						<td>총 	<b>${param.order_store_quantity}</b>개		
						</td>
					</tr>
					<tr class="detail">
						<td><img src="${Store.store_img1}" width="100px" height="100px"></td>
						<td>${Store.store_id}</td>
						<td>${Store.store_price}원</td>
					</tr>
					<tr>
						<th>배송일자</th>
						<td>결제일 후 3일 이내</td>
					</tr>
					<tr class="table">
					</tr>
				</table>
				<table class="tbl_row">
					<tr>
						<th>결제수단</th>
						<td><input type="radio" id="credit" name="payment">
						<label for="credit">신용카드</label></td>
						<td><input type="radio" id="kakaopay" name="payment">
						<label for="kakaopay">카카오페이</label></td>
					</tr>
					<tr class="table">
					</tr>
				</table>
			
			</div>
			<div class="select_product">
			</div>
			<div class="payinfo">
			</div>
			
		</div>
		<div class="right">
			<div class="pay">
				<table class="tbl_row_right">
					<tr>
						<td>상품 금액</td>
						<c:set var="price" value="${Store.store_price}"/>
						<td><c:out value="${price}"/>원</td>
					</tr>
					<tr>
						<td>배송비</td>
						<c:set var="shipping" value="3000"/>
						<td><c:out value="${shipping}"/>원</td>
					</tr>
					<tr>
						<td>최종 결제 금액</td>
						<c:set var="final_price" value="${price + shipping}"/>
						<td><c:out value="${final_price}"/>원</td>
					</tr>
				</table>
						<button type="button" onclick="request_pay()">
							<span class="text">결제하기</span>
						</button>
			</div>
			<div class="agree">
				위 주문내용을 확인하였으며, 결제에 동의합니다
			</div>
			<div class="agree">
						<div class="fold_box_header">주문 상품 정보 동의
						<span class="toggle">▼</span></div>
						<div class="fold_box_contents" id="contents1">
						주문할 상품의 상품명, 가격, 배송정보 등을 최종 확인하였으며, 구매에 동의하십니까? (전자상거래법 제 8조 2항)
						</div>
						<div class="fold_box_header">개인정보 수집 및 이용동의
						<span class="toggle">▼</span></div>
						<div class="fold_box_contents" id="contents2">
							수집하는 개인정보의 항목
							
							① 교보문고는 구매, 원활한 고객상담, 각종 서비스의 제공을 위해 주문 이용 시 아래와 같은 개인정보를 수집하고 있습니다.
							o 필수수집항목 : 이름, 휴대폰번호, 이메일, 수신자정보(성명,주소,휴대폰번호,이메일), 개인통관고유부호(해외직구상품구매시)
							o 수집목적 : 상품배송, 선물하기 서비스 제공, 배송지 관리
							o 보유 및 이용기간 : 회원 탈퇴시 까지(단, 관계 법령에 따름)
							② 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
							- IP Address, 쿠키, 방문 일시, OS종류, 브라우져 종류 서비스 이용 기록, 불량 이용 기록
							
							③ 부가 서비스 및 맞춤식 서비스 이용 또는 이벤트 응모 과정에서 해당 서비스의 이용자에 한해서만 아래와 같은 정보들이 수집될 수 있습니다.
							- 개인정보 추가 수집에 대해 동의를 받는 경우
							
							④ 결제 과정에서 아래와 같은 정보들이 수집될 수 있습니다.
							- 신용카드 결제 시 : 카드사명, 카드번호 등
							- 휴대폰 결제 시 : 이동전화번호, 통신사, 결제승인번호, 이메일주소 등
							- 계좌이체 시 : 은행명, 계좌번호 등
							- 상품권 이용 시 : 상품권 번호
							- 환불시 : 환불계좌정보(은행명, 계좌번호, 예금주명)
							- 제휴포인트 결제시 : 제휴사명, 카드번호
							- 현금영수증 : 휴대폰번호, 현금영수증 카드번호,, 사업자번호
							개인정보의 수집 및 이용목적
							
							“교보문고"는 수집한 개인정보를 다음의 목적을 위해 활용합니다. 이용자가 제공한 모든 정보는 하기 목적에 필요한 용도 이외로는 사용되지 않으며, 이용 목적이 변경될 시에는 사전동의를 구할 것입니다.
							
							① 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산
							- 컨텐츠 제공, 특정 맞춤 서비스 제공, 물품배송 또는 청구서 등 발송, 금융거래 본인 인증 및 금융 서비스, 구매 및 요금 결제, 요금추심 등
							
							② 비회원 관리
							- 비회원 구매 서비스 이용에 따른 본인 확인, 개인 식별, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달
							
							개인정보 보유 및 이용기간
							
							이용자의 개인정보는 원칙적으로 회원탈퇴 시 지체없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.
							
							① 회사 내부 방침에 의한 정보보유 사유
							- 보존 항목 : 아이디(ID), 회원번호
							- 보존 근거 : 서비스 이용의 혼선 방지
							- 보존 기간 : 영구
							
							② 관계 법령에 의한 정보보유 사유
							'‘상법’, ‘전자상거래 등에서의 소비자보호에 관한 법률’ 등 관계 법령의 규정에 의하여 보존할 필요가 있는 경우 관계 법령에서 정한 일정한 기간 동안 개인정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존 기간은 아래와 같습니다.
							
							1. 계약 또는 청약철회 등에 관한 기록
							- 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률
							- 보존 기간 : 5년
							2. 대금결제 및 재화 등의 공급에 관한 기록
							- 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률
							- 보존 기간 : 5년
							3. 소비자의 불만 또는 분쟁처리에 관한 기록
							- 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률
							- 보존 기간 : 3년
							4. 웹사이트 방문기록
							- 보존 근거 : 통신비밀보호법
							- 보존 기간 : 3개월						</div>
						<div class="fold_box_header">제3자 제공에 대한 동의
						<span class="toggle">▼</span></div>
						<div class="fold_box_contents" id="contents3">
							제공업체 : 아이온코리아/인터넷
							제공항목
							주문자 : 이름, 휴대폰번호, 이메일주소, 개인통관고유부호(해외 직구상품 구매시)
							수신자 : 이름, 휴대폰번호, 전화번호, 배송주소
							제공목적 : 상품배송, 고객상담 및 불만처리, 관세법에 따른 세관 신고(해외 직구상품 구매 시)
							보유 및 이용기간 : 개인정보 이용목적 달성 시까지 보존합니다. 단, 관계 법령의 규정에 의하여 일정 기간 보존이 필요한 경우에는 해당 기간만큼 보관 후 삭제합니다.
							
							이용자는 제공을 거부하실 수 있는 권리가 있으며, 거부 시에는 서비스 이용이 불가합니다.						</div>
			
			</div>
		
		</div>
	<script type="text/javascript">
	$(function() {
	    $(".fold_box_contents").hide();  // 모든 내용 숨기기
	    $('.toggle').click(function() {
	        let index = $('.toggle').index(this);
	        console.log("index : " + index);
// 	        console.log($("#contents" + (index + 1)).css("display"));
	        if($("#contents" + (index + 1)).css("display")=="none") {
	        	$("#contents" + (index + 1)).show();       // 대상 내용만 표시하기
	        } else {
	        	$("#contents" + (index + 1)).hide();       // 대상 내용만 표시하기
	        }
	    	
	    });
	});
	</script>
	</article>
		<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>