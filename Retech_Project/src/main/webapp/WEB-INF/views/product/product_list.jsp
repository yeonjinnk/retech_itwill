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
<style>
/* General Reset for Better Consistency Across Browsers */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: Arial, sans-serif;
  background-color: #f4f4f4;
  color: #333;
  line-height: 1.6;
  padding-top: 70px; /* Adjust for fixed header */
}

/* Main Article Styling */
#mainArticle {
  margin-top: 20px;
  padding: 20px;
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* General Link Styling */
a {
  color: #333;
  text-decoration: none;
  transition: color 0.3s ease;
}

a:hover {
  color: #007bff;
}

/* Category and Filter Section Styling */
#category {
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 15px;
}

.pro_info {
  font-weight: bold;
  margin-right: 10px;
}

.input-tag {
  width: 30%;
  height: 35px;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 5px;
  background-color: #f9f9f9;
}

/* Product List Information and Sorting */
.listInfo {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 10px;
  background-color: #f9f9f9;
  border-radius: 4px;
}

.listInfoCount {
  font-size: 1.1rem;
  color: #555;
}

.listInfoBtn {
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 8px 15px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.listInfoBtn:hover {
  background-color: #0056b3;
}

.listSort {
  display: none;
  list-style: none;
  padding: 10px;
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
  position: absolute;
  top: 100%;
  right: 0;
  z-index: 1000;
}

.listSort li {
  padding: 5px 10px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.listSort li:hover {
  background-color: #f0f0f0;
}

/* Product List Styling */
.productListArea {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: flex-start;
}

.productListArea .col-lg-3 {
  width: 23%;
  background-color: #ffffff;
  border: 1px solid #ddd;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.productListArea .col-lg-3:hover {
  transform: translateY(-5px);
}

/* Product Card Styling */
.card-img-top {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.photoDiv {
  position: relative;
}

/* Like Button Styling */
.likebtn {
  font-size: 1.0rem;
  position: absolute;
  top: 10px;
  left: 10px;
  background-color: rgba(255, 255, 255, 0.7);
  padding: 5px;
  border-radius: 50%;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.likebtn:hover {
  background-color: rgba(255, 255, 255, 1);
}

/* Product Status Button Styling */
.pd_status {
  position: absolute;
  bottom: 10px;
  right: 10px;
}

.btn.btn-dark {
  font-size: 0.8rem;
  padding: 5px 10px;
  background-color: #555;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: default;
}

/* Product Details Styling */
.card-body {
  padding: 15px;
  text-align: center;
}

.category {
  font-size: 0.9rem;
  color: #888;
  margin-bottom: 8px;
}

.card-title {
  font-size: 1.1rem;
  font-weight: bold;
  margin-bottom: 5px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.card-title a {
  color: #333;
  transition: color 0.3s ease;
}

.card-title a:hover {
  color: #007bff;
}

.card-body p {
  font-size: 1rem;
  color: #555;
  margin: 5px 0;
}

/* Footer Styling */
footer {
  margin-top: 30px;
  padding: 20px;
  background-color: #f4f4f4;
  text-align: center;
  font-size: 0.9rem;
  color: #888;
}

/* Responsive Adjustments */
@media (max-width: 1200px) {
  .productListArea .col-lg-3 {
    width: 30%;
  }
}

@media (max-width: 992px) {
  .productListArea .col-lg-3 {
    width: 45%;
  }
}

@media (max-width: 768px) {
  .productListArea .col-lg-3 {
    width: 100%;
  }
}
</style>

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
</header>
<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1로 설정) --%>
<c:set var="pageNum" value="1" />
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }"></c:set>
</c:if>
	<article id="mainArticle">
		<div class="container">
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
			<!-- 상품갯수, 정렬 -->
			<div class="listInfo">
			
				<span class="listInfoCount">상품 <span id="listCount"></span>개</span>
				
				<button class="listInfoBtn">
						최신순 
				</button>
					<%-- 정렬 방법(기본 : 보이지 않음, 클릭 : style 지우기) --%>
					<ul class="listSort" style="display: none;"> <%-- style="display: none;" --%>
						<li id="list1">최신순 
						</li>
						<li id="list2">가격순 </li>
						<li id="list3">인기순 </li>
					</ul>
			</div>
			
			
			<!-- 목록표시 영역 -->
			<div class="row" align="left">
				<div class="productListArea">
					<c:forEach var="product" items="${productList}">
						<div class="col-lg-3 col-mid-4">
							<!-- 썸네일 이미지 -->
							<div class="photoDiv">
								<a href="product_detail?pd_idx=${product.pd_idx }&member_id=${product.member_id}">
									<img src="${pageContext.request.contextPath }/resources/upload/${product.pd_image1}" class="card-img-top">
								</a>
							<!-- 찜하기 버튼 -->
								<span class="likebtn" data-product-idx="${product.pd_idx }">
									<a href="#" style="align:right;">
										<!-- 찜하기 버튼 이미지 찾아서 삽입 -->
									</a>
								</span>
								<!-- 거래상태 버튼 -->
								<span class="pd_status">
									<button class="btn btn-dark">${product.pd_status}</button>
								</span>
							</div>
							<div class="card-body">
								<!-- 카테고리 가져오기 -->
								<div class="category" style="font-size:0.8rem;">
									${product.pd_category }
								</div>
								<!-- 제목 링크 -->
								<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
									<a href="product_detail?pd_idx=${product.pd_idx}&member_id=${product.member_id}">
										${product.pd_subject}
									</a>
								</div>
								<p><fmt:formatNumber pattern="#,###" value="${product.pd_price }"/>원</p>
										
								<p>${product.pd_first_date }</p>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>			
		</div><%-- id container 부분 끝 --%>
	</article>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>