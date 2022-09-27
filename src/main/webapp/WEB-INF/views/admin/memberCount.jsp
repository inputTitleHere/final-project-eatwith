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
			<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">
			<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
			<style>
			/*
				1) 부트스트랩 쓸거면 후에 적용 (Ajax..?)
				2) CSS 파일은 따로 설정
			*/
			</style>
	</head>
<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
</c:if>
	<body>
		<!-- header include -->
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
		<!-- 공지사항 : section 내, table + button + pagebar 구성
					1) table : 가로형 사진 게시판으로, DB 에 저장된 첫번째 이미지 노출(이미지 없을 시, 기본 사진 노출)
					2) button : 사용자 권한 있는 이용자에게만 노출되도록 설정
					3) pagebar : 만들어 두신 것 사용했습니다.
						+) table 틀, button 함수 : 수업 때 내용이랑 동일하게 구성되었습니다.
				-->		
		<section id="noticeList-container" class="container">
							<div>${totalContent}</div>
			<table id="table-noticeList" class="table">
				<tr id="table-title" class ="title">
					<th>공지사항</th>
				</tr>
				<c:if test="${empty list}">
					<tr id="table-data-empty" class ="contents">
						<td colspan="6" class="text-center">조회된 공지사항이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty list}">
					<c:forEach items="${list}" var="member">
						<tr id="table-data" class ="contents">
							<td>${member.no} : 시작</td>
							<td>${member.id}</td>
							<td>${member.name}</td>
							<td>${member.enrollAt}</td>
							<td>${member.deletedAt}</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
				<input type="button" value="새로운 글 작성" id="notice-add" class="button-notice-add"
					onclick="location.href='${pageContext.request.contextPath}/notice/noticeForm';" />
			<nav>${pagebar}</nav>
		</section>
		
		<!-- footer include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</body>
	
</html>
