<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>같이먹을래 404</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
<style type="text/css">
.wrapper{
	display:flex;
	justify-content:center;
	align-items: center;
	flex-direction:column;
}
.content{
	font-size:180px;
	font-family:var(--short-font);
}
.text{
	font-size:30px;
	font-family:var(--our-font);
}

.button{
	height:120px;
}
button{
	cursor:pointer;
	padding:10px 20px;
	margin:20px;
	font-family:var(--short-font);
	font-size:40px;
	border:2px solid var(--jjin-pink);
	background-color:var(--yeon-pink);
	border-radius:10px;
}
button:hover{
	transition-duration : .2s;
	box-shadow: 0px 0px 10px 10px var(--yeon-pink);
}

</style>
</head>

<body>
<div class="wrapper">
	<div class="content"> 404 </div>
	<div class="text">뭔가 없는 주소를 찾으시려는 군요.</div>
	<div class="button">
		<button onclick="location.href='${pageContext.request.contextPath}'">홈으로 돌아가기</button>
	</div>
</div>

</body>
</html>