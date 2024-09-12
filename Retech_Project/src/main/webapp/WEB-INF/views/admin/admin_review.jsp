<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 목록</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/admin_default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/admin/admin_store.css" rel="stylesheet" type="text/css">
</head>
		<script>
			function confirmDelete(review_idx){
				if(confirm("리뷰를 삭제하시겠습니까?")){
					location.href="AdminReviewDelete?review_idx=" + review_idx;
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
                <h3>리뷰 목록</h3>
                
                <form action="AdminReview">
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
					        <th>판매자</th>
					        <th>구매자</th>
					        <th>별점</th>
					        <th>리뷰내용</th>
					        <th>삭제</th>
					    </tr>
					    <c:set var="pageNum" value="1" />
					    <c:if test="${not empty param.pageNum}">
					        <c:set var="pageNum" value="${param.pageNum}" />
					    </c:if>
					    <c:forEach var="review" items="${reviewList}">
					        <tr align="center">
					            <td>${review.review_idx}</td>
					            <td>${review.trade_seller_id}</td> <!-- 수정된 부분 -->
					            <td>${review.trade_buyer_id}</td>
					            <td>${review.review_star_rating}</td>
					            <td>${review.review_content}</td>
					            <td>
									<input type="button" class="delete" value="삭제" onclick="confirmDelete('${review.review_idx}')">
								</td>
					        </tr>
					    </c:forEach>
					    <c:if test="${empty reviewList}">
					        <tr>
					            <td align="center" colspan="7">검색 결과가 없습니다.</td>
					        </tr>
					    </c:if>
					</table>
                </div>
                <div id="pageList">
                    <input type="button" value="이전" 
                        onclick="location.href='AdminReview?pageNum=${pageNum - 1}'" 
                        <c:if test="${pageNum eq 1}"> disabled</c:if> />
                    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                        <c:choose>
                            <c:when test="${i eq pageNum}">
                                <b>${i}</b>
                            </c:when>
                            <c:otherwise>
                                <a href="AdminReview?pageNum=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <input type="button" value="다음" 
                        onclick="location.href='AdminReview?pageNum=${pageNum + 1}'" 
                        <c:if test="${pageNum eq pageInfo.endPage}"> disabled</c:if> />
                </div>
            </article>
        </section>
    </div>
</body>
</html>
