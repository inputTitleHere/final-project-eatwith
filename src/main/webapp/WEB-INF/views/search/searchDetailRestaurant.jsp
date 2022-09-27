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
			<title>상세검색</title>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
			<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">
			<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
				crossorigin="anonymous"></script>
</head>
<body>
		<!-- header include -->
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
		
		<section id="search-container">
		
		<div>
			<ul>
				<li>리뷰 : 링크 미부여</li>
				<li>모임 : 링크 미부여</li>
				<li>식당 : 링크 미부여</li>
			</ul>
		</div>
		
	<form action="<%=request.getContextPath() %>/search/searchDetailRestaurant" method="GET">
	<div id ="districtList-button">
		<label class="all-chk"><input type="checkbox" id="districtList_All" class="common-condition" />전체</label>
		<c:forEach items="${districtList}" var="district">
			<label><input type="checkbox" class="districtNameList" value="${district.code}" name="districtCode" />${district.name}</label>
		</c:forEach>
	</div>
	
	<div id ="foodTypeList-button">
		<label class="all-chk"><input type="checkbox" id="foodTypeList_All" class="common-condition" />전체</label>
		<c:forEach items="${foodTypeList}" var="foodType">
			<label><input type="checkbox" class="foodTypeNameList" value="${foodType.code}" name="foodTypeCode" />${foodType.type}</label>
		</c:forEach>
	</div>
	
	<div>
		<label><input type="range" name="overallScore" min="1" max="5" step="1">별점</label>
		<label><input type="range" name="tasteScore" min="1" max="5" step="1">맛</label>
		<label><input type="range" name="priceScore" min="1" max="5" step="1">가격</label>
		<label><input type="range" name="serviceScore" min="1" max="5" step="1">서비스</label>
	</div>
	<input type="hidden" name="cPage" value="1">
	<input type="text" name ="keyword"/>
	<input type="submit">
</form>
		
		<div>검색결과</div>
		
	<div><%= request.getParameter("districtCode")%></div>
	<div><%= request.getParameter("keyword") %></div>
		
		<c:if test="${empty resultSearchRestaurant}">
		<ul id="table-data-empty" class ="contents">
			<li class="text-center">조회된 결과가 없습니다.</li>
		</ul>
		</c:if>
		
		<c:if test="${not empty resultSearchRestaurant}">
		<c:set value="${districtCode}" var="districtCodea" />
		<c:set value="${foodTypeCode}" var="foodTypeCodea" />
		<c:forEach items="${resultSearchRestaurant}" var="restaurant">
			<c:if test="${fn:contains(districtCodea, restaurant.districtcode)}">
			<c:if test="${fn:contains(foodTypeCodea, restaurant.foodType)}">
			<div class="dataOutline">
				<ul class ="data" data-no="${restaurant.no}">
					<li>${restaurant.imageName}</li>
					<li>${restaurant.name}</li>
					<li>${restaurant.address}</li>
				</ul>
						<ul class="restaurantData" data-no="${restaurant.no}" id="restaurantData-score">
							<li>
								<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/>
								 x ${restaurant.overall}
							</li>
							<li>
								<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/>
								x ${restaurant.taste}
							</li>
							<li>
								<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/>
								x ${restaurant.price}
							</li>
							<li>
								<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/>
								x ${restaurant.service}
							</li>
						</ul>
						<ul>
						<li>${restaurant.menu}</li>
						</ul>
					<ul>
					<li>${restaurant.phone}</li>
					<li>${restaurant.foodType}</li>
				</ul>
			</div>
		</c:if>
		</c:if>
		</c:forEach>
		</c:if>
		</section>
		
<script>

$(document).ready(function() {
	
	today = new Date();
	today = today.toISOString().slice(0, 10);
	bira = document.querySelector("#meetDateMin");
	birb = document.querySelector("#meetDateMax");
	bira.value = today;
	birb.value = today;
	
	$("input:checkbox[id='cbx_chkAll']").prop("checked",true);
	$("input:checkbox[id='districtList_All']").prop("checked",true);
	$("input:checkbox[id='foodTypeList_All']").prop("checked",true);
	$("input[name=chk]").prop("checked", true);
	$("input[name=districtCode]").prop("checked", true);
	$("input[name=foodTypeCode]").prop("checked", true);
	
	$("#cbx_chkAll").click(function() {
		if($("#cbx_chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
		else $("input[name=chk]").prop("checked", false);
	});
	
	$("input[name=chk]").click(function() {
		var total = $("input[name=chk]").length;
		var checked = $("input[name=chk]:checked").length;
		
		if(total != checked) $("#cbx_chkAll").prop("checked", false);
		else $("#cbx_chkAll").prop("checked", true); 
	});
	
	
	
	$("#districtList_All").click(function() {
		if($("#districtList_All").is(":checked")) $("input[name=districtCode]").prop("checked", true);
		else $("input[name=districtCode]").prop("checked", false);
	});
	
	$("input[name=districtCode]").click(function() {
		var total = $("input[name=districtCode]").length;
		var checked = $("input[name=districtCode]:checked").length;
		
		if(total != checked) $("#districtList_All").prop("checked", false);
		else $("#districtList_All").prop("checked", true); 
	});
	
	
	
	$("#foodTypeList_All").click(function() {
		if($("#foodTypeList_All").is(":checked")) $("input[name=foodTypeCode]").prop("checked", true);
		else $("input[name=foodTypeCode]").prop("checked", false);
	});
	
	$("input[name=foodTypeCode]").click(function() {
		var total = $("input[name=foodTypeCode]").length;
		var checked = $("input[name=foodTypeCode]:checked").length;
		
		if(total != checked) $("#foodTypeList_All").prop("checked", false);
		else $("#foodTypeList_All").prop("checked", true); 
	});
	
	
	
// 이게 끝	
});
   </script>
		<!-- footer include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</body>
	
</html>
