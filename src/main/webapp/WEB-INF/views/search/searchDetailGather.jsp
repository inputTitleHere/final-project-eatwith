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

<form action="<%=request.getContextPath() %>/search/searchDetailGather" method="GET">

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
			
			<div id ="age-button">
				<label> 연령 최소 : 
				<select name="ageRestrictionBottom" size="6">
							<option selected value="0">전체</option>
							<option value="20">20세 이상</option>
							<option value="30">30세 이상</option>
							<option value="40">40세 이상</option>
							<option value="50">50세 이상</option>
							<option value="60">60세 이상</option>
				</select>
				</label>

				<label> 연령 최대 :
				<select name="ageRestrictionTop" size="6">
							<option selected value="999">전체</option>
							<option value="20">20세 미만</option>
							<option value="30">30세 미만</option>
							<option value="40">40세 미만</option>
							<option value="50">50세 미만</option>
							<option value="60">60세 미만</option>
				</select>
				</label>
			</div>
			
			<div id ="count-buttom">
				<label> 참여인원 수 :
				<select name="count" size="3">
							<option selected value="0">인원제한 없음</option>
							<option value="2">2인 이하</option>
							<option value="4">4인 이하</option>	
							<option value="999">4인 초과</option>	
				</select>		
				</label>
			</div>
			
			<div id ="meet-button">
				<label><input type="date" name="meetDateMin" id="meetDateMin">시작일</label>
				<label><input type="date" name="meetDateMax" id="meetDateMax">끝일</label>
			</div>
			
			<div id ="gender-buttom">
				<label> 성별 선택 :
				<select name="genderRestriction" size="3">
							<option selected value="1">성별제한 없음</option>
							<option value="M">남자만</option>
							<option value="F">여자만</option>	
				</select>		
				</label>
			</div>

			<input type="text" name="keyword" id="keyword"/>
			<input type="hidden" name="cPage" value="1">
			<input type="submit" id="submit-btn">
		</form>
		
		<h2>검색결과</h2>
			<c:set value="${districtCode}" var="searchDistrict" />
			<c:set value="${foodTypeCode}" var="searchFoodType" />
	
	
		<c:if test="${empty resultSearchGather}">
					<ul id="reviewData-empty" class="data-empty">
						<li>조회된 결과가 없습니다</li>
					</ul>
		</c:if>
	
		<c:if test="${not empty resultSearchGather}">
			<c:forEach items="${resultSearchGather}" var="gather">
				<c:if test="${fn:contains(searchDistrict, review.districtcode)}">
				<c:if test="${fn:contains(foodTypeCode, review.foodcode)}">
					<ul class ="data" data-no="${gather.no}">
						<li>${gather.title}</li>
						<li>${gather.restaurantname}</li>					
						<li>${gather.districtName}</li>					
						<li>${gather.address}</li>					
						<li>${gather.username}</li>					
						<li>${gather.attend}</li>					
						<li>${gather.count}</li>
						<li>${gather.foodtype}</li>			
						<li>${gather.meetdate}</li>					
						<li>${gather.agerestrictionbottom}</li>					
						<li>${gather.agerestrictiontop}</li>					
						<c:if test="${not empty gather.genderrestriction}">
							<li class="gender"> 성별 제한 : ${gather.genderrestriction eq 'M' ? '남자': '여자'}</li>
						</c:if>
						<c:if test="${empty gather.genderrestriction}">
								<li>성별제한 : 없음</li>
						</c:if>								
					</ul>
				</c:if>
				</c:if>
			</c:forEach>
		</c:if>
		</section>
<script>
	
	$(document).ready(function() {
		
		$("input:checkbox[id='districtList_All']").prop("checked",true);
		$("input:checkbox[id='foodTypeList_All']").prop("checked",true);
		
		$("input[name=districtCode]").prop("checked", true);
		$("input[name=foodTypeCode]").prop("checked", true);
		
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
		
	});
	
	
</script>
		<!-- footer include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</body>
	
</html>
