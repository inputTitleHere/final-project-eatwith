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
			<title>검색결과</title>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
			<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search/searchResult.css" />
			<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
				crossorigin="anonymous"></script>
	</head>
	<body>
		<!-- header include -->
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
		
		<section id="search-container">
		
		<div id="search-info">
			<p id="search-info-title">검색결과</p>
			<p id="search-info-searchWord">검색어 : <%= request.getParameter("searchWord") %></p>
			<p class="search-info-searchType"><a href="<%=request.getContextPath() %>/search/searchResult?
							searchWord=<%= request.getParameter("searchWord") %>&searchType=popular">인기순</a></p>
			<p class="search-info-searchType"><a href="<%=request.getContextPath() %>/search/searchResult?
							searchWord=<%= request.getParameter("searchWord") %>&searchType=recent">최신순</a></p>
		</div>					

				

		<div id="search-result">
			<table id="table-review" class="table-dataList">
			<thead>
				<tr id="reviewList-info-start">
					<th id="reviewList-title">리뷰 (총 :  ${totalReview} 건)</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty resultReview}">
					<tr id="reviewList-empty" class ="data-empty">
							<td>조회된 결과가 없습니다</td>
					</tr>
				</c:if>
				<c:if test="${not empty resultReview}">
					<c:forEach items="${resultReview}" var="review">
						<tr class="reviewList-data" class ="reviewList- data" data-no="${review.no}" onClick="location.href='<%=request.getContextPath() %>/restaurant/loadInfo?no=${review.restaurantno}' ">
							<td id="asdasd"><img src='${pageContext.request.contextPath}/resources/upload/review/${review.imagename}'
					 alt="" onError="this.src='${pageContext.request.contextPath}/resources/image/no_img.svg';" height='150px' width='100%'/></td>
							<td id="restaurantname">${review.restaurantname}</td>
							<td id="adress">${review.address}</td>
							<td id="username">${review.username}</td>
							<td id="content">${review.content}</td>
							<td id="overallscore">
									총점: <img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/> x ${review.overallscore}
							</td>
							<td id="taste"> 맛 :
							<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/> x
								${review.tastescore}</td>
							<td id="price"> 가격 :
							<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/> x 
								${review.pricescore}</td>
							<td id="service"> 서비스 :
							<img src='${pageContext.request.contextPath}/resources/image/Star.png' id="star" height='20px' width='20px'/> x 
								${review.servicescore}</td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
				<tfoot>
					<c:if test="${totalReview > '3'}">
						<tr id="ReviewList-fill-more"  class="more-review">			
							<td>${totalReview <= 10 ? '다른 리뷰 검색하러가기': '검색결과 더보기'}</td>
						</tr>
						<tr id="ReviewList-fill-more">			
							<td><button id="review-basic-more">더보기</button></td>
						</tr>
					</c:if>
					<c:if test="${totalReview <= '3'}">
						<tr id="ReviewList-more-more"  class="more-review">			
							<td>다른 식당 검색하러가기</td>
						</tr>
					</c:if>
			</tfoot>
			</table>			
		

<table id="table-gather" class="table-dataList">
				<thead>
					<tr id="gatherList-title">
						<th id="gatherList-title">모임 (총 : ${totalGather} 건)</th>
					</tr>
				</thead>
				<tbody>						
				<c:if test="${empty resultGather}">
					<tr id="gatherList-empty" class="data-empty">
						<td>조회된 결과가 없습니다</td>
					</tr>
				</c:if>
				<c:if test="${not empty resultGather}">
					<c:forEach items="${resultGather}" var="gather">
						<tr class ="gatherList-data" data-no="${gather.no}" onClick="location.href='<%=request.getContextPath() %>/gather/gatherDetail?no=${gather.no}' ">
							<td id="gatherTitle">${gather.title}</td>							
							<td id="gatherDate">모임 일자 : ${fn:substring(gather.meetDate,0,13)}</td>
							<td id="gatherTime">모임 시간 : ${fn:substring(gather.meetDate,14,23)}</td>
							<td id="gatherAttend">현재 모임 인원 : ${gather.attend} / ${gather.count}</td>
							<td id="gatherContent">모임 내용 : ${gather.content}</td>
							<td id="gatherAgeMax">최대 연령 : ${gather.ageRestrictionTop eq 0 ? '연령제한 없음' : gather.ageRestrictionTop}</td>
							<td id="gatherAgeMin">최소 연령 : ${gather.ageRestrictionBottom  eq 0 ? '연령제한 없음' : gather.ageRestrictionTop}</td>
							<c:if test="${not empty gather.genderRestriction}">
								<td class="gender"> 성별 제한 : ${gather.genderRestriction eq 'M' ? '남자': '여자'}</td>
							</c:if>
							<c:if test="${empty gather.genderRestriction}">
								<td>성별제한 : 없음</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
				<tfoot>	
					<c:if test="${totalGather > '3'}">
						<tr id="GatherList-fill-more"  class="more-gather">			
							<td>${totalGather <= 10 ? '다른 모임 검색하러가기': '검색결과 더보기'}</td>
						</tr>
						<tr id="GatherList-fill-more">			
							<td><button id="gather-basic-more">더보기</button></td>
						</tr>
					</c:if>
					<c:if test="${totalGather <= '3'}">
						<tr id="GatherList-more-more"  class="more-gather">	
							<td>다른 모임 검색하기</td>
						</tr>
					</c:if>
			</tfoot>
			</table>

			<table id="table-restaurant" class="table-dataList">
			<thead>
				<tr id="restaurantList-title">
					<th id="restaurantList-title">가게 (총 : ${totalRestaurant} ) 건</th>
				</tr>
			</thead>
				<tbody id="restaurant-data-list">
				<c:if test="${empty resultRestaurant}">
					<tr id="restaurant-empty" class ="data-empty">
							<td>조회된 결과가 없습니다</td>
					</tr>
				</c:if>
				<c:if test="${not empty resultRestaurant}">
					<c:forEach items="${resultRestaurant}" var="restaurant">
						<tr class ="restaurantList-data" class ="restaurantList- data" data-no="${restaurant.no}" onClick="location.href='<%=request.getContextPath() %>/restaurant/loadInfo?no=${restaurant.no}'">
							<td id="asdasd"><img src='${pageContext.request.contextPath}/resources/upload/review/${restaurant.image}'
					 			alt="" onError="this.src='${pageContext.request.contextPath}/resources/image/no_img.svg';" height='150px' width='100%'/></td>
							<td id="restaurantname">${restaurant.name}</td>
							<td id="adress">${restaurant.address}</td>
							<c:if test="${restaurant.overallscore > '0'}">
							<td id="overallscore">
								리뷰 총점: <img src='${pageContext.request.contextPath}/resources/image/Star.png'
									 id="star" height='20px' width='20px'/> x ${restaurant.overallscore}
							</td>
							</c:if>							
							<td id="hours">${restaurant.hours}</td>
							<td id="phone">Tel) ${restaurant.phone}</td>
							<c:if test="${restaurant.pop > '0'}">
							<td id="pop">이 가게에서 열린 모임 : ${restaurant.pop} 건입니다.</td>
							</c:if>
							<c:if test="${restaurant.pop = '0'}">
							<td id="pop">이 가게에서 열린 모임 : 0 건입니다.</td>
							</c:if>
							<td id="menu-tag">이 가게 대표 메뉴 : ${restaurant.menu}</td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
				<tfoot>
					<c:if test="${totalRestaurant > '3'}">
						<tr id="RestaurantList-fill-more"  class="more-restaurant">			
							<td>${totalRestaurant <= 10 ? '다른 모임 검색하러가기': '검색결과 더보기'}</td>
						</tr>
						<tr id="RestaurantList-fill-more">			
							<td><button id="restaurant-basic-more">더보기</button></td>
						</tr>
					</c:if>
					<c:if test="${totalRestaurant <= '3'}">
						<tr id="RestaurantList-more-more"  class="more-restaurant">			
							<td>다른 식당 검색하러가기</td>
						</tr>
					</c:if>
				</tfoot>
			</table>
		
		</div>	
		
		</section>
		
