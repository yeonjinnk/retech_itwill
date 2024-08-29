<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/defualt.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<%-- 반응형웹페이지 위한 설정  --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Retech 상품목록</title>

<script type="text/javascript">
let pd_category;
let pd_status;
$(function () {
    $("select").eq(2).on("change", function() {
       let product = "PRODUCT";
       let product1 = $("#c_id").val(); //PC, NB
       let product2 = $("#c_id2").val(); //삼성, 애플, LG, 기타
       pd_status = $("#c_id3").val(); //판매중, 거래중, 판매완료
//          $("#pd_category_hidden").hidden = pd_category;
			pd_category = product +  product1 + product2;
//        $("#pd_category_hidden").val(pd_category);
//          $("#text").html("pd_category");
       console.log("pd_category : " + pd_category);
//        console.log("pd_category_hidden : " +  $("#pd_category_hidden").val());
       console.log("pd_status : " + pd_status);
       loadList(pd_category, pd_status);
    });
    
    
      
 });
 
 function loadList(selectedCategory, selectedStatus) {
	$.ajax({
		type: "GET",
		url: "productListJson?pd_category=" + selectedCategory + "&pd_status=" + selectedStatus,
		dataType: "JSON",
		success: function(data) {
			console.log("성공!");
			console.log("data : " + data);
// 			$(".productListArea").append(
					
// 			)
			
		}
	});	// ajax 끝
 }


</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<article>
	<!-- 카테고리 선택 영역 -->
		<div id="category">
			<!-- 카테고리 및 거래상태 필터링-->
					<span class="pro_info">카테고리<span style="color: red">*</span></span>
					<select class="input-tag" id="c_id" name="c_id" style="width: 30%; height: 35px;">
						<option value="">카테고리 선택</option>
						<option value="PC">PC</option>
						<option value="NB">노트북</option>
					</select>
					<select class="input-tag" id="c_id2" name="c_id2" style="width: 30%; height: 35px;">
						<option value="">제조사 선택</option>
						<option value="SA">삼성</option>
						<option value="AP">애플</option>
						<option value="LG">LG</option>
						<option value="ET">기타</option>
					</select> 
					<select class="input-tag" id="c_id3" name="c_id3" style="width: 30%; height: 35px;">
						<option value="">거래상태 선택</option>
						<option value="판매중">판매중</option>
						<option value="거래중">거래중</option>
						<option value="거래중">판매완료</option>
					</select> 
					
					<input type="hidden" name="pd_category" id="pd_category_hidden">
		</div><!-- 카테고리 끝 -->
		<div class="productListArea">
		
		</div>
	
	
	</article>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>