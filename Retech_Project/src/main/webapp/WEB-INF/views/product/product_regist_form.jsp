<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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