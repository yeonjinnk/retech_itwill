<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/mypage/review_popup.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		//별점 클릭 이벤트 처리
		$('.starRev span').click(function(){
			//모든 별에서 'on' 클래스를 제거
			  $(this).parent().children('span').removeClass('on');
			
			//클릭된 별 및 이전 별들에 'on' 클래스 추가
			  $(this).addClass('on').prevAll('span').addClass('on');
			  return false;
			});
		
		// 버튼 클릭 시 별점 및 리뷰 내용을 콘솔에 출력
	    $('button').click(function(){
	    	//별점 = 'on' 클래스 총 길이
	        let starCount = $('.starRev .starR.on').length; // 별점 개수
	        let reviewContent = $('input[type="text"]').val(); // 리뷰 내용

	        console.log('별점: ' + starCount);
	        console.log('리뷰 내용: ' + reviewContent);
	        
	        // 실제 전송 로직은 여기에 추가
	    });
		
	});


</script>

</head>
<body>
거래 리뷰
<hr>
별점과 리뷰를 남겨주세요!

<div class="starRev">
  <!-- 편의 상 가장 첫번째의 별은 기본으로 class="on"이 되게 설정해주었습니다. -->
  <span class="starR on">⭐</span>
  <span class="starR">⭐</span>
  <span class="starR">⭐</span>
  <span class="starR">⭐</span>
  <span class="starR">⭐</span>
</div>
<input type="text" placeholder="내용을 입력해주세요">
<button type="button">전송</button>
</body>
</html>

