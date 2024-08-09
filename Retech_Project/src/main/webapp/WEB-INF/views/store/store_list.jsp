<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/defaul.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

 	$.ajax({
 		url: "StoreProductList",
 		data : {
 			pageNum: pageNum,
 			keyword: keyword,
			
 		},
 		dataType: 'json',
 		success: function(data) {
			
 			for(let i = 0; i < productList.length; i++) {
				
 			}
 		}
 	});
</script>


</head>
<body>
	<div clss="store_product">
		 
	
	
	</div>
</body>
</html>