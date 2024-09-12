<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- 외부 CSS 파일(css/default.css) 연결하기 -->
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4; 
    }
    
    #listForm {
    width: 900px;
    max-height: 610px;
    margin: auto;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    overflow-y: auto; 
}
    
    #listForm #tr_top {
        background-color: #2c3e50; 
        color: #ffffff; 
    }
    
    
    h2 {
        text-align: center;
        color: #2c3e50; 
        margin-top: 20px;
    }
    
    table {
        width: 100%;
        border-collapse: collapse; 
    }
    
    table td {
        text-align: center;
        padding: 10px; 
        border: 1px solid #ddd; 
    }
    
    #subject {
        text-align: left;
        padding-left: 20px;
    }
    
    .contentArea > td {
        text-align: left;
        padding: 20px; 
    }
    
    .cont {
        display: block;
        margin: 20px; 
    }
    
    .btnArea {
        margin: 30px auto;
        display: flex;
        justify-content: space-between;
        width: 300px;
    }
    
    .btnArea button {
        background-color: #3498db; 
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px; 
        font-size: 14px;
    }
    
    .btnArea button a {
        color: white;
        text-decoration: none;
    }
    
    .btnArea button:hover {
        background-color: #2980b9; 
    }
    
    #replyArea .img {
    width: 15px;
    height: 15px;
}

    
#replyArea {
    margin-top: 20px;
    padding: 10px;
    background-color: #ffffff; 
    border: 1px solid #ddd; 
    border-radius: 4px; 
    max-height: 300px;
    overflow-y: auto; 
}

#replyListArea {
    border-top: 1px solid #ddd;
    margin-top: 10px; 
}

#replyListArea table {
    width: 100%;
    border-collapse: collapse;
}

#replyListArea td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    vertical-align: top; /* 텍스트 상단 정렬 */
}

.replyTr {
    padding: 10px;
    border-bottom: 1px solid #ddd; /* 댓글 구분선 */
}

.replyContent {
    font-size: 14px;
    color: #333;
    margin-bottom: 5px; /* 내용과 날짜 사이 여백 */
}

.replyWriter {
    font-weight: bold;
    display: inline-block; /* 아이디와 날짜를 같은 줄에 표시하기 위해 inline-block 사용 */
    margin-right: 10px; /* 날짜와의 간격 */
}

.replyDate {
    font-size: 12px;
    color: #888;
    display: inline-block; /* 아이디와 날짜를 같은 줄에 표시하기 위해 inline-block 사용 */
}

.replyMeta {
    margin-bottom: 10px; /* 댓글 내용과 메타 정보 사이 여백 */
}

.reReplyTr {
    padding: 10px;
    background-color: #f9f9f9; /* 대댓글 배경색 */
    margin-left: 20px; /* 대댓글 들여쓰기 */
}

.reReplyContent {
    font-size: 14px;
    color: #555;
}



