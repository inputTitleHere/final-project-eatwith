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
	<title>가게 정보 페이지</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
	<link rel="shortcut icon"
		href="${pageContext.request.contextPath }/resources/image/favicon.ico">
	<link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css'/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restaurant/loadInfo.css" />

</head>
<body>
	<section id="info1">
		<form id="loadInfoFrm">
			<section>
				<div style="display: flex; justify-content: space-between">
					<div>
						<h1>${restaurant.name} </h1>
						<div>
							[${district.name}][${restaurant.getDong().trim()}]<br/>
							[${foodType.type}][${restaurant.naverFoodType}]<br/><br/>
							
							
							<div class='RatingStar'>
						        <div class='RatingScore'>
						            ${reviews.size()}명의 평가 : (평균)&nbsp;&nbsp;<span style="font-size: 35px; font-weight: bold;">${totalAvg}점  </span> <div class='outer-star'><div class='inner-star'></div></div>
						        </div>
						    </div>
						</div>
					</div>
						<div style="border-left: 1px solid gray; border-spacing: 500px; display: flex; flex-direction:column; justify-content: flex-start;">
							<p id="favTag">&emsp;이 가게 찜하기&emsp;</p>
							<div style="text-align: center;">
								<sec:authorize access="isAnonymous()">
								<input type="button" value="♡" id="like-restaurant"	onclick="like()"/>
								<script>
								const like = () => {
									alert("로그인 후 이용해주세요.");
								}
								</script>
								</sec:authorize>
								<sec:authorize access="isAuthenticated()">
								<sec:authentication property="principal.no" var="loginMember"/>
								
									<input type="button" value="♡" id="like-restaurant" />
									<input type="hidden" name="loginMember" id="hiddenMemberNo" value="${loginMember}"/>
									<div style="font-size: 60px; display: none;" id="fav">
										${loginMember}
									</div>