<!-- 음식타입 선택 버튼 
	+)
		<c:if test="${fn:contains(foodTypeList, '완료')}">
		</c:if>
-->
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


<%-- 		<c:set var = "searchType" value = '<%= request.getParameter("searchType") %>'></c:set>
		<c:if test ="${searchType eq 'recent'}">
 --%>
		

<script>
   	// 이거 곱하기 3개
	$(document).ready(function(){
		 

		$('.more-review').click(function(){
	          $( '#detailReviewForm' ).submit();
	        } );
		
		$('.more-gather').click(function(){
	          $( '#detailGatherForm' ).submit();
	        } );
		
		$('.more-restaurant').click(function(){
	          $( '#detailRestaurantForm' ).submit();
	        } );
		
		
		if(${totalRestaurant} > 3){
		 $("#table-restaurant tr:nth-child(n+2)").hide();
		 $("#table-restaurant tr:last-child").show();
		 $("#RestaurantList-fill-more").hide();
			textchange = false;
			  $('#restaurant-basic-more').click(function(){
			    if(textchange){
			      textchange = false;
			      $('#restaurant-basic-more').text('더보기');
			    }else{
			      textchange = true;
			      $('#restaurant-basic-more').text('접어두기');
			    }
			    $('#table-restaurant tr:nth-child(n+2)')
			    	.toggle('10',function(){
			    $("#table-restaurant tr:last-child").show();
			    });
				 $("#RestaurantList-fill-more").toggle();
			  })
		}else{
/* 			 $("#table-restaurant tr:nth-child(n+2)").hide(); */
			 $("#table-restaurant tr:last-child").show();

			}
		
		if(${totalReview} > 3){	
		 $("#table-review tr:nth-child(n+3)").hide();
		 $("#table-review tr:last-child").show();
		 $("#ReviewList-fill-more").hide();
			textchange = false;
			  $('#review-basic-more').click(function(){
			    if(textchange){
			      textchange = false;
			      $('#review-basic-more').text('더보기');
			    }else{
			      textchange = true;
			      $('#review-basic-more').text('접어두기');
			    }
			    $('#table-review tr:nth-child(n+3)')
			    	.toggle('10',function(){
			    $("#table-review tr:last-child").show();
			    });
				 $("#ReviewList-fill-more").toggle();
			  })
		}else{
			 /* $("#table-review tr:nth-child(n+3)").hide();
			  */$("#ReviewList-fill-more").show();
		}
		
		
		if(${totalGather} > 3){  
		 $("#table-gather tr:nth-child(n+3)").hide();
		 $("#table-gather tr:last-child").show();
		 $("#GatherList-fill-more").hide();
			textchange = false;
			  $('#gather-basic-more').click(function(){
			    if(textchange){
			      textchange = false;
			      $('#gather-basic-more').text('더보기');
			    }else{
			      textchange = true;
			      $('#gather-basic-more').text('접어두기');
			    }
			    $('#table-gather tr:nth-child(n+3)')
			    	.toggle('10',function(){
			    $("#table-gather tr:last-child").show();
			    });
				 $("#GatherList-fill-more").toggle();
			  })
		}else{
/* 			 $("#table-gather tr:nth-child(n+3)").hide(); */
			 $("#table-gather tr:last-child").show();
		}	
	
	});
   	
   	
   	
</script>
		<!-- footer include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</body>
	
</html>
