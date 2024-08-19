<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 반응형웹페이지를 위한 설정 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript">
//이미지 추가 버튼 스크립트
	let preview_array = {false, false, false, false, false};
	//이미지 등록 시 미리보기 추가 작업
	function img_preview() {
		for (var i = 0; i < preview_array.length; i++) {
			//i가 0일 때
			if(i == 0){
				//0번 사진 비어있는 경우
				if(preview_array[0] == false){
					//섬네일 사진
					//0번 사진 인풋태그 호출
					send_0();
					return;
				}
				//1번 사진 비어있는 경우
				if(preview_array[1] == false){
					//섬네일 사진
					//1번 사진 인풋태그 호출
					send_1();
					return;
				}
				//2번 사진 비어있는 경우
				if(preview_array[2] == false){
					//섬네일 사진
					//2번 사진 인풋태그 호출
					send_2();
					return;
				}
				//3번 사진 비어있는 경우
				if(preview_array[3] == false){
					//섬네일 사진
					//3번 사진 인풋태그 호출
					send_3();
					return;
				}
				//4번 사진 비어있는 경우
				if(preview_array[4] == false){
					//섬네일 사진
					//4번 사진 인풋태그 호출
					send_4();
					return;
				}
			}
		}
		alert("더 이상 사진을 등록할 수 없습니다!")
		return;
		
	}//프리뷰 파트 끝
//----------------------------------------------------------------------------------------------------------------------
// 이미지 갯수 표현 함수
	function img_num() {
		let img_number = 0;
		for (var i = 0; i < preview_array.length; i++) {
			if(preview_array[i] == true){
				img_number++;
			}
		}
		//이미지 갯수 표시
		$("#img_number").html('(' + img_number + '/4)')
	}
//----------------------------------------------------------------------------------------------------------------------

	function send_0() {
		$("#sumimage").click();		
	}
	$(function() {
		$("#sumimage").on('change',function(){
			if($("#sumimage")[0].files[0] == undefined){
				return;
			}
			imgcheck0(this);
		})
	});

	
//이미지 미리보기 --------------------------------------------------------------------------------------------------------

	function imgcheck0(input) {
		//이미지 확장자 파일체크
		let file_kind = input.value.lastIndexOf('.');
		let file_name = input.value.substring(file_kind+1,input.length);
		let file_type = file_name.toLowerCase();
		
		let check_array = new Array( 'jpg','png','jpeg' );
		
		$('#sumimage').val();
		
		if(check_array.indexOf(file_type)==-1){
			
			// 사용자에게 알려주고 
			alert('이미지 파일만 선택할 수 있습니다.');
			// 실제 업로드 되는 input태그 vlaue값 지우기 
			$('#sumimage').val('');
			
			return;
		
		} 	
		
		 if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
		        $('#imgup_sum').attr('src', e.target.result);
		        
		        $("#img_preview0").css("display","inline-block");
				$("#imgup_sum").show();
		        $("#del_sum").show();
		       
				preview_array[0] = true;
				
				/* 이미지넘버 변경 */
				img_num();
	        }
	        reader.readAsDataURL(input.files[0]);
		  }
	}
	
	//1번 사진 
	
	function send_1() {
		$("#imageFile1").click();
	}
	$(function() {
		$("#imageFile1").on('change', function() {
			//파일 선택을 취소하였을 때
			if($("#imageFile1")[0].files[0] == undefined){
				return;
			}
			imgcheck1(this);
		})
	});
	
	
		
		
		
		
		
		
	

</script>

<style>
body {
    font-family: 'Gowun Dodum', sans-serif;
    margin: 0;
    padding: 0;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

#root {
    flex: 1;
    width: 100%;
}

#insert_box {
    width: 1020px;
    margin: auto;
    padding-top: 160px;
    min-height: 1000px;
    text-align: center;
}

/* 나머지 스타일 생략 */

/* footer 스타일 */
footer {
    width: 100%;
    background-color: #f8f9fa;
    text-align: center;
    padding: 10px 0;
    border-top: 1px solid #e9ecef;
    margin-top: auto; /* 페이지 콘텐츠 끝에 위치 */
}
</style>


