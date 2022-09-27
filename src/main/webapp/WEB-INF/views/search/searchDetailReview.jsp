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
						<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search/searchDetailReview.css" />
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
				<li class="more-review">리뷰 : 링크 부여 수정 요망</li>
				<li class="more-gather">모임 : 링크 부여 수정 요망</li>
				<li class="more-restaurant">식당 : 링크 부여 수정 요망</li>
			</ul>
		</div>

		<form action="<%=request.getContextPath() %>/search/searchDetailReview" method="GET" name = "detailReviewForm">
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
			
			<div id ="score-button">
			<label><input type="range" name="overallScore" min="1" max="5" step="1">별점</label>
			<label><input type="range" name="tasteScore" min="1" max="5" step="1">맛</label>
			<label><input type="range" name="priceScore" min="1" max="5" step="1">가격</label>
			<label><input type="range" name="serviceScore" min="1" max="5" step="1">서비스</label>
			</div>
			<input type="text" name="keyword" id="keyword"/>
			<input type="hidden" name="cPage" value="1">
			<input type="submit" id="submit-btn">
		</form>

			<h2> 검색결과 </h2>

			<c:set value="${districtCode}" var="searchDistrict" />
			<c:set value="${foodTypeCode}" var="searchFoodType" />

		<c:if test="${empty resultSearchReview}">
			<ul id="reviewData-empty" class="data-empty">
				<li>조회된 결과가 없습니다</li>
			</ul>
		</c:if>
			
		<c:if test="${not empty resultSearchReview}">
			<c:forEach items="${resultSearchReview}" var="review">
				<c:if test="${fn:contains(searchDistrict, review.districtcode)}">
				<c:if test="${fn:contains(foodTypeCode, review.foodtype)}">
			<div class="whole-container">
					<div id="img-container">
					<ul class="reviewData" data-no="${review.no}" id="img-tag">
						<li>
							<img src='${pageContext.request.contextPath}/resources/upload/review/${review.imagename}'
						 		alt="" onError="this.src='${pageContext.request.contextPath}/resources/image/no_img.svg';" height='200px' width='200px' />
						</li>
					</ul>
					</div>
					<div id="content-container">
					<ul class="reviewData" data-no="${review.no}" id="reviewData-info">
						<li>${review.username}</li>
						<li>${review.restaurantname}</li>
						<li>${review.address}</li>
					</ul>
						<ul class="reviewData" data-no="${review.no}" id="reviewData-score">
							<li>
								<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/>
								 x ${review.overallscore}
							</li>
							<li>
								<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/>
								x ${review.tastescore}
							</li>
							<li>
								<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/>
								x ${review.pricescore}
							</li>
							<li>
								<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/>
								x ${review.servicescore}
							</li>
						</ul>
						<ul class="reviewData" data-no="${review.no}" id="reviewData-content">
							<li>${review.content}</li>
						</ul>
					</div>
			</div>
				</c:if>
				</c:if>
			</c:forEach>
		</c:if>
	</section>

<form action="<%=request.getContextPath() %>/search/searchDetailReview" method="GET" name = "detailReviewForm" id="detailReviewForm">
<c:forEach items="${foodTypeList}" var="foodType">
<input type="hidden" class="foodTypeNameList"
		 value="${foodType.code}" name="foodTypeCode"/>
</c:forEach>
<c:forEach items="${districtList}" var="district">
<input type="hidden" class="districtNameList"
		 value="${district.code}" name="districtCode"/>
</c:forEach>
<input type="hidden" name="overallScore" value="1">
<input type="hidden" name="tasteScore" value="1">
<input type="hidden" name="priceScore" value="1">
<input type="hidden" name="serviceScore" value="1">
<input type="hidden" name="keyword" value=" ">
</form>

<form action="<%=request.getContextPath() %>/search/searchDetailGather" method="GET" name = "detailGatherForm" id="detailGatherForm">
<c:forEach items="${foodTypeList}" var="foodType">
<input type="hidden" class="foodTypeNameList"
		 value="${foodType.code}" name="foodTypeCode"/>
</c:forEach>
<c:forEach items="${districtList}" var="district">
<input type="hidden" class="districtNameList"
		 value="${district.code}" name="districtCode"/>
</c:forEach>
<input type="hidden" name="ageRestrictionBottom" value="0">
<input type="hidden" name="ageRestrictionTop" value="999">
<input type="hidden" name="count" value="999">
<input type="hidden" name="meetDateMin" value=" ">
<input type="hidden" name="meetDateMax" value=" ">
<input type="hidden" name="genderRestriction" value=" ">
<input type="hidden" name="keyword" value=" ">
</form>


<form action="<%=request.getContextPath() %>/search/searchDetailRestaurant" method="GET" name = "detailRestaurantForm" id="detailRestaurantForm">
<c:forEach items="${foodTypeList}" var="foodType">
<input type="hidden" class="foodTypeNameList"
		 value="${foodType.code}" name="foodTypeCode"/>
</c:forEach>
<c:forEach items="${districtList}" var="district">
<input type="hidden" class="districtNameList"
		 value="${district.code}" name="districtCode"/>
</c:forEach>
<input type="hidden" name="overallScore" value="1">
<input type="hidden" name="tasteScore" value="1">
<input type="hidden" name="priceScore" value="1">
<input type="hidden" name="serviceScore" value="1">
<input type="hidden" name="keyword" value=" ">
</form>

	
<script>
$(document).ready(function() {
	
	
	$('.more-review').click(function(){
        $( '#detailReviewForm' ).submit();
      } );
	
	$('.more-gather').click(function(){
        $( '#detailGatherForm' ).submit();
      } );
	
	$('.more-restaurant').click(function(){
        $( '#detailRestaurantForm' ).submit();
      } );
	
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