<!-- 									<div style="display: none;" id="cancelFav"> -->
<!-- 										찜취소 -->
<!-- 									</div> -->
								</sec:authorize>
							</div>
						</div>
				</div>
			</section>
			<hr />
			<section>
				<div>
					<p>가게 정보</p>
					<div>🚩 &nbsp;&nbsp;<span id="restInfo1">&nbsp; ${restaurant.address}</span></div><br/>
					<div>📞 &nbsp;&nbsp;<span id="restInfo1">&nbsp; ${restaurant.phone}</span></div><br/>
					<div>💖 &nbsp;&nbsp;<span id="restInfo1">&nbsp; 이 식당을 ${favCount}명의 사용자가 찜했습니다.</span></div><br/>
				</div>
			</section>
			<hr />
			<section>
				<div>
					<p>영업시간</p>
					<ul>
						<c:forEach var="whlist" items="${whlist}">
							<li><c:out value="${whlist}" /></li>
						</c:forEach>
					</ul>
				</div>
				<div>
					<p>메뉴정보</p>
					<ul id="ul1">
						<c:forEach var="menuList" items="${menuList}" begin="0" end="9">
							<li><c:out value="${menuList}" /></li>
						</c:forEach>
					</ul>
				</div>
					<c:if test="${menuList.size() > 10}">
						<div id="btnMenuMoreDiv"><span><input type="button" value="메뉴 더보기" id="btnMenuMore"/></span></div>
						<div id="moreMenuList"></div>
						
						<div id="btnMenuCloseDiv"><span><input type="button" value="접기" id="btnMenuClose" style="display: none"/></span></div>
						<div id="closeMenuList"></div>
					</c:if>
				
			</section>
			<br />
			<section>
				<div>
					<p style="margin-top: 70px;">대표사진</p>
					<hr />
					<div style="text-align: center;">
						<c:if test="${attachs.size() eq '0'}">
	<!-- 						<span style="text-align: center; font-size: 20px;">아직 등록된 사진이 없습니다 :(</span> -->
							<span style="text-align: center; font-size: 20px;">등록된 사진이 없습니다 :( </span>
						</c:if>
						<c:if test="${attachs.size() ne '0'}">
							<div id="restImg">
								<c:forEach var="attach" items="${attachs}">
									<c:out value="<img src='${pageContext.request.contextPath}/resources/upload/review/${attach.imageName}' id='img'/>" escapeXml="false"/>
								</c:forEach>
							</div>
						</c:if>
					</div>
					<br />
				</div>
			</section>
			<section>
				<div>
					<p>가게리뷰</p>
					<hr />
					<div id="reviewSummary">
						<c:if test="${reviews.size() eq '0'}">
							<span style="text-align: center; font-size: 20px;">등록된 리뷰가 없습니다 :(</span>
						</c:if>
						<c:if test="${reviews.size() ne '0'}">
							<p style="margin-left: 0;"><c:out value="${reviews.size()}명의 방문자 리뷰"/><br /></p>
						    <div id="RatingStar">
						      <div id="RatingScore">
						        <span style="font-weight: bold; font-size: 30px;">${totalAvg} 점&emsp;</span><div id="outer-star"><div id="inner-star"></div></div>
						      </div>
						    </div>
							<br /><br />
						
							<div style="padding: 10px 0;">
								맛 : <fmt:formatNumber value="${totalTasteAvg} " pattern=".0"/><span id="reviewStar">★</span>&emsp;&emsp; 가격 : <fmt:formatNumber value="${totalPriceAvg}" pattern=".0"/><span id="reviewStar">★</span>&emsp;&emsp; 서비스 : <fmt:formatNumber value="${totalServiceAvg}" pattern=".0"/><span id="reviewStar">★</span>
							</div>
						</c:if>
					</div>
					<hr />
					<div id="addReview">
						<c:forEach var="review" items="${reviews}" begin="0" end="1">
							<div id="reviewDiv">
								<span id="writer"><c:out value="${review.writer}"/></span>
								<div>
									<c:if test="${review.overallScore eq '5'}">
									<span id="reviewStar">★★★★★</span>
									</c:if>
									<c:if test="${review.overallScore eq '4'}">
									<span id="reviewStar">★★★★</span><span>☆</span>
									</c:if>
									<c:if test="${review.overallScore eq '3'}">
									<span id="reviewStar">★★★</span><span>☆☆</span>
									</c:if>
									<c:if test="${review.overallScore eq '2'}">
									<span id="reviewStar">★★</span><span>☆☆☆</span>
									</c:if>
									<c:if test="${review.overallScore eq '1'}">
									<span id="reviewStar">★</span><span>☆☆☆☆</span>
									</c:if>
									<c:if test="${review.overallScore eq '0'}">
									<span>☆☆☆☆☆</span>
									</c:if>
								</div>
							
								<div style="padding: 10px 0;">
									맛<span id="reviewStar">★</span><c:out value="${review.tasteScore}"/>&nbsp;&nbsp;&nbsp;가격<span id="reviewStar">★</span><c:out value="${review.priceScore}"/>&nbsp;&nbsp;&nbsp;서비스<span id="reviewStar">★</span><c:out value="${review.serviceScore}"/><br />								
								</div>
								<c:out value="${review.content}" /><br />
							</div>
						</c:forEach>
					</div>
					<br />
					<c:if test="${reviews.size() > 2}">
						<input type="button" value="리뷰더보기" id="btnReviewMore"/>
						<div id="moreReviewList"></div>
						<input type="button" value="접기" id="btnReviewClose" style="display: none"/>
						<div id="closeReviewList"></div>
					</c:if>
				</div>
			</section>
		</form>
	</section>

	<div>
		<%@ include file="/WEB-INF/views/restaurant/map.jsp" %>
	</div>
	
	<section id="info2">
		<div id="lastDiv">
			<div> <!-- style="border-bottom: 1px solid gray; margin-bottom: 10px;" -->
				<p id="gather">이 가게의 모임</p>
			</div>
			<hr />
			<div id="addGather">
				<c:forEach var="gathers" items="${gathers}" begin="0" end="3">
					<div id="gatherDiv">
						<c:out value="${gathers.title}" /><br />
						<c:out value="${restaurant.name}" /><br />
						<c:out value="${foodType.type}" /><br />
						<fmt:parseDate value="${gathers.meetDate}" var="meetTime" pattern="yyyy-MM-dd'T'HH:mm"/>
						<fmt:formatDate value="${meetTime}" pattern="MM월dd일 a HH:mm"/><br />
						<c:out value="모임인원 ( ${memGather} / ${gathers.count+1} )" /><br />
						
						<c:if test="${gathers.ageRestrictionTop eq '0'}">
							<c:out value="누구나 참여 가능합니다." /><br />
						</c:if>
						<c:if test="${gathers.ageRestrictionTop ne '0'}">
							<c:out value="나이제한 : ${gathers.ageRestrictionBottom}살 ~ ${gathers.ageRestrictionTop}살"/><br />
						</c:if>
						
						<c:choose>
							<c:when test="${gathers.genderRestriction eq 'M' }">
								<c:out value="성별제한 : 남성만"/>
							</c:when>
							
							<c:when test="${gathers.genderRestriction eq 'F' }">
								<c:out value="성별제한 : 여성만"/>
							</c:when>
							
							<c:otherwise>
								<c:out value="성별제한 : 남녀무관" /><br />
							</c:otherwise>
						</c:choose>
						<button type="button" onClick="location.href=`${pageContext.request.contextPath}/gather/gatherDetail?no=${gather.no}`">모임 페이지로 가기</button>
					</div>
				</c:forEach>
			</div>
			<br />
				<c:if test="${gathers.size() > 4}">
					<input type="button" value="모임더보기" id="btnGatherMore"/>
					<div id="moreGatherList"></div><br />
					<input type="button" value="접기" id="btnGatherClose" style="display: none"/>
					<div id="closeGatherList"></div><br />
				</c:if>			
		</div>
	</section>
	<div style="display: none;">
		<input type="checkbox" id="faved">
	</div>
	
	<script>
	if(${reviews.size() != 0}){
	      const ratings = {RatingScore: `${totalAvg}`}; 
	       const totalRating = 5;
	       const table = document.querySelectorAll('.RatingStar');
	       function rateIt() {
	           for (rating in ratings) {
	               const ratingPercentage = ratings[rating] / totalRating * 100;
	               const ratingRounded = Math.round(ratingPercentage / 10) * 10 + '%';
	               const star1 = table[0].querySelector(`.\${rating} .inner-star`); 
	               const star2 = table[1].querySelector(`.\${rating} .inner-star`); 
	               star1.style.width = ratingRounded;
	               star2.style.width = ratingRounded;
	           }
	       }
	       rateIt();
	      
	   }
	window.addEventListener('load', ()=> {
		const userNo = ${loginMember ne null} ? document.querySelector("#hiddenMemberNo").value : 0;
		const restaurantNo = '${restaurant.no}';
		$.ajax({
			url:"${pageContext.request.contextPath}/restaurant/checkFaved",
			method:"GET",
			data:{"userNo":userNo, "restaurantNo":restaurantNo},
			success(response){
				console.log(response);
				if(response){
					document.querySelector("#faved").checked = true;
					document.querySelector("#like-restaurant").value = '❤';
					document.querySelector("#like-restaurant").style="background-color: white; border: 0 solid white; font-size: 60px; cursor: pointer; color: #EE4949;"
				}
			},
			error:console.log
		})
		
	});
	

	document.querySelector("#like-restaurant").addEventListener('click', ()=>{
		
		const cancelFav = document.querySelector("#cancelFav");
		const userNo = ${loginMember ne null} ? document.querySelector("#hiddenMemberNo").value : 0;
		const restaurantNo = '${restaurant.no}';
		const favBtn = document.querySelector("#faved");
		const fav = favBtn.checked;
		
		$.ajax({
			url:"${pageContext.request.contextPath}/restaurant/toggleFav",
			method:"GET",
			data:{"userNo":userNo, "restaurantNo":restaurantNo, "fav":fav},
			success(response){
				if(fav){
					document.querySelector("#like-restaurant").value = '♡';
					document.querySelector("#like-restaurant").style="background-color: white; border: 0 solid white; font-size: 60px; cursor: pointer;"
				} else {
					document.querySelector("#like-restaurant").value = '❤';
					document.querySelector("#like-restaurant").style="background-color: white; border: 0 solid white; font-size: 60px; cursor: pointer; color: #EE4949;"
				}
				favBtn.checked=!fav;
			},
			error:console.log
		});
	})
	
	
	document.querySelector("#loadInfoFrm").addEventListener('submit', (e) => {
		e.preventDefault();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/restaurant/loadInfo?no=" + ${restaurant.no},
			method:"GET",
			data:{"restaurant":"restaurant"},
			success(response){
				console.log(response);
			    rateIt();
			},
			error:console.log
		});
	})
	
	if(${menuList.size() > 10}){
		
		// 메뉴
		const moreMenuList = document.querySelector("#moreMenuList");
		const btnMenuMore = document.querySelector("#btnMenuMore");
		const closeMenuList = document.querySelector("#closeMenuList");
		const btnMenuClose = document.querySelector("#btnMenuClose");
		
		document.querySelector("#btnMenuMore").addEventListener('click', (e) => {
			moreMenuList.innerHTML = `<ul id="ul1">
				<c:forEach var="menuList" items="${menuList}" begin="0" end="9">
				<li><c:out value="${menuList}" /></li>
			</c:forEach>
		</ul>`;
			btnMenuMore.style.display="none";
			btnMenuClose.style.display="inline";
		})
		document.querySelector("#btnMenuClose").addEventListener('click', (e) => {
			moreMenuList.innerHTML = ``;
			btnMenuMore.style.display="inline";
			btnMenuClose.style.display="none";
		})
	}
	
	if(${reviews.size() > 2}){
		// 리뷰
		const moreReviewList = document.querySelector("#moreReviewList");
		const btnReviewMore = document.querySelector("#btnReviewMore");
		const closeReviewList = document.querySelector("#closeReviewList");
		const btnReviewClose = document.querySelector("#btnReviewClose");
		
		document.querySelector("#btnReviewMore").addEventListener('click', (e) => {
			moreReviewList.innerHTML = `<div id="addReview">
				<c:forEach var="review" items="${reviews}" begin="2">
				<div id="reviewDiv">
					<span id="writer"><c:out value="${review.writer}"/></span>
					<div>
						<c:if test="${review.overallScore eq '5'}">
						<span id="reviewStar">★★★★★</span>
						</c:if>
						<c:if test="${review.overallScore eq '4'}">
						<span id="reviewStar">★★★★</span><span>☆</span>
						</c:if>
						<c:if test="${review.overallScore eq '3'}">
						<span id="reviewStar">★★★</span><span>☆☆</span>
						</c:if>
						<c:if test="${review.overallScore eq '2'}">
						<span id="reviewStar">★★</span><span>☆☆☆</span>
						</c:if>
						<c:if test="${review.overallScore eq '1'}">
						<span id="reviewStar">★</span><span>☆☆☆☆</span>
						</c:if>
						<c:if test="${review.overallScore eq '0'}">
						<span>☆☆☆☆☆</span>
						</c:if>
					</div>
				
					<div style="padding: 10px 0;">
						맛<span id="reviewStar">★</span><c:out value="${review.tasteScore}"/>&nbsp;&nbsp;&nbsp;가격<span id="reviewStar">★</span><c:out value="${review.priceScore}"/>&nbsp;&nbsp;&nbsp;서비스<span id="reviewStar">★</span><c:out value="${review.serviceScore}"/><br />								
					</div>
					<c:out value="${review.content}" /><br />
				</div>
				<br />
			</c:forEach>
		</div><br />`;
			btnReviewMore.style.display="none";
			btnReviewClose.style.display="inline";
		});
		document.querySelector("#btnReviewClose").addEventListener('click', (e) => {
			moreReviewList.innerHTML = ``;
			btnReviewMore.style.display="inline";
			btnReviewClose.style.display="none";
		})
	}

	if(${gathers.size() > 4}){
		//모임
		const moreGatherList = document.querySelector("#moreGatherList");
		const btnGatherMore = document.querySelector("#btnGatherMore");
		const closeGatherList = document.querySelector("#closeGatherList");
		const btnGatherClose = document.querySelector("#btnGatherClose");
		
		document.querySelector("#btnGatherMore").addEventListener('click', (e) => {
			moreGatherList.innerHTML = `<div id="addGather">
				<c:forEach var="gathers" items="${gathers}" begin="4">
				<div id="gatherDiv">
					<c:out value="${gathers.title}" /><br />
					<c:out value="${restaurant.name}" /><br />
					<c:out value="${foodType.type}" /><br />
					<fmt:parseDate value="${gathers.meetDate}" var="meetTime" pattern="yyyy-MM-dd'T'HH:mm"/>
					<fmt:formatDate value="${meetTime}" pattern="MM월dd일 HH:mm"/><br />
					<c:out value="모임인원 ( ${memGather} / ${gathers.count+1} )" /><br />
					
					<c:if test="${gathers.ageRestrictionTop eq '0'}">
						<c:out value="누구나 참여 가능합니다." /><br />
					</c:if>
					<c:if test="${gathers.ageRestrictionTop ne '0'}">
						<c:out value="나이제한 : ${gathers.ageRestrictionBottom}살 ~ ${gathers.ageRestrictionTop}살"/><br />
					</c:if>
					
					<c:choose>
						<c:when test="${gathers.genderRestriction eq 'M' }">
							<c:out value="성별제한 : 남성만"/>
						</c:when>
						
						<c:when test="${gathers.genderRestriction eq 'F' }">
							<c:out value="성별제한 : 여성만"/>
						</c:when>
						
						<c:otherwise>
							<c:out value="성별제한 : 남녀무관" /><br />
						</c:otherwise>
					</c:choose>
				</div>
			</c:forEach>
		</div>`;
			btnGatherMore.style.display="none";
			btnGatherClose.style.display="inline";
		});
		
		document.querySelector("#btnGatherClose").addEventListener('click', (e) => {
			moreGatherList.innerHTML = ``;
			btnGatherMore.style.display="inline";
			btnGatherClose.style.display="none";
		})
	}	
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>