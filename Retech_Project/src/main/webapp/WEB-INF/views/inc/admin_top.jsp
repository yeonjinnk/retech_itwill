<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	function confirmLogout() {
		let isLogout = confirm("로그아웃 하시겠습니까?");
		// isLogout 변수값이 true 일 경우 로그아웃 작업을 수행할
		// "MemberLogout" 서블릿 요청
		if (isLogout) {
			location.href = "MemberLogout";
		}
	}
</script>
<!-- 탑 최상단 영역 -->
<div class="header_top">
	<div class="top_inner">
		<div class="top_left_blank">
		</div>
		<div class="top_menu">
			<nav class="top_menu_container">
				<ul class="top_area">
					<li class="top_list">
						<a href="TechPayMain" class="top_link" id="top_link1">테크페이</a>
					</li>
					<li class="top_list">
						<a href="#" class="top_link">채팅하기</a>
					</li>
					<li class="top_list">
						<a href="ProductRegistForm" class="top_link">판매하기</a>
					</li>
						<c:choose>
							<c:when test="${empty sessionScope.sId}"> <%-- 로그인 상태가 아닐 경우 --%>
								<li class="top_list">
								 	<a href="MemberLogin" class="login top_link">로그인</a>
								</li>
							</c:when>
							<c:otherwise> <%-- 로그인 상태일 경우 --%>
								<li class="top_list">
									<a href="SaleHistory" class="top_link">${sessionScope.sName}님</a>
								</li>
								<li class="top_list">
									<a href="javascript:confirmLogout()" class="top_link">로그아웃</a>
								</li>
								
								<!-- 관리자 계정일 경우 관리자 페이지 링크 표시 -->
								<c:if test="${sessionScope.sIsAdmin eq 'Y'}">
									<li class="top_list">
										<a href="AdminHome" class="top_link">관리자페이지</a>
									</li>
								</c:if>
							</c:otherwise>
						</c:choose>
				</ul>
			</nav>
		</div>
	</div>
</div>
<!-- 탑 로고 및 메뉴,], 검색어 영역 -->
<div class="header_main">
	<div class="main_inner">
		<div class="logo">
			<a href="./" class="logo"><img src="${pageContext.request.servletContext.contextPath}/resources/images/logo.png" height="70" width="140"></a>
		</div>
		<div class="main_menu">
			<nav class="menu_container">
				<ul class="menu_area">
					<li class="menu_list">
						<a href="ProductList" class="menu_link" id="menu_link1">상품</a>
					</li>
					<li class="menu_list">
						<a href="Store" class="menu_link">스토어</a>
							<ul class="sub_menu">
								<li><a href="#">키스킨</a></li>
								<li><a href="#">마우스패드</a></li>
								<li><a href="StoreDetail">받침대</a></li>
								<li><a href="#">파우치</a></li>
							</ul>
					</li>
					<li class="menu_list">
						<a href="Notice" class="menu_link">고객센터</a>
					</li>
					
				</ul>
				<ul class="main_search">
					<li>
						<input type="text" placeholder="검색어를 입력하세요" width="120">
					</li>
				</ul>
			</nav>
		</div>
	</div>
</div>

