<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/admin_default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/admin/admin_store.css" rel="stylesheet" type="text/css">
</head>
		<script>
			function confirmDelete(trade_idx){
				if(confirm("거래를 삭제하시겠습니까?")){
					location.href="AdminReviewDelete?trade_idx=" + trade_idx;
				}
			}
			
		</script>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/admin_top.jsp"></jsp:include>
    </header>
    <div class="inner">
        <section class="wrapper">
            <jsp:include page="/WEB-INF/views/inc/admin_side_nav.jsp"></jsp:include>
            <article class="main">
                <h3>거래 목록</h3>
                
                <form action="AdminTrade">
							<div class="search">
								<span>Search</span>
								<input type="search" name="searchKeyword" value="${param.searchKeyword}" >
								<input type="submit" value="검색">
							</div>
						</form>
                <div class="content">
                    <table border="1">
					    <tr>
					        <th>상품번호</th>
					        <th>상품명</th>
					        <th>상품상태</th>
					        <th>판매자</th>
					        <th>등록날짜</th>
					        <th>삭제</th>
					    </tr>
					    <c:set var="pageNum" value="1" />
					    <c:if test="${not empty param.pageNum}">
					        <c:set var="pageNum" value="${param.pageNum}" />
					    </c:if>
					    <c:forEach var="trade" items="${TradeList}">
					        <tr align="center">
					            <td>${trade.trade_idx}</td>
					            <td>${trade.pd_subject}</td> <!-- 수정된 부분 -->
					            <td>${trade.pd_status}</td>
					            <td>${trade.trade_seller_id}</td>
					            <td>${trade.pd_first_date}</td>
					            <td>
									<input type="button" class="delete" value="삭제" onclick="confirmDelete('${trade.trade_idx}')">
								</td>
					        </tr>
					    </c:forEach>
					    <c:if test="${empty TradeList}">
					        <tr>
					            <td align="center" colspan="7">검색 결과가 없습니다.</td>
					        </tr>
					    </c:if>
					</table>
                </div>
					<div id="pageList">
						<input type="button" value="이전" 
								onclick="location.href='AdminTrade?pageNum=${pageNum - 1}'">
						
						<%-- 계산된 페이지 번호가 저장된 PageInfo 객체(pageInfo)를 통해 페이지 번호 출력 --%>
						<%-- 시작페이지(startPage = begin) 부터 끝페이지(endPage = end)까지 1씩 증가하면서 표시 --%>
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<%-- 각 페이지마다 하이퍼링크 설정(페이지번호를 pageNum 파라미터로 전달) --%>
							<%-- 단, 현재 페이지(i 값과 pageNum 파라미터값이 동일)는 하이퍼링크 없이 굵게 표시 --%>
							<c:choose>
								<c:when test="${i eq pageNum}">
									<b>${i}</b> <%-- 현재 페이지 번호 --%>
								</c:when>
								<c:otherwise>
									<a href="AdminTrade?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<%-- [다음] 버튼 클릭 시 BoardList 서블릿 요청(파라미터 : 현재 페이지번호 + 1) --%>
						<%-- 현재 페이지 번호(pageNum)가 URL 파라미터로 전달되므로 ${param.pageNum} 활용 --%>
						<%-- 단, 현재 페이지 번호가 최대 페이지번호(maxPage)보다 작을 경우에만 동작(아니면, 버튼 비활성화 처리) --%>
						<%-- 두 가지 경우의 수에 따라 버튼을 달리 생성하지 않고, disabled 만 추가 여부 설정 --%>
						<%-- pageNum 파라미터값이 최대 페이지번호 이상일 때 disabled 속성 추가 --%>
						<input type="button" value="다음" 
								onclick="location.href='AdminTrade?pageNum=${pageNum + 1}'">
					</div>
            </article>
        </section>
    </div>
</body>
</html>