</style>
<script type="text/javascript">
	function confirmDelete() {
		// 삭제 버튼 클릭 시 확인창(confirm dialog)을 통해 "삭제하시겠습니까?" 출력 후
		// 다이얼로그의 확인 버튼 클릭 시 "BoardDelete" 서블릿 요청
		// => 파라미터 : 글번호, 페이지번호
		if(confirm("삭제하시겠습니까?")) {
			location.href = "NoticeDelete?notice_idx=${notice.notice_idx}&pageNum=${param.pageNum}";
		}
	}
	// ========================================================================
	// 대댓글 작성 아이콘 클릭 처리를 위한 reReplyWriteForm() 함수 정의
	function reReplyWriteForm(reply_idx, reply_re_ref, reply_re_parent_reply_idx, reply_re_lev, reply_re_seq, index) {
		console.log("reReplyWriteForm : " + reply_idx + ", " + reply_re_ref + ", " + reply_re_parent_reply_idx + ", " + reply_re_lev + ", " + reply_re_seq + ", " + index)
		
		// 기존 대댓글 입력폼 있을 경우를 대비해 대댓글 입력폼 요소(#reReplyTr) 제거
		$("#reReplyTr").remove();
		
		// 지정한 댓글 아래쪽에 대댓글 입력폼 표시
		// => 댓글 요소의 tr 태그 지정 후 after() 메서드 호출하여 해당 요소 바깥쪽 뒤에 tr 태그 추가
		// => 해당 댓글 요소의 tr 태그 탐색을 위해 status.index 값을 전달받아 tr 태그 eq(인덱스)로 탐색
		$(".replyTr").eq(index).after(
			'<tr id="reReplyTr">'
			+ '	<td colspan="3">'
			+ '		<form action="NoticeTinyReReplyWrite" method="post" id="reReplyForm">'
			+ '			<input type="hidden" name="notice_idx" value="${notice.notice_idx}">'
			+ '			<input type="hidden" name="reply_idx" value="' + reply_idx + '">'
			+ '			<input type="hidden" name="reply_re_ref" value="' + reply_re_ref + '">'
			+ '			<input type="hidden" name="reply_re_parent_reply_idx" value="' + reply_re_parent_reply_idx + '">'
			+ '			<input type="hidden" name="reply_re_lev" value="' + reply_re_lev + '">'
			+ '			<input type="hidden" name="reply_re_seq" value="' + reply_re_seq + '">'
			+ '			<textarea id="reReplyTextarea" name="reply_content"></textarea>'
			+ '			<input type="button" value="댓글쓰기" id="reReplySubmit" onclick="reReplyWrite()">'
			+ '		</form>'
			+ '	</td>'
			+ '</tr>'
		);
		
	}
	
	// 댓글쓰기(대댓글) 버튼 클릭 처리 => AJAX 활용하여 대댓글 등록 처리
	function reReplyWrite() {
		// 대댓글 입력항목(textarea) 체크
		if($("#reReplyTextarea").val() == "") {
			alert("댓글 내용 입력 필수!");
			$("#reReplyTextarea").focus();
			return;
		}
		
		// AJAX 활용하여 대댓글 등록 요청 - BoardTinyReReplyWrite
		$.ajax({
			type : "POST",
			url : "NoticeTinyReReplyWrite",
			data : $("#reReplyForm").serialize(),
			dataType : "json",
			success : function(response) {
				console.log(JSON.stringify(response));
				if(response.isInvalidSession) { // 잘못된 세션 정보일 경우
					alert("잘못된 접근입니다!");
				} else if(!response.result) { // 댓글 등록 실패일 경우
					alert("댓글 등록 실패!\n잠시 후 다시 시도해 주시기 바랍니다.");
				} else if(response.result) { // 댓글 등록 성공일 경우
					location.reload(); // 현재 페이지 갱신(새로고침)
				}
			},
			error : function() {
				alert("댓글 작성 요청 실패!");
			}
		});
	}
	
	// -----------------------------------------------------------------
	// 댓글 삭제 아이콘 클릭 처리를 위한 confirmReplyDelete() 함수 정의
	function confirmReplyDelete(reply_idx, index) {
// 		console.log("confirmReplyDelete : " + reply_num + ", " + index)
		
		if(confirm("댓글을 삭제하시겠습니까?")) {
			// AJAX 활용하여 "BoardTinyReplyDelete" 서블릿 요청(파라미터 : 댓글번호) - POST
			$.ajax({
				type : "POST",
				url : "NoticeTinyReplyDelete",
				data : {
					"reply_idx" : reply_idx
				},
				dataType : "json",
				success : function(response) {
					console.log(JSON.stringify(response));
					if(response.isInvalidSession) { // 잘못된 세션 정보일 경우
						alert("잘못된 접근입니다!");
					} else if(!response.result) { // 댓글 삭제 실패일 경우
						alert("댓글 삭제 실패!\n잠시 후 다시 시도해 주시기 바랍니다.");
					} else if(response.result) { // 댓글 삭제 성공일 경우
// 						location.reload(); // 현재 페이지 갱신(새로고침)
						// ---------------------------------------------
						// 페이지 갱신 대신 index 값을 활용한 tr 태그 삭제(제거)
						$(".replyTr").eq(index).remove();					
					}
				},
				error : function() {
					alert("댓글 작성 요청 실패!");
				}
			});
		}
	}
	
