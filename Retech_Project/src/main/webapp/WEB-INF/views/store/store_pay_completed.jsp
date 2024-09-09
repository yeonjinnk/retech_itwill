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

</head>
<body>
<script type="text/javascript">
	
	
</script>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<article id="articleForm">
		<h1>결제 완료!</h1>
		<button type="button">구매내역 보기</button>
		
		<div class="left">
			<div class="deliver">
				<table class="tbl_row">
					<tr>
						<th width="150px">배송지 정보</th>
						<td>
							<input type="button" value="배송지 정보 입력"></td>
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
						<td>${amt}원</td>
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
						<td><input type="radio" id="credit" name="payment" value="신용/체크카드">
						<label for="credit">신용/체크카드</label></td>
						<td><input type="radio" id="kakaopay" name="payment" value="카카오페이">
						<label for="kakaopay">카카오페이</label></td>
						<td><input type="radio" id="naverpay" name="payment" value="네이버페이">
						<label for="naverpay">네이버페이</label></td>
					</tr>
					<tr class="table">
					</tr>
				</table>
				<table>
				
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
						<td>${amt}원</td>
					</tr>
					<tr>
						<td>배송비</td>
						<td>3000원</td>
					</tr>
					<tr>
						<td>최종 결제 금액</td>
						<td>${order_store_pay}원</td>
					</tr>
				</table>
						<button type="button" id="nexBtn" onclick="pay()">결제하기</button>	
			</div>
	</article>
		<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>