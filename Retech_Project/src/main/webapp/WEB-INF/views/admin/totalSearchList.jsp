<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>Retech 관리자페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin_default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<meta content="" name="description">
<meta content="" name="keywords">
<style type="text/css">
</style>
<script type="text/javascript">
function delKeyword(element) {
	var content = $(element).data("content");
	$.ajax({
		type:"GET",
		url:"deleteKeyword",
		data: {content : content},
		success:function(res){
			location.reload();
		}
	});
}

</script>

</head>
<body>
  <header>
    <jsp:include page="/WEB-INF/views/inc/admin_top.jsp"></jsp:include>  
  </header>
  <div class="inner">
    <section class="wrapper">
      <jsp:include page="/WEB-INF/views/inc/admin_side_nav.jsp"></jsp:include>
      <article>
      	   <div class="main-content">
        <main id="main" class="main">

	 	<div id="date"></div>
		<div class="pagetitle">
			<h1>인기 검색어 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="AdminChart">Home</a></li>
					<li class="breadcrumb-item active">인기 검색어 관리</li>
				</ol>
			</nav>
		</div><!-- End Page Title -->
	
		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr>
										<th>검색어 순위</th>
										<th>검색어 내용</th>
										<th>검색어 조회수</th>
										<th>비고</th>
								</thead>
								<tbody>
									<c:forEach var="data" items="${searchList}" varStatus="loop">
										<tr>
											<td>${loop.index + 1}</td>
											<td>${data.search_content}</td>
											<td>${data.search_count}</td>
											
											<td>
											<button type="button" class="btn btn-primary"  data-content="${data.search_content}" onclick="delKeyword(this)">
												검색어 삭제
											</button>
												
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- End Table with stripped rows -->
						</div>
	 				</div>
				</div>
			</div>
		</section>
	</main><!-- End #main -->

        <!-- End #main -->
    </div>
      	
      
      
      
      </article>
    </section>
  </div>
    
    

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><span>&#x2191;</span></a>
</body>
</html>