</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<h2>공지사항</h2>
	<br>
	<section id="listForm">
		<table border="1">
			<tr id="tr_top">			
				<td>제목</td>
				<td width="150px">등록일</td>
				<td>조회수</td>
			</tr>
			
			<tr>
				<td>${notice.notice_subject}</td>
				<td width="150px">${notice.notice_date}</td>
				<td>${notice.notice_readcount}</td>
			<tr class="contentArea">
				<td colspan="3">
					<div class="cont">${notice.notice_content}</div>
				</td>
			</tr>
		</table>
<section id="replyArea">
			<%-- 댓글 작성 폼 영역 --%>
			<form action="NoticeTinyReplyWrite" method="post">
				<%-- 입력받지 않은 글번호, 페이지번호 함께 전달 = hidden 활용 --%>
				<input type="hidden" name="notice_idx" value="${notice.notice_idx}">
				<input type="hidden" name="pageNum" value="${param.pageNum}">
				
				<%-- 세션 아이디가 없을 경우(= 미로그인) 댓글 작성 차단 --%>
				<%-- textarea 와 submit 버튼 disabled, textarea 에 메세지 표시 --%>
				<c:choose>
					<c:when test="${empty sessionScope.sId}"> <%-- 미 로그인 체크 --%>
						<textarea id="replyTextarea" name="reply_content" disabled placeholder="로그인 한 사용자만 작성 가능합니다."></textarea>
						<input type="submit" value="댓글쓰기" id="replySubmit" disabled>
					</c:when>
					<c:otherwise>
						<textarea id="replyTextarea" name="reply_content"></textarea>
						<input type="submit" value="댓글쓰기" id="replySubmit">
					</c:otherwise>
				</c:choose>
			</form>
			<%-- 댓글 목록 표시 영역 --%>
			<div id="replyListArea">
				<table>
    <c:forEach var="tinyReplyNotice" items="${tinyReplyNoticeList}" varStatus="status">
        <tr class="replyTr">
            <td colspan="3">
                <div class="replyMeta">
                    <span class="replyWriter">${tinyReplyNotice.reply_name}</span>
                    <span class="replyDate">
                        <fmt:parseDate var="parsedReplyDate" 
                                       value="${tinyReplyNotice.reply_date}" 
                                       pattern="yyyy-MM-dd'T'HH:mm" 
                                       type="both" />
                        <fmt:formatDate value="${parsedReplyDate}" pattern="MM-dd HH:mm" />
                    </span>
                </div>
                <div class="replyContent">
                    ${tinyReplyNotice.reply_content}
                </div>
                <c:if test="${not empty sessionScope.sId}">
                    <a href="javascript:reReplyWriteForm(${tinyReplyNotice.reply_idx}, ${tinyReplyNotice.reply_re_ref}, ${tinyReplyNotice.reply_re_parent_reply_idx}, ${tinyReplyNotice.reply_re_lev}, ${tinyReplyNotice.reply_re_seq}, ${status.index})">
                        <img src="${pageContext.request.contextPath}/resources/images/reply-icon.png" title="대댓글작성">
                    </a>
                    <c:if test="${sessionScope.sId eq 'admin@naver.com' or sessionScope.sId eq tinyReplyNotice.reply_name}">
                        <a href="javascript:confirmReplyDelete(${tinyReplyNotice.reply_idx}, ${status.index})">
                            <img src="${pageContext.request.contextPath}/resources/images/delete-icon.png" title="댓글삭제">
                        </a>
                    </c:if>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
			</div>
		</section>		
		
		
		<!-- 이전글 다음글 구현 필요 -->
		<div class="btnArea">
			<button value=""><a href="NoticeDetail?notice_idx=${selectedNotice.notice_idx - 1}">이전</a></button>
			<button value=""><a href="Notice">목록</a></button>
			<button value=""><a href="NoticeDetail?notice_idx=${selectedNotice.notice_idx + 1}">다음</a></button>
		</div>
	</section>
	<footer>		
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>
