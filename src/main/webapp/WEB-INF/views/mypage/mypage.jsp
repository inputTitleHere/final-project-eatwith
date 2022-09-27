<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="eatwith" />
</jsp:include>


<div id="content-root"></div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bundle/mypage.js"></script>
</body>
</html>