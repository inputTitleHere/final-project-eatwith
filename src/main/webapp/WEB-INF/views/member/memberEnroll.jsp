<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>같이먹을래 - 회원가입</title>
<!-- 
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
<script crossorigin src="https://unpkg.com/react@17/umd/react.production.min.js"></script>
<script crossorigin src="https://unpkg.com/react-dom@17/umd/react-dom.production.min.js"></script>
 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/root.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member-enroll/member-enroll.css"/>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">
</head>
<body>
<div class="header">
	<img id="banner-image" src='${pageContext.request.contextPath}/resources/image/eatwith-banner.png' alt="MemberEnrollHeader.jsx확인 바람" height='100px' onclick='location.href="${pageContext.request.contextPath}/"'/>
</div>
<div class="image-wrapper">&nbsp;</div>
<div id="content-wrapper">
  <h1>신규 회원 가입</h1>
  
  <div id="form-wrapper"></div>
  
</div>  

<script type="text/javascript" src="/eatwith/resources/js/bundle/member-enroll.js"></script>
</body>
</html>