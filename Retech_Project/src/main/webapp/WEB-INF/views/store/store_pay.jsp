<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet"> --%>
<link href="${pageContext.request.contextPath}/resources/css/store/store_pay.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
	<article id="articleForm">
		<h1>주문/결제</h1>
		<div class="left">
			<div class="deliver">
				<table class="tbl_row">
					<tr>
						<th>배송지 정보</th>
						<td>
							<input type="button" value="배송지 정보 입력">						</td>
					</tr>
					<tr class="table">
						<th>공동현관 출입방법</th>
						<td>
						<input type="radio" id="doorPassword_01">
						<label for="doorPassword_01">공동현관 비밀번호</label>
						<input type="radio" id="doorPassword_02">
						<label for="doorPassword_01">자유출입 가능</label>
						<input type="text" placeholder="정확한 공동현관 출입번호(비밀번호)를 입력 해 주세요."
						maxlength="32">
						</td>
					</tr>
				</table>
				<table class="tbl_row">
					<tr>
						<th>주문상품</th>
						<td>총 				
						</td>
					</tr>
					<tr class="table">
					</tr>
				</table>
				<table class="tbl_row">
					<tr>
						<th>결제수단</th>
						<td>총 				
						</td>
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
			</div>
			<div class="agree">
				위 주문내용을 확인하였으며, 결제에 동의합니다
			</div>
		
		</div>
	
	</article>
</body>
</html>