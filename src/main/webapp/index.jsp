<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 여기 위에 HEADER를 배치한다.-->
<!-- 박우석 -2022/08/31- 헤더가 만들어져있지 않아서 임시로 작성 -->
<div id="header-root">
<button class="btn btn-login" type="button" 
	onclick="location.href='${pageContext.request.contextPath}/member/memberLogin';">로그인</button>
<button id="register-button" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll';">회원가입</button>
</div>


<h1>임시 인덱스 페이지!!!</h1>

<div id="content-root">
  <div id="best-review-root">
    <h2 class="div-header">BEST리뷰 TOP4</h2>
  </div>



</div>



</body>
</html>