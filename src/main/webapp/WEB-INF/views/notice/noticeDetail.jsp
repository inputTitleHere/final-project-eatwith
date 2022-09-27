<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/root.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/notice/noticeDetail.css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath }/resources/image/favicon.ico">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
</head>

<body>
<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
</c:if>
	<!-- header include -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<section id="notice-container" class="container">
		<div id="notice-view" class="notice-view">
	<sec:authorize access="hasRole('ADMIN')">
				<div class="btn">
					<button type="button" class="btn-btn"
					onclick="location.href='${pageContext.request.contextPath}/notice/noticeUpdate?noticeNo=${notice.noticeNo}';">수정</button>
				<button type="button" class="btn-btn" onclick="deleteNotice()">삭제</button>
			</div>
		</sec:authorize>
			
			<ul id="notice-info" class="notice-info">
				<li>${notice.noticeTitle}</li>
				<c:set var = "updatedAt" value = "${notice.updatedAt}" />
				<c:set var = "deletedAt" value = "${notice.deletedAt}" />
				<c:if test="${not empty updatedAt}">
					<li>최종 수정일 : ${notice.updatedAt}</li>
				</c:if>
				<c:if test="${empty updatedAt}">
					<li>작성일 : ${notice.noticeDate}</li>
				</c:if>			
			</ul>

			<div class="notice-contents" id="notice-contents">
				이게 내용 : ${notice.noticeContents}
			</div>
					
			<c:forEach items="${list}" var="notice">
			<ul id="pre-next">
			<c:if test="${notice.pre ne '-1'}">
				<li>이전글 : ${notice.pre}</li>
			</c:if>
				<li>현재글 : ${notice.noticeTitle}</li>
			<c:if test="${notice.next ne '-1'}">
				<li>다음글 : ${notice.next}</li>
			</c:if>
			</ul>
			</c:forEach>

		</div>

	</section>
	
	        <form action="<%=request.getContextPath() %>/notice/noticeDelete?noticeNo=${notice.noticeNo}" 
        		method="post" name="deleteForm"></form>
<script>
const deleteNotice=()=>{
	if(confirm("공지사항을 삭제하시겠습니까?")){
		document.deleteForm.submit();
	}
}
</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>