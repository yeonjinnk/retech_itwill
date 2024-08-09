<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>index</title>
		<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
		<style type="text/css">
		article {
            max-width: 1000px; /* 최대 가로폭 설정 */
            margin: 0 auto; /* 가운데 정렬을 위해 margin 설정 */
            padding: 20px; /* 내부 여백 추가 */
        }
 .mypage {
            width: 100%;
            border-collapse: collapse;
        }

        .mypage td {
            border: 1px solid #000;
            padding: 10px;
            text-align: center;
            width: 10%; /* 각 셀의 너비를 10%로 설정 */
        }
        
               .section-mypage-select {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .selector-summary {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
        }

        .selector-summary li {
            margin-right: 10px;
        }

        .selector-summary li a {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            color: #000;
            background-color: #eee;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .selector-summary li a.selected {
            background-color: #ff0000;
            color: #fff;
        }
        
  .section-mypage-summary {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f5f5f5;
            border-radius: 10px;
        }
        .summary {
            flex: 1;
            margin: 0 10px;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
		</style>
	</head>
	<body>
		<header>
			<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		</header>

	<article>
		<div class="section group section-mypage-summary">
			<div class="summary summary-1">
				<div class="회원정보">
					회원정보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span><a href="MemberInfo" class="btn btn-top">회원정보 관리</a></span>
				</div>
				<div class="username">
					${sName}
				</div>
				<a href="/MyPage/Exchange" ></a>

				<div class="username">
					선호극장 <span class="right">신도림</span>
				</div>
			</div>
			<div class="summary summary-2">
					최근 예매 <span class="num">( 0 )</span>
			</div>
			<div class="summary summary-3">
				나의 관람권/쿠폰&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span> <a href="#" class="btn btn-top">신규등록</a></span>
				 <span class="coupon-box">
					<input type="text" name="coupon" class="input-coupon"
					placeholder="관람권/쿠폰 번호를 빈칸 없이 입력해주세요."> <a href="#"
					class="btn-register-coupon">등록</a>
				</span>
				<ul class="list-cp">
					<li><a class="btn-cp" onclick="return false;">사용 가능한 영화 쿠폰
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 매</a></li>
				</ul>
			</div>
		</div>
		<div class="section group section-mypage-select">
			<ul class="selector-summary">
				<li><a href="MyPageMain" class="">예매/취소내역</a></li>
				<li><a href="MyPage_CouponList" class="selected">관람권/쿠폰</a></li>
				<li><a href="Cs" class=" loginpop">나의
						문의내역</a></li>
			</ul>
		</div>
		<div class="content">
						<table border="1" >
							<tr>
								<th width="100px">구매상품명</th>
								<th width="400px">구매상품구성</th>
								<th width="200px">구매날짜</th>
								<th width="120px">구매수량</th>
							</tr>
							
							<%-- 페이지번호(pageNum 파라미터) 가져와서 저장(없을 경우 기본값 1로 설정) --%>
							<c:set var="pageNum" value="1" />
							<%-- pageNum 파라미터 존재할 경우(= 비어있지 않음) 판별 --%>
							<c:if test="${not empty param.pageNum}">
								<%-- pageNum 변수에 pageNum 파라미터값 저장 --%>
								<c:set var="pageNum" value="${param.pageNum}" />
							</c:if>
							
							<c:forEach var="orderItem2" items="${orderItem2}">
								<tr align="center">
									<td>${orderItem2.item_name}</td>
									<td>${orderItem2.item_content}</td>
									<td><fmt:parseDate value="${orderItem2.order_item_purchase_date}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both"/>
			<fmt:formatDate pattern="yyyy-MM-dd" value="${parsedDateTime}"/></td>
									<td>${orderItem2.order_item_sales_rate}</td>
								 	
								</tr>
							</c:forEach>
							<c:if test="${empty orderItem2}">
								<tr>
									<td align="center" colspan="8">검색결과가 없습니다.</td>
								</tr>
							</c:if>
						</table>
					</div>
 
	</article>
	<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
	</body>
</html>