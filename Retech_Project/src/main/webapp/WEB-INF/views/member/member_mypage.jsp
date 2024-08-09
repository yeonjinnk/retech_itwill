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
            background-color: #FF0000;
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
				<li><a href="MyPageMain" class="selected">예매/취소내역</a></li>
				<li><a href="MyPage_CouponList" class="">관람권/쿠폰</a></li>
				<li><a href="Cs" class=" loginpop">나의
						문의내역</a></li>
			</ul>
		</div>
		
		<div class="section group section-mypage">
    <div class="wrap-main">
        <div class="selector-list">
            <a href="#" onclick="fnReserveList(false); return false;" class="selected">예매/구매내역</a>
            <a href="#" onclick="fnCancelList(false); return false;">취소내역</a>
        </div>
        <div class="content">
						<table border="1" >
							<tr>
								<th width="100px">예매번호</th>
								<th width="120px">예매자 회원번호</th>
								<th width="160px">영화</th>
								<th width="120px">상영일</th>
								<th width="160px">극장</th>
								<th width="120px">예매상태</th>								
							</tr>
							
							<%-- 페이지번호(pageNum 파라미터) 가져와서 저장(없을 경우 기본값 1로 설정) --%>
							<c:set var="pageNum" value="1" />
							<%-- pageNum 파라미터 존재할 경우(= 비어있지 않음) 판별 --%>
							<c:if test="${not empty param.pageNum}">
								<%-- pageNum 변수에 pageNum 파라미터값 저장 --%>
								<c:set var="pageNum" value="${param.pageNum}" />
							</c:if>
							
							<c:forEach var="orderTicket" items="${orderticket2}">
							    <tr align="center">
							        <td>${orderTicket.order_ticket_id}</td>
							        <td>${orderTicket.order_ticket_member_num}</td>
							        <td>${orderTicket.movie_name_kr}</td>
							        <td>
							            <fmt:parseDate value="${orderTicket.order_ticket_date}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both"/>
							            <fmt:formatDate pattern="yyyy-MM-dd" value="${parsedDateTime}"/>
							        </td>
							        <td>${orderTicket.theater_name}</td>
							        <td>
							            ${orderTicket.order_ticket_status}
							            <form action="" method="post">
							                <input type="hidden" name="orderId" value="${orderTicket.order_ticket_id}">
							                <input type="submit" value="취소">
							            </form>
							        </td>
							    </tr>
							</c:forEach>

							
							<c:if test="${empty orderticket2}">
								<tr>
									<td align="center" colspan="8">검색결과가 없습니다.</td>
								</tr>
							</c:if>
						</table>
					</div>
        
        <ul class="list-movie"></ul>
        <a href="#" class="btn-more" style="display: none;">더보기 +</a>
    </div><!--.wrap-->
    <ul class="mypage-movie-expl">
        <li>상영시간 20분 전(F&amp;B는 2시간 전)까지만 취소가 가능합니다.</li>
        <li>지연입장에 의한 관람불편을 최소화하고자 본 영화는 약 10분후 시작합니다.</li>
        <li>쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.</li>
        <li>모바일 캡쳐 화면 소지 시 입장 제한을 받을 수 있습니다.</li>
        <li>모바일 티켓으로 입장 완료된것은 온라인 취소가 불가합니다.</li>
    </ul>
</div>

	</article>
	<footer>
			<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
		</footer>
	</body>
</html>