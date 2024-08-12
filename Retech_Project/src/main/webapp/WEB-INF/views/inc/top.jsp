<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 탑 최상단 영역 -->
<div class="header_top">
	<div class="top_inner">
		<ul class="top_area">
			<li class="top_list">
				<a href="#" class="top_link" id="top_link1">테크페이</a>
			</li>
			<li class="top_list">
				<a href="#" class="top_link">채팅하기</a>
			</li>
			<li class="top_list">
				<a href="#" class="top_link">판매하기</a>
			</li>
			<li class="top_list">
				<a href="MemberLogin" class="login">로그인</a>
			</li>
			<c:if test="${sessionScope.sIsAdmin eq 1}">
			| <a href="AdminHome">관리자페이지</a>
			</c:if>
		</ul>
	</div>
</div>

<!-- 탑 로고 및 메뉴,], 검색어 영역 -->
<div class="header_main">
	<div class="main_inner">
		<div class="logo">
			<a href="#" class="logo"><img src="${pageContext.request.servletContext.contextPath}/resources/images/logo.png" height="70" width="140"></a>
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
								<li><a href="#">받침대</a></li>
								<li><a href="#">파우치</a></li>
							</ul>
					</li>
					<li class="menu_list">
						<a href="Cs" class="menu_link">고객센터</a>
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

