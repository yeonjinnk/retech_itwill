<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
/* 게시판 스타일 */
#listForm table {
    width: 80%; /* 테이블 크기를 조정하여 너무 크지 않게 */
    margin: auto;
    border-collapse: collapse;
    background-color: #f0f4f8; /* 배경색을 살짝 밝은 회색으로 */
}


/* 각 열의 헤더 색상 */
#listForm table th {
    padding: 15px;
    text-align: center;
    border: 1px solid #ccc;
    font-size: 1rem;
}

/* 색상 지정 */
#listForm table th.column {
    background-color: #3498db; /* 글번호 색상 */
    color: white;
}

#listForm table td {
    padding: 15px; /* 여백 추가로 가독성 향상 */
    text-align: center;
    border: 1px solid #ccc; /* 얇은 테두리 추가 */
    font-size: 1rem; /* 글씨 크기 조정 */
}

/* 제목 링크 색상 */
#listForm table td a {
    color: #2c3e50; /* 제목 링크도 네이비 */
    text-decoration: none;
    font-weight: bold;
}

/* 페이지네이션 버튼 스타일 */
#pageList {
    text-align: center;
    margin: 20px 0;
}

#pageList input, #pageList a {
    padding: 10px 15px;
    margin: 0 5px;
    background-color: #2c3e50;
    color: white;
    border: none;
    cursor: pointer;
    text-decoration: none;
}

#pageList b {
    padding: 10px 15px;
    background-color: #2c3e50;
    color: white;
}

#pageList input:disabled {
    background-color: #95a5a6;
    cursor: default;
}

#pageList a:hover, #pageList input:hover {
    background-color: #34495e;
}

/* 공지사항 영역 조정 */
h2 {
    text-align: center;
    color: #2c3e50;
}

h3 {
    text-align: center;
    color: #2c3e50;
    margin: 10px 0; /* 간격을 줄이기 위해 margin 조정 */
}

.area {
    text-align: center; /* 중앙 정렬 */
}

.area a {
    padding: 10px 20px; 
    text-decoration: none;
    color: #333;
    border: 1px solid #ccc; 
    background-color: #f9f9f9; 
    margin: 0 5px; 
    cursor: pointer; 
}

  .area a.selected {
            background-color: #34495e;
            color: #fff;
        }

/* 클릭된 링크 스타일 */
.area a.active {
    background-color: #2980b9; /* 클릭된 링크 배경색 */
    color: white; /* 클릭된 링크 텍스트 색상 */
    border-radius: 5px; /* 링크에 둥근 테두리 추가 */
    padding: 5px 10px; /* 패딩 추가 */
}

#listForm {
  width: 900px; /* 리스트폼 너비 900px로 설정 */
  margin: 0 auto; /* 중앙 정렬 */
}

#buttonArea {
    margin-top: 10px; /* 상단 여백을 줄이기 위해 margin 조정 */
}


</style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>    
</header>

<section>
    <h3>고객센터</h3> <!-- 고객센터 제목 추가 -->
</section>
<section id="buttonArea">
    <div class="area">
        <a href="Notice" data-page="Notice" class="selected">공지사항</a> | 
        <a href="FAQ" data-page="FAQ">자주찾는질문</a> | 
        <a href="Cs" data-page="Cs">1:1문의</a>  
    </div>
    <br>
</section>   
<section id="listForm">
    <table border="1">
        <tr id="tr_top">            
            <th class="column" width="100px">글번호</th>
            <th class="column">제목</th>
            <th class="column" width="150px">등록일</th>
            <th class="column">조회수</th>
        </tr>
        <c:set var="pageNum" value="1" />
        <c:if test="${not empty param.pageNum}">
            <c:set var="pageNum" value="${param.pageNum}" />
        </c:if>
        <c:forEach var="notice" items="${noticeList}">
            <tr>
                <td>${notice.notice_idx}</td>
                <td><a href="NoticeDetail?notice_idx=${notice.notice_idx}">${notice.notice_subject}</a></td>                    
                <td>${notice.notice_date}</td>
                <td>${notice.notice_readcount}</td>
            </tr>
        </c:forEach>
    </table>
</section>
<section id="pageList">
    <input type="button" value="이전" 
           onclick="location.href='Notice?pageNum=${pageNum - 1}'"
           <c:if test="${pageNum <= 1}">disabled</c:if> >
    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
        <c:choose>
            <c:when test="${i eq pageNum}">
                <b>${i}</b> 
            </c:when>
            <c:otherwise>
                <a href="Notice?pageNum=${i}">${i}</a> 
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <input type="button" value="다음" 
           <c:if test="${pageNum >= pageInfo.maxPage}">disabled</c:if>
    >
</section>

<footer>
    <jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>    
</footer>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    // URL의 쿼리 파라미터에서 페이지 정보를 가져옵니다.
    var urlParams = new URLSearchParams(window.location.search);
    var currentPage = urlParams.get('page') || '';

    // 모든 링크 요소를 선택
    var links = document.querySelectorAll('.area a');

    // 링크 클릭 시
    links.forEach(function(link) {
        if (link.getAttribute('data-page') === currentPage) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }

        link.addEventListener('click', function() {
            // 모든 링크에서 'active' 클래스를 제거
            links.forEach(function(el) {
                el.classList.remove('active');
            });
            // 클릭된 링크에 'active' 클래스 추가
            this.classList.add('active');
        });
    });
});
</script>
</body>
</html>
