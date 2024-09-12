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
    <link href="${pageContext.request.contextPath}/resources/css/mypage/purchasehistory.css" rel="stylesheet" type="text/css">
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
        }

        .store-info {
            background-color: #f5f5f5;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
        }

        .store-info h2 {
            margin-top: 0;
        }

        .tabs {
            margin-bottom: 20px;
            list-style-type: none;
            padding: 0;
            display: flex;
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
        
        
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function() {
        $('.cancel-request').on('click', function() {
            var trade_pd_idx = $(this).data('id');
            if (confirm('거래취소를 요청하시겠습니까?')) {
                $.ajax({
                    url: 'updateTradeStatusAjax',
                    type: 'POST',
                    data: {
                    	trade_pd_idx: trade_pd_idx,
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
            var trade_pd_idx = $(this).data('id');
            var productId = $(this).data('id');
            if (confirm('거래를 확정하시겠습니까?')) {
                $.ajax({
                    url: 'updateTradeStatusAjax',
                    type: 'POST',
                    data: {
                    	trade_pd_idx: trade_pd_idx,
                        trade_status: '3'
                    },
                    success: function(response) {
                        if(response.success) {
                        	console.log("============거래확정-거래상태3으로 변경완료==========");
                        	
		                    $.ajax({
		                        url: 'updateTradeStatusAjax2',
		                        type: 'POST',
		                        data: {
		                            id: productId,
		                            status: '판매완료'
		                        },
		                        success: function(response) {
		                            if(response.success) {
	                            	console.log("===============거래확정-상품상태판매완료로 변경완료===========");
		                                alert('거래확정이 완료되었습니다.');
		                                location.reload(); // 페이지 새로고침
		                            } else {
		                                alert('거래확정 중 오류가 발생했습니다.');
		                            }
		                        }
		                    });                           	
                        	
                        } else {
                            alert('거래 확정 중 오류가 발생했습니다.');
                        }
                    }
                });
            }
        });
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
            

//             $('.review-request').on('click', function() {
//                 var productId = $(this).data('id');
//                 window.location.href = '${pageContext.request.contextPath}/writeReview?id=' + productId;
//             });
            
            
            //모달창 기본 숨김
            $(".modalOpen").hide();
            
            //리뷰쓰기 버튼 클릭 시 모달창 띄움
            $(".review-request").click(function() {
				console.log("리뷰쓰기 버튼 클릭됨!");
				let pd_idx = $(this).data('id');
				$(".modalOpen").show();
				console.log("리뷰쓰기 모달 띄움!");
				
				
				
				
			      //별점 클릭 이벤트 처리
	    		$('.starRev span').click(function(){
	    			//모든 별에서 'on' 클래스를 제거
	    			  $(this).parent().children('span').removeClass('on');
	    			
	    			//클릭된 별 및 이전 별들에 'on' 클래스 추가
	    			  $(this).addClass('on').prevAll('span').addClass('on');
	    			  return false;
	    			});
	    		
	    		// 버튼 클릭 시 별점 및 리뷰 내용을 콘솔에 출력
	    	    $('#btnReviewSub').click(function(){
	    	    	//별점 = 'on' 클래스 총 길이
	    	        let starCount = $('.starRev .starR.on').length; // 별점 개수
	    	        let reviewContent = $('#content').val(); // 리뷰 내용

	    	        console.log('별점: ' + starCount);
	    	        console.log('리뷰 내용: ' + reviewContent);
	    	        
	    	        let review_writer = "${sessionScope.sId}";
// 	    	        let review_pd_idx = $("#pd_idx").val();
// 	    	        console.log("!!!!!!!!!!!review_pd_idx : " + review_pd_idx);
	    	        let review_star_rating = starCount;
	    	        let review_content = reviewContent;
	    	        console.log("!!!!!!!!!!!!!!!!!!!! review_writer : " + review_writer);
	    	        console.log("!!!!!!!!!!!!!!!!!!!! review_star_rating : " + review_star_rating);
	    	        console.log("!!!!!!!!!!!!!!!!!!!! review_content : " + review_content);
	    	        
	    	        $.ajax({
	    	        	data: {
	    	        		review_writer: review_writer,
	    	        		review_pd_idx: pd_idx,
	    	        		review_star_rating: review_star_rating,
	    	        		review_content: review_content
	    	        	},
	    	        	url: "RegistReview",
	    				type: "GET",
	    				success: function(data) {
	    					console.log("리뷰 등록 성공!");
	    				},
	    				error: function(request,status,error) {
	    					alert("code:"+request.status+"\n"
	    							+"message:"+request.responseText+"\n"
	    							+"error:"+error);
	    	 				console.log("리뷰 등록 실패!");
	    				}
	    	        });
	    	        
	    	        // 실제 전송 로직은 여기에 추가
	    	        /*모달창 내 제출 버튼 클릭 시 모달창 닫음*/
						$(".modalOpen").hide();
					});
				
				
				
			});
            
            
    
    		
    	    /*모달창 내 닫기 버튼 클릭 시 모달창 닫음*/
			$("#btnReviewClose").click(function(e) {
				console.log("모달 닫기 버튼 클릭됨!");
				e.preventDefault();
				$(".modalOpen").hide();
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
                    <a href="SaleHistory?member_id=${param.member_id}">판매내역</a>
                    <a href="PurchaseHistory?member_id=${param.member_id}" class="selected">구매내역</a>
<%--                      <a href="PurchaseStoreHistory?member_id=${param.member_id}">스토어 구매내역</a> --%>
                    <a href="Wishlist?member_id=${param.member_id}">찜한상품</a>
                </c:when>
                <c:otherwise>
                    <!-- member_id 파라미터가 없을 때 -->
                    <a href="SaleHistory">판매내역</a>
                    <a href="PurchaseHistory" class="selected">구매내역</a>
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
                    <img src="${pageContext.request.contextPath}/resources/images/${member.member_profile}">               	
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
                <li><a href="BuyerReview?member_id=${param.member_id}">작성한 리뷰</a></li>
            </ul>


			<div class="modalOpen">
				<div id="reviewModal">
					<form action="RegistReview">
						거래 리뷰
						<hr>
						별점과 리뷰를 남겨주세요!
						<b>dd${product.pd_idx}</b>
						<input type="hidden" id="pd_idx" value="${product.pd_idx}">
						<div class="starRev">
						  <!-- 편의 상 가장 첫번째의 별은 기본으로 class="on"이 되게 설정해주었습니다. -->
						  <span class="starR on">⭐</span>
						  <span class="starR">⭐</span>
						  <span class="starR">⭐</span>
						  <span class="starR">⭐</span>
						  <span class="starR">⭐</span>
						</div>
						<input type="text" id="content" placeholder="내용을 입력해주세요">
						<div class="modalBtn">
							<button type="button" id="btnReviewSub">전송</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" id="btnReviewClose">닫기</button>
						</div>
					</form>
				</div>
			</div>






            <div class="content">
                <c:if test="${not empty buyList}">
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
                            <c:forEach var="product" items="${buyList}">
<%--                                 <c:if test="${product.pd_status == '결제완료' ||  --%>
<%--                                              product.pd_status == '거래취소 요청' ||  --%>
<%--                                              product.pd_status == '거래취소 확정' ||  --%>
<%--                                              product.pd_status == '거래확정'}"> --%>
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
<%--                                         <td>${product.pd_content}</td> --%>
                                        <td>${product.pd_price}</td>
                                        <td data-date="${product.pd_first_date}"></td>
                                        <td>
                                            <div class="status-buttons">
                                                <c:choose>
                                                    <c:when test="${product.trade_status == 1}">
                                                        예약중
                                                    </c:when>
                                                    <c:when test="${product.trade_status == 2}">
                                                        결제완료
                                                        <button class="status-button cancel-request" data-id="${product.pd_idx}">거래취소요청</button>
                                                        <button class="status-button confirm-request" data-id="${product.pd_idx}">거래확정</button>
                                                    </c:when>
                                                    <c:when test="${product.trade_status == 3}">
                                                        거래완료
                                                        <button class="status-button review-request" data-id="${product.pd_idx}">리뷰쓰기</button>
                                                    </c:when>
                                                    <c:when test="${product.trade_status == 4}">
                                                        거래취소대기
                                                    </c:when>
                                                    <c:when test="${product.trade_status == 5}">
                                                        거래취소승인
                                                    </c:when>
                                                    <c:when test="${product.trade_status == 6}">
                                                        리뷰완료
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
<%--                                 </c:if> --%>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty buyList}">
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
 