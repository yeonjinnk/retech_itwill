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
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
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
						<td>총 	<b>${param.order_store_quantity}</b>개		
						</td>
					</tr>
					<tr>
						<td><img src="${Store.store_img1}" width="100px" height="100px"></td>
						<td>${Store.store_id}</td>
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
						<button type="button">
							<span class="text">결제하기</span>
						</button>
			</div>
			<div class="agree">
				위 주문내용을 확인하였으며, 결제에 동의합니다
			</div>
			<div class>
				<ul class="fold_box_list">
					<li class="fold_box expanded">
						<div class="fold_box_header">주문 상품 정보 동의
							<button type="button" class="btn_fold">▽
								<span class="hidden">컨텐츠 닫기</span>
							</button>
						</div>
						<div class="fold_box_contents">
						
						</div>
					</li>
				</ul>
			
			</div>
		
		</div>
	<script type="text/javascript">
		$(function () {
			$(".btn_fold").click(function() {
				
			}) 
				
			}
			
		});
	</script>
	</article>
		<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>