<title>Retech 메인페이지</title>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>	
	</header>
	<!-- 이미지 파일 업로드용 폼 -->
	<form enctype="multipart/form-data" id="imgform" method="post">
		<input type="file" id="sumimage"   style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile1" style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile2" style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile3" style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile4" style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile5" style="display: none;" accept=".jpg, .jpeg, .png">
	</form>
	
	<div id = "root">
	  <input type="hidden" id="member_id">
	
	  <div id="insert_box">
			<span id="title">상품등록</span>
	
			<table style="margin-top: 30px;">
				<!-- 기본정보 -->
				<tr>
					<td colspan="2" align="left"><span class="pro_info">기본정보</span>
						&nbsp;&nbsp;&nbsp; <span style="font-size: 14px; color: red">*필수항목</span></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<!-- 상품이미지 -->
				<tr>
					<td class="td1" align="left" ><span
						class="pro_info">상품이미지</span> 
						<span class="pro_info" id="img_number">(0/3)</span>
						<span style="color: red">*</span>
						<input type="image" id="imgup" onclick="img_preview();"
								src="${ pageContext.request.contextPath }/resources/img/image_upload.png" width="150px" height="150px">
					</td>
					<td class="td2" align="left">
					
						<!-- 이미지 등록 영역 -->
						<div id="img_zone">
							<div id="img_preview0" >
								<input type="image" id="imgup_sum" onclick="send_0();"
									src="" width="150px" height="150px">
								<span id="sum_style" >대표 이미지</span>
								<!-- 삭제버튼 -->
								<span id="del_sum" class="chk_style"  onclick="del_sum();">x</span>
							</div>
							
								
							<div id="img_preview1" >
								<input type="image" id="imgup_1" onclick="send_1();"
									src="" width="150px" height="150px">
								<!-- 삭제버튼 -->
								<span id="del_img1" class="chk_style" onclick="del_img1();">x</span>
							</div>
							
							<div id="img_preview2">
								<input type="image" id="imgup_2" onclick="send_2();"
									src="" width="150px" height="150px">
								<span id="del_img2" class="chk_style" onclick="del_img2();">x</span>
							</div>
	
						</div>
						<div id="img_intro">
								
								* <b>대표 이미지</b>는 반드시 <font color="red"><b>등록</b></font>해야 합니다.<br>
								- 이미지를 <b>클릭할</b> 경우 이미지를 <b>수정</b>하실 수 있습니다.<br>
								- 이미지 등록은 좌측 <b>이미지 등록</b>을 눌러 등록할 수 있습니다.<br>
								- 이미지 확장자는 <b>.jpg, .jpeg, .png</b> 만 등록 가능합니다.
						</div>
	
					</td>
				</tr><!-- 이미지영역끝 -->
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<!-- 제목  -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span
						class="pro_info">제목<span style="color: red">*</span></span></td>
					<td class="td2" align="left">
						<div style="display: inline-block; min-width: 70px; ">
							<span class="pro_info" id="name_length">0/40</span>
						</div>
						<input maxlength="40"
						oninput="numberMaxLength(this);" type="text" id="p_name"
						name="p_name" class="input-tag" placeholder="제목을 입력하세요.">
					</td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<!-- 카테고리 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;">
						<span class="pro_info">카테고리<span style="color: red">*</span></span>
					</td>
					<td class="td2" align="left">
						<select class="input-tag" id="c_idx" name="c_idx" style="width: 30%; height: 35px;">
								<option value="0">카테고리 선택</option>
								<c:forEach var="category" items="${categorylist }">
									<option value="${category.category_idx }"> ${category.category_name }</option>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<!-- 결제방법 -->
				<tr>	
					<td class="td1" align="left" style="vertical-align: top;"><span
						class="pro_info">가격<span style="color: red">*</span></span></td>
					<td class="td2" align="left"><input type="text" id="p_price" maxlength="11"
						name="p_price" class="input-tag" placeholder="가격"
						oninput="numberMaxLength(this);" style="width: 30%;"> &nbsp; <span class="pro_info">원</span>
						<br>
						<span class="pro_info" id="price_under"></span>
					</td>
				</tr>
	
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				<!-- 상품설명 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span
						class="pro_info">상품설명<span style="color: red">*</span></span></td>
					<td align="left">
					
						<br>
						<div>
						<textarea class="input-tag"
							id="p_exp" name="p_exp" maxlength="1000"
							oninput="numberMaxLength(this);"
							placeholder="구입연도, 브랜드, 사용감, 하자유무 등 필요한 정보를 넣어주세요. &#13;&#10;구매자의 문의를 좀더 줄일 수 있습니다."></textarea>
						</div>
						<div align="right"><span style="font-size: 18px;"id="exp_length">0/1000</span></div>
					</td>
				</tr>
	
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				<!-- 등록 취소버튼 -->
				<tr>
					<td colspan="2">
						<input class="btn btn-success" type="button" value="등록하기" onclick="proInfoSend();"> 
						<input class="btn btn" type="button" value="취소하기" onclick="procancel()"></td>
				</tr>
			</table>
	
		</div>
	  </div>
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>	
	</footer>
</body>
</html>