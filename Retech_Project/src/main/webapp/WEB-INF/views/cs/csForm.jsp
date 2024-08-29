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
    textarea{
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
		<form action="CsRegistPro" method="post">
			<table border="1">
			<tr>
				<th width="100px">문의유형</th> 
				<td width="600px">
					<input type="radio" name="cs_category" value="문의">문의
					<input type="radio" name="cs_category" value="건의">건의
					<input type="radio" name="cs_category" value="칭찬">칭찬
					<input type="radio" name="cs_category" value="불만">불만
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
	<footer>		
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>