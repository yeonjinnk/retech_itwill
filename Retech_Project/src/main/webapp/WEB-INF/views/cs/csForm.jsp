<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의양식</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {
 	font-family: Arial, sans-serif;
 	margin-top: 200px;
 	
}

table {
	width: 60%;
	border-collapse: collapse;
}

#tr_top {
	background: gray;
	text-align: center;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: left;
}

input[type="text"] {
	width: 100%;
	padding: 8px;
	box-sizing: border-box;
}

textarea {
	resize: none;
	width: 100%;
}

.btn {
	text-align: center;
	padding-top: 10px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<div align="center">
		<h2>1:1문의</h2>
		<form action="CsRegistPro" method="post" enctype="multipart/form-data">
			<table border="1">
			<tr>
				<th width="100px">문의유형</th> 
				<td width="600px">
					<input type="radio" name="cs_category" value="문의">문의
					<input type="radio" name="cs_category" value="건의">건의
					<input type="radio" name="cs_category" value="칭찬">칭찬
					<input type="radio" name="cs_category" value="신고">신고
					<input type="radio" name="cs_category" value="기타">기타
				</td>
			</tr>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="cs_subject">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td >
						<textarea rows="5" cols="40" name="cs_content"></textarea>
					</td>
				</tr>
				<tr>
					<td class="write_td_left"><label for="cs_file">파일첨부</label></td>
					<td class="write_td_right">
						<%-- 파일 첨부 형식은 input 태그의 type="file" 속성 활용 --%>
						<%-- 주의! 파일 업로드를 위해 form 태그 속성에 enctype 속성 필수!  --%>
						<%-- 1) 한번에 하나의 파일(단일 파일) 선택 가능하게 할 경우 --%>
						<input type="file" name="file1">
						<input type="file" name="file2">
						<hr>
						<%-- 2) 한번에 복수개의 파일(다중 파일) 선택 가능하게 할 경우 --%>
						<%--    태그 속성으로 multiple 속성 추가 --%>
						<input type="file" name="file" multiple=>					
					</td>
				</tr>
			</table>
			<input type="hidden" name="cs_member_id" value="${cs_member_id}">
			<div>			
				<td colspan="2" align="center" class="btn">
					<input type="submit" value="등록">
					<input type="reset" value="초기화">
					<input type="button" value="취소">
				</td>				
			</div>
		</form>   	
	</div>
</body>
</html>