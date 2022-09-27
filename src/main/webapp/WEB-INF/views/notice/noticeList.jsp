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
			<title>공지사항-목록</title>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice/noticeList.css" />
			<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">
			<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	</head>
<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
</c:if>
	<body>
		<!-- header include -->
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
			<section id="noticeList-container" class="container">
				<sec:authorize access="hasRole('ADMIN')">			
					<input type="button" value="새로운 공지 작성하기" id="notice-add" class="button-notice-add"
						onclick="location.href='${pageContext.request.contextPath}/notice/noticeForm';" />
				</sec:authorize>
			<table id="table-noticeList" class="table">
			<thead>
				<tr id="table-title" class ="title">
					<th>공지사항</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr id="table-data-empty" class ="contents">
						<td colspan="6" class="text-center">조회된 공지사항이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty list}">
					<c:forEach items="${list}" var="notice">
						<tr class="table-data" class ="contents" data-no="${notice.noticeNo}">
							<td>${notice.noticeNo}</td>
							<td>제목 : ${notice.noticeTitle}</td>
						<c:if test="${empty notice.updatedAt}">
							<td>${notice.noticeDate}</td>
						</c:if>
						<c:if test="${not empty notice.updatedAt}">
							<td>${notice.updatedAt}</td>
						</c:if>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
			</table>
			<nav>${pagebar}</nav>
		</section>
		
		<script>
		document.querySelectorAll("tr[data-no]").forEach((tr) => {
			tr.addEventListener('click', (e) => {
				const tr = e.target.parentElement;
				const no = tr.dataset.no;
				if(no){
					location.href = "${pageContext.request.contextPath}/notice/noticeDetail?noticeNo=" + no;
				}
			});
		});
		</script>
		
		<!-- footer include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</body>
	
</html>
