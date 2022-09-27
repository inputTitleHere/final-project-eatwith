<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
  <meta charset="UTF-8">
  <title>같이먹을래</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/image/favicon.ico">
</head>
<body>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="eatwith" />
</jsp:include>


<div id="content-root"></div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>


  
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bundle/index.js"></script>
</body>
</html>
