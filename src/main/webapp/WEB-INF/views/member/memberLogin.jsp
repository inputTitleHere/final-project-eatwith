<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="eatwith" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
	<link rel="shortcut icon"
		href="${pageContext.request.contextPath }/resources/image/favicon.ico">
	<link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css'/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/login.css" />

</head>
<body>
	<section id="sec1">
		<div id="firstDiv">
			<h1>로그인 및 회원가입</h1>
			
			<div>
				<span style="">로그인을 통해 다양한 혜택을 누리세요</span>
			</div>
		</div>
		<form:form
			action="${pageContext.request.contextPath}/member/memberLogin"
			method="post"
			id="loginFrm">
			<div class="divInFrm">
				<input type="text" name="id" class="inputInfo" id="memberId" placeholder="아이디" required> 
			</div>
			<div class="divInFrm">
				<input type="password" name="password" class="inputInfo" id="password" placeholder="비밀번호" required>
			</div>
			<div>
				<div id="rememId">
					<input type="checkbox" name="remember-me" id="remember-me"/>
					<label for="remember-me" id="loginLabel">로그인 상태 유지</label>
				</div>
				<div>
					<button type="submit" id="loginBtn">로그인</button>
				</div>
			</div>
		</form:form>
	
		<div>
			<input type="button" value="아이디/비밀번호 찾기" id="find" onclick="location.href='${pageContext.request.contextPath}/member/memberFind'"/>
		</div>
		
		<div>
			<p id="noMem">아직 같이먹을래 회원이 아니신가요?</p>
			<p id="benefit">회원가입을 하시면 더 많은 정보와 혜택을 받으실 수 있습니다.</p>
			<br />
			<input type="button" value="회원가입하기" id="enroll" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll'"/>
		</div>
	</section>
	
	<script>
	document.querySelector("#loginBtn").addEventListener('submit', (e) => {
		e.preventDefault();
		const memberId = document.querySelector("#id").value;
		const password = document.querySelector("#pwd").value;
		
		$.ajax({
			url:"${pageContext.request.contextPath}/member/memberLogin",
			method:"POST",
			data:{"memberId":memberId, "password":password},
			success(response){
				console.log(response);
				if(!response){
					alert("아이디 또는 비밀번호를 확인해주세요.")
				}
			},
			error:console.log
		})

	})
	
	</script>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>