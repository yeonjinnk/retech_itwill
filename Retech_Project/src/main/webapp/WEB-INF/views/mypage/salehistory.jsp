<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매내역</title>
    <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            display: flex;
            flex-direction: column;
            font-family: Arial, sans-serif;
        }

        .main-content {
            display: flex;
            flex: 1;
            overflow: hidden;
        }
        
		.store-info img {
            border-radius: 50%;
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }
        
        .sidebar {
            width: 250px;
            background-color: #f4f4f4;
            padding: 20px;
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
            height: calc(100vh - 150px);
            overflow-y: auto;
        }

        .sidebar a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #333;
            border-radius: 5px;
            margin-bottom: 10px;
            transition: background-color 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #ddd;
        }

        .sidebar a.selected {
            background-color: #34495e;
            color: #fff;
        }

        .content-area {
            flex: 1;
            padding: 20px;
            background-color: #f9f9f9;
            overflow-y: auto;
            justify-content: center;
        }

        .store-info {
            background-color: #f5f5f5;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            width: 80%;
            margin: 0 auto;
        }

        .store-info h2 {
            margin-top: 0;
        }

        .tabs {
            margin-bottom: 20px;
            list-style-type: none;
            padding: 0;
            display: flex;
            margin-left: 140px;
        }

        .tabs li {
            margin-right: 10px;
        }

        .tabs a {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            color: #000;
            background-color: #eee;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .tabs a.selected {
            background-color: #34495e;
            color: #fff;
        }

        .content {
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 10px;
            width: 80%;
            margin: 0 auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        .product-image {
            width: 100px;
            height: 100px;
        }

        .status-buttons {
            display: flex;
            gap: 10px;
        }

        .status-buttons button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            font-size: 14px;
        }

        .cancel-request {
            background-color: #f44336; 
        }

        .confirm-request {
            background-color: #4caf50; 
        }

        .review-request {
            background-color: #2196F3; 
        }

        .cancel-request:hover {
            background-color: #d32f2f;
        }

        .confirm-request:hover {
            background-color: #388e3c;
        }

        .review-request:hover {
            background-color: #1976D2;
        }
        
        
/* .store-info { */
/*     display: flex; /* 플렉스박스를 사용하여 아이템을 정렬합니다 */ */
/*     align-items: flex-start; /* 아이템을 상단에 맞춥니다 */ */
/* } */

/* .store-info > div { */
/*     flex: 1; /* 왼쪽 영역이 가능한 많은 공간을 차지하도록 합니다 */ */
/* } */

/* .store-info > div img { */
/*     max-width: 100%; /* 이미지가 부모 요소의 너비를 넘지 않도록 설정합니다 */ */
/*     height: auto; /* 이미지 비율을 유지하도록 합니다 */ */
/* } */

/* .store-info .progress-container { */
/*     display: flex; */
/*     flex-direction: column; */
/*     align-items: flex-end; /* 오른쪽에 정렬합니다 */ */
/*     margin-left: 20px; /* 왼쪽 여백을 추가하여 내용과 간격을 둡니다 */ */
/* } */

