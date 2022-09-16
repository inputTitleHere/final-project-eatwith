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


<div class="content-root"></div>

<script>
window.addEventListener('load',()=>{
	fetch('${pageContext.request.contextPath}/mypage/currentUser')
		.then((response)=>response.json())
		.then((data)=>{
			console.log(data);
		})
})


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

</body>
</html>