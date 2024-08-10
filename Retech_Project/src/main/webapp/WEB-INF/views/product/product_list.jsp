<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retech 메인페이지</title>
<link
	href="${pageContext.request.contextPath}/resources/css/default.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<article id="mainArticle">
		<div class="container">
			<div class="category">
				<!-- 카테고리 기본선택 전체 -->
				<nav id="categoryNav">
					<span class="select">전체</span><br>
					<br>
					<c:forEach var="category" items="${categorylist }">
						<span> ${category.category_name } </span>
					</c:forEach>
				</nav>
				<!--  상품갯수, 정렬 -->
				<div class="listInfo">

					<span class="listInfoCount">상품 <span id="listCount"></span>개
					</span>

					<button class="listInfoBtn">
						최신순
						<!-- <i class="material-icons">swap_vert</i> -->
					</button>
					<%-- 정렬 방법(기본 : 보이지 않음, 클릭 : style 지우기) --%>
					<ul class="listSort" style="display: none;">
						<%-- style="display: none;" --%>
						<li id="list1">최신순 <!-- 								<i class="material-icons">check</i> -->
						</li>
						<li id="list3">인기순</li>
					</ul>
				</div>
			</div>
			<hr>
			<!-- 상품개수표시 -->
			<div class="Secondhandcount">
				전체 상품 개수 <b style="color: gray;">${listCount }</b> 개
			</div>

			<!-- 목록표시 영역 -->
			<div class="row" align="left">
				<div class="productListArea">
					<c:forEach var="secondhand" items="${secondhandList }">

						<div class="col-lg-3 col-mid-4">
							<div class="card border-0">

								<!-- 썸네일이미지 -->
								<div class="photoDiv">
									<a
										href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
										<%--<img src="${image1 }" class="card-img-top" > --%> <%-- <img src="<spring:url value='${secondhand.secondhand_image1}'/>" class="card-img-top"/> --%>
										<img
										src="${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1}"
										class="card-img-top"> <%-- <img src="<%= request.getContextPath()%> + ${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1} "/> --%>
										<%-- <img src="http://localhost:8089/zero/${secondhand.secondhand_image1}" class="card-img-top" > --%>
									</a>

									<!-- 찜하기 버튼 -->
									<span class="likebtn"
										data-secondhand-idx="${secondhand.secondhand_idx}"> <a
										href="#" style="align: right;"> <img
											src="${pageContext.request.contextPath }/resources/img/heartIcon.png"
											width="30px" height="30px">
									</a>
									</span>

									<!-- 거래상태 버튼 -->
									<span class="dealStatus"><button class="btn btn-dark">${secondhand.secondhand_deal_status}</button></span>
								</div>



								<div class="card-body">
									<!-- 카테고리 가져오기 -->
									<%-- <input type="hidden" id="seoncdhand_idx" value="${secondhand.secondhand_idx}"> --%>
									<div class="category" style="font-size: 0.8rem;">
										${secondhand.category_name }</div>

									<div class="card-title"
										style="white-space: nowrap; overflow: hidden; text-overflow: elipsis;">
										<!-- 제목 링크 -->
										<a
											href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
											${secondhand.secondhand_subject} </a>

									</div>
									<p>
										<fmt:formatNumber pattern="#,###"
											value="${secondhand.secondhand_price }" />
										원
									</p>

									<p>${secondhand.secondhand_first_date }</p>
								</div>
								<!-- cardbody끝 -->
							</div>
							<!-- card끝 -->

						</div>
					</c:forEach>
				</div>
				<%--productListArea 끝 --%>
			</div>
			<%--row끝 --%>
		</div>
		<%--container 끝 --%>
	</article>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>