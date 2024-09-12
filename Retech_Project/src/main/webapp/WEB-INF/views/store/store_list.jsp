<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/store/store_list.css" rel="stylesheet">
<style type="text/css">
	 .store_product {
        width: 900px;
        margin: 0 auto; /* 가운데 정렬 */
    }

</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">

	//스토어 목록 가져오기
		$.ajax({
		    url: "StoreProductList",
		    data: {
		        store_category: "받침대"
		    },
		    dataType: 'json',
		    success: function(data) {
		    	// 숫자에 3자리마다 콤마를 추가하는 함수
		        function formatNumber(number) {
		            // 숫자를 문자열로 변환하고 정수 부분과 소수 부분을 분리
		            let [integerPart, decimalPart] = number.toString().split('.');
		            
		            // 정수 부분에 3자리마다 콤마를 추가
		            integerPart = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		            
		            // 소수 부분이 있으면 다시 합쳐서 반환
		            return decimalPart ? integerPart + '.' + decimalPart : integerPart;
		        }
		    	
		    	
		        for(let i = 0; i < data.length; i++) {
		            let store = data[i];
		            let divStore = "<div class='store_list'>"
		                + "<div class='store_img'>"
		                + "<a href='StoreDetail?store_idx=" + store.store_idx + "'>"
		                + "<img src='" + store.store_img1 + "' alt='Store Image'/>"
	               		+ "</a>"
		                + "</div>"
		                + "<div class='store_preview'>"
		                + "<div class='store_id'>" + store.store_id + "</div>"
// 		                + "<div class='tags'><div class='tag display_tag_item' style='background-color: rgb(244, 244, 244); color: rgb(130, 139, 157);'>"
// 		                + "<span class='tag_text'> 쿠폰 </span></div><div class='tag display_tag_item' style='background-color: rgb(244, 244, 244); color: rgb(130, 139, 157);'>"
// 		                + "<span class='tag_text'> 적립 </span></div><div class='tag display_tag_item' style='background-color: rgb(244, 244, 244); color: rgb(130, 139, 157);'>"
// 		                + "<span class='tag_text'> 무료배송 </span></div></div>"
		                + "<div class='store_content'>" + formatNumber(store.store_price) + "</div>"
		                + "<div class='store_content'>" + store.store_content + "</div>"
		                + "</div>"
		                + "</div>";
		            $(".store_product").prepend(divStore);
		          //이미지 또는 상품명 클릭 시, 상세페이지로 이동
//		     	   // 클릭된 요소의 상위 store_list 요소에서 store_idx 값 추출
//            			let store_idx = $(this).closest(".store_list").data("store-idx");
// 		          	console.log("store_idx : " + store_idx);
// 		    		$(".store_img").click(function() {
// 		    			location.href="StoreDetail?store_idx="+store_idx;
// 		    		});
// 		    		$(".store_id").click(function() {
// 		    			location.href="StoreDetail?store_idx="+store_idx;
// 		    		});
		        }
		    },
		    error: function(request, status, error) {
		        alert("code:" + request.status + "\n"

		            + "message:" + request.responseText + "\n"
		            + "error:" + error);
		        console.log("DB 가져오기 실패");
		    }
		});
	
	    
</script>


</head>
<body>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
		
			        
		
	<div class="store_product">
		 
	
	
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>