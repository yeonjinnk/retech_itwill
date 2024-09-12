<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매내역</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/resources/css/mypage/purchaseStorehistory.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style type="text/css">
     .tabs a.selected {
            background-color: #34495e;
            color: #fff;
        }
        
    .sidebar a.selected {
            background-color: #34495e;
            color: #fff;
        } 
        
       .main-content {
	    display: flex;
	    flex: 1;
	    overflow: hidden;
	    margin-top: 0px;
	} 
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.cancel-request').on('click', function() {
                var trade_idx = $(this).data('id');
                if (confirm('거래취소를 요청하시겠습니까?')) {
                    $.ajax({
                        url: 'updateTradeStatusAjax',
                        type: 'POST',
                        data: {
                            trade_idx: trade_idx,
                            trade_status: '4'
                        },
                        success: function(response) {
                            if(response.success) {
                                alert('거래가 취소되었습니다.');
                                location.reload(); // 페이지 새로고침
                            } else {
                                alert('거래 취소 중 오류가 발생했습니다.');
                            }
                        }
                    });
                }
            });

            $('.confirm-request').on('click', function() {
                var productId = $(this).data('id');
                if (confirm('거래 확정하시겠습니까?')) {
                    $.ajax({
                        url: 'updateTransactionStatus',
                        type: 'POST',
                        data: {
                            id: productId,
                            status: '거래확정'
                        },
                        success: function(response) {
                            if(response.success) {
                                alert('거래가 확정되었습니다.');
                                location.reload(); // 페이지 새로고침
                            } else {
                                alert('거래 확정 중 오류가 발생했습니다.');
                            }
                        }
                    });
                }
            });

            $('.review-request').on('click', function() {
                var productId = $(this).data('id');
                window.location.href = '${pageContext.request.contextPath}/writeReview?id=' + productId;
            });
        });
    </script>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <div class="main-content">
        <div class="sidebar">
            <a href="SaleHistory">판매내역</a>
            <a href="PurchaseHistory">구매내역</a>
            <a href="PurchaseStoreHistory" class="selected">스토어 구매내역</a>
            <a href="Wishlist">찜한상품</a>
            <a href="CsHistory">문의내역</a>
            <a href="MemberInfo">회원정보수정</a>
        </div>

        <div class="content-area">
             <div class="store-info">
                <div>
                <c:choose>
                	<c:when test="${empty member.member_profile}"><img src="https://cdn.litt.ly/images/U0UQOgi7NRuOXgn6LHSikIDTy1TWh688?s=1200x630&m=inside"></c:when>
                	<c:otherwise><img src="${pageContext.request.contextPath}/resources/images/${member.member_profile}"></c:otherwise>
                </c:choose>
                
                    <h2>상점 정보</h2>
                    <p>상점명: ${member.member_nickname}</p>
                    <p>지역: ${member.member_address1}</p>
                     <c:choose>
                    	<c:when test="${member.member_starRate eq 0.0}">
                    <p>신뢰지수: -     (<a href="ProductRegistForm"> !!이곳을 클릭해 판매를 시작해주세요!! )</a></p>
                    	</c:when>
                    	<c:otherwise>
                    <p>신뢰지수: ${member.member_starRate}</p>
                    	</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <ul class="tabs">
                <li><a href="#" class="selected">구매내역</a></li>
            </ul>

            <div class="content">
                <c:if test="${not empty storeHistoryList}">
                    <table>
                        <thead>
                            <tr>
                                <th>상품사진</th>
                                <th>상품명</th>
                                <th>상품가격</th>
                                <th>구매날짜</th>
                                <th>구매수단</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="store" items="${storeHistoryList}">
<%--                                 <c:if test="${product.pd_status == '결제완료' ||  --%>
<%--                                              product.pd_status == '거래취소 요청' ||  --%>
<%--                                              product.pd_status == '거래취소 확정' ||  --%>
<%--                                              product.pd_status == '거래확정'}"> --%>
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty store.store_img1}">
                                                    <img src="${store.store_img1}" alt="${store.store_content}" class="product-image"/>
                                                </c:when>
                                                <c:otherwise>
                                                    No Image
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><a href="${pageContext.request.contextPath}/StoreDetail?store_idx=${store.store_idx}">${store.store_id}</a></td>
<%--                                         <td>${product.pd_content}</td> --%>
                                        <td>${store.order_store_pay}</td>
                                        <td>${store.order_store_date}</td>
                                        <td>${store.order_store_method}</td>
                                    </tr>
<%--                                 </c:if> --%>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty storeHistoryList}">
                    <table class="mypage">
                        <tr>
                            <td align="center" colspan="6">검색결과가 없습니다.</td>
                        </tr>
                    </table>
                </c:if>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>
 