<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="com.kh.eatwith.member.model.dto.Member" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="<%=request.getContextPath()%>/resources/js/jquery-3.6.0.js"></script>
<title>모임 채팅참여</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/root.css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath }/resources/image/favicon.ico">
<style>
</style>
</head>
<body>
	

<script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</script>
</body>
</html>