.store-info .progress-container {
    float: right; /* 오른쪽으로 떠 있게 설정합니다 */
    margin-left: 800px; /* 왼쪽 여백을 추가하여 내용과 간격을 둡니다 */
}     
        
        
        
        
         #progress {
    appearance: none;
}
#progress::-webkit-progress-bar {
    background:#f0f0f0;
    border-radius:10px;
    box-shadow: inset 3px 3px 10px #ccc;
     height: 20px;
        width: 400px;
    
}
#progress::-webkit-progress-value {
    border-radius:10px;
    background: #34495E; /* 베이스 색상 */
    background: -webkit-linear-gradient(to right, #BDC3C7, #34495E); /* WebKit 브라우저용 그라디언트 */
    background: linear-gradient(to right, #BDC3C7, #34495E); /* 모든 브라우저용 그라디언트 */

}
        
        
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            // 날짜 형식 변환 함수
            function formatDate(dateString) {
                const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
                const date = new Date(dateString);
                return date.toLocaleDateString('ko-KR', options); // 'ko-KR'은 한국 날짜 형식
            }

            // 모든 날짜 셀을 찾아서 변환
            $('td[data-date]').each(function() {
                const dateString = $(this).data('date');
                if (dateString) {
                    $(this).text(formatDate(dateString));
                }
                
                
            });

            // 거래취소승인 버튼 클릭 시
            $('.cancel-request2').on('click', function() {
            	// 거래 상태 '5. 거래취소승인'으로 변경
                var trade_pd_idx = $(this).data('id');
                var productId = $(this).data('id');
                if (confirm('거래취소를 승인하시겠습니까?')) {
                    $.ajax({
                        url: 'updateTradeStatusAjax',
                        type: 'POST',
                        data: {
                        	trade_pd_idx: trade_pd_idx,
                            trade_status: '5'
                        },
                        success: function(response) {
                            if(response.success) {
                            	console.log("============거래취소승인-거래상태5로 변경완료==========");
                            	
			                    $.ajax({
			                        url: 'updateTradeStatusAjax2',
			                        type: 'POST',
			                        data: {
			                            id: productId,
			                            status: '판매중'
			                        },
			                        success: function(response) {
			                            if(response.success) {
		                            	console.log("===============거래취소승인완료-상품상태판매중으로 변경완료===========");
			                                alert('거래취소 승인이 완료되었습니다.');
			                                location.reload(); // 페이지 새로고침
			                            } else {
			                                alert('거래 취소 승인 중 오류가 발생했습니다.');
			                            }
			                        }
			                    });
                            	
                            } else {
                                alert('거래취소 승인 중 오류가 발생했습니다.');
                            }
                        }
                    });
                    
                }
                
                
                // 상품 상태 '판매중'으로 변경
//                 if (confirm('거래를 취소하시겠습니까?')) {
//                 }
                
                
            });

            // 거래 확정 버튼 클릭 시
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
        });
    </script>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
    </header>

    <div class="main-content">
        <div class="sidebar">
            <c:choose>
                <c:when test="${not empty param.member_id}">
                    <!-- member_id 파라미터가 있을 때 -->
                    <a href="SaleHistory?member_id=${param.member_id}" class="selected">판매내역</a>
                    <a href="PurchaseHistory?member_id=${param.member_id}">구매내역</a>
                    <a href="Wishlist?member_id=${param.member_id}">찜한상품</a>
                </c:when>
                <c:otherwise>
                    <!-- member_id 파라미터가 없을 때 -->
                    <a href="SaleHistory" class="selected">판매내역</a>
                    <a href="PurchaseHistory">구매내역</a>
                    <a href="PurchaseStoreHistory">스토어 구매내역</a>
                    <a href="Wishlist">찜한상품</a>
                    <a href="CsHistory">문의내역</a>
                    <a href="MemberInfo">회원정보수정</a>
                </c:otherwise>
            </c:choose>
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
                <p>신뢰지수: -     (<a href="ProductRegistForm"> !!이곳을 클릭해 판매를 시작해주세요!! </a>)</p>
            </c:when>
            <c:otherwise>
                <p>신뢰지수: ${member.member_starRate} / 5.0</p>
            </c:otherwise>
        </c:choose>
                </div>
<!--                 <div class="progress-container"> -->
                    <progress id="progress" value="${member.member_starRate}" min="0" max="5.0"></progress>
<!--                 </div> -->
            </div>

            <ul class="tabs">
                <li><a href="#" class="selected">판매내역</a></li>
                <li><a href="SellerReview?member_id=${param.member_id}">받은 리뷰</a></li>
            </ul>

            <div class="content">
                <c:if test="${not empty saleList}">
                    <table>
                        <thead>
                            <tr>
                                <th>상품사진</th>
                                <th>상품명</th>
                                <th>상품가격</th>
                                <th>등록날짜</th>
                                <th>거래상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${saleList}">
                               <tr>
                                   <td>
                                       <c:choose>
                                           <c:when test="${not empty product.pd_image1}">
                                               <img src="${pageContext.request.contextPath}/resources/img/main/${product.pd_image1}" class="product-image"/>
                                           </c:when>
                                           <c:otherwise>
                                               No Image
                                           </c:otherwise>
                                       </c:choose>
                                   </td>
                                   <td><a href="${pageContext.request.contextPath}/productDetail?pd_idx=${product.pd_idx}">${product.pd_subject}</a></td>
                                   <td><fmt:formatNumber value="${product.pd_price}" pattern="#,##0"/></td>
                                   <td data-date="${product.pd_first_date}"></td>
                                   <td>
                                       <c:choose>
                                           <c:when test="${product.trade_status == '0'}">
                                            판매대기
                                           </c:when>
                                           <c:when test="${product.trade_status == '1'}">
                                            결제대기
                                           </c:when>
                                           <c:when test="${product.trade_status == '2'}">
                                            결제완료
                                           </c:when>
                                           <c:when test="${product.trade_status == '3'}">
                                            거래확정
                                           </c:when>
                                           <c:when test="${product.trade_status == '4'}">
                                               <button class="status-button cancel-request" data-id="${product.pd_idx}">거래취소승인</button>
                                           </c:when>
                                           <c:when test="${product.trade_status == '5'}">
                                            거래취소승인완료
                                           </c:when>
                                           <c:when test="${product.trade_status == '6'}">
                                            거래확정(리뷰완료)
                                           </c:when>
                                       </c:choose>
                                   </td>
                                        </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty saleList}">
                    <table class="mypage">
                        <tr>
                            <td align="center" colspan="6">검색결과가 없습니다.</td>
                        </tr>
                    </table>
                </c:if>
            </div>
        </div>
    </div>

</body>
</html>
