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
	<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css'/>
	
<style>
body {
	background-color: #F0EBEC;
	
}
#info1 {
	background-color: white;
	margin: 30px 350px;
	height: auto;
}
#info2 {
	background-color: white;
	margin: 30px 350px;
	height: 300px;
	border-spacing: 20px;
}
#lastDiv {
	border-left: 10px;
	padding: 20px;
	margin: 30px 5px;
}
#gather {
	font-size: 30px;
}
#loadInfoFrm div p {
	font-size: 20px;
}
#loadInfoFrm{
	border-left: 10px;
	padding: 20px;
	margin: 30px 5px;
}
p {
	margin-top: 0;
}
hr {
	width: 99%;
	margin: 15px -10px;
}
#info1 #loadInfoFrm section {
	border-spacing: 20px;
}
.inner-star::before{
	color: #FF9600;
}
.outer-star {
	position: relative;
	display: inline-block;
	color: #CCCCCC;
}
.inner-star {
	position: absolute;
	left: 0;
	top: 0;
	width: 0%;
	overflow: hidden;
	white-space: nowrap;
}
.outer-star::before, .inner-star::before {
	content: '\f005 \f005 \f005 \f005 \f005';
	font-family: 'Font Awesome 5 free';
	font-weight: 900;
}

</style>
</head>
<body>
	<section id="info1">
		<form id="loadInfoFrm">
			<section>
				<div style="display: flex; justify-content: space-between">
					<div>
						<h1 style="font-size: 40px; font-weight: bold; margin-top: 0;">${restaurant.name} </h1>
						<div>
							[${district.name}][${restaurant.getDong().trim()}]<br/>
							[${foodType.type}][${restaurant.naverFoodType}]<br/><br/>
							
							${reviews.size()}명의 평가 : (평균) ${totalAvg} 
							<div class='RatingStar'>
						        <div class='RatingScore'>
						            <div class='outer-star'><div class='inner-star'></div></div>
						        </div>
						    </div>
						</div>
					</div>
						<div style="border-left: 1px solid gray; border-spacing: 500px; display: flex; flex-direction:column; justify-content: space-between;">
							<p>&emsp;이 가게 찜하기&emsp;</p>
							<div style="text-align: center;">
								<sec:authorize access="isAnonymous()">
								<input type="button" value="♡" id="like-restaurant"
									onclick="like()"/>
								<script>
								const like = () => {
									alert("로그인 후 이용해주세요.");
								}
								</script>
								</sec:authorize>
								<sec:authorize access="isAuthenticated()">
								<sec:authentication property="principal.no" var="loginMember"/>
								
									<input type="button" value="♡" id="like-restaurant"/>
									<input type="hidden" name="loginMember" id="hiddenMemberNo" value="${loginMember}"/>
									<div style="font-size: 60px;" id="fav">
										${loginMember}
									</div>
									<div style="display: none;" id="cancelFav">
										찜취소
									</div>
								</sec:authorize>
							</div>
						</div>
				</div>
			</section>
			<hr />
			<section>
				<div>
					<p>가게 정보</p>
					<div>🚩 <span style="border-left: 1px solid gray;">&nbsp; ${restaurant.address}</span></div><br/>
					<div>📞 <span style="border-left: 1px solid gray;">&nbsp; ${restaurant.phone}</span></div><br/>
					<div>💖 <span style="border-left: 1px solid gray;">&nbsp; 이 식당을 ${favCount}명의 사용자가 찜했습니다.</span></div><br/>
				</div>
			</section>
			<hr />
			<section>
				<div class="gatherSection">
					<p>영업시간</p>
					<ul>
						<c:forEach var="whlist" items="${whlist}">
							<li><c:out value="${whlist}" /></li>
						</c:forEach>
					</ul>
					<p>메뉴정보</p>
					<ul id="ul1">
						<c:forEach var="menuList" items="${menuList}" begin="0" end="9">
							<li><c:out value="${menuList}" /></li>
						</c:forEach>
						<c:if test="${menuList.size() > 10}">
							<input type="button" value="메뉴더보기" id="btnMenuMore"/>
							<div id="moreMenuList"></div>
							<input type="button" value="접기" id="btnMenuClose" style="display: none"/>
							<div id="closeMenuList"></div>
						</c:if>
					</ul>
				</div>
			</section>
			<section>
				<div>
					<p>대표사진</p>
					<hr />
					<div>
						사진 들어감
					</div>
					<br />
				</div>
			</section>
			<section>
				<div>
					<p>가게리뷰</p>
					<hr />
					<div style="text-align: center;">
						<c:if test="${reviews.size() eq '0'}">
							아직 리뷰가 없습니다 :(
						</c:if>
						<c:if test="${reviews.size() ne '0'}">
							<c:out value="${reviews.size()}명의 방문자 리뷰"/><br />
							<strong><c:out value="${totalAvg}점"/></strong>
							<%-- <c:out value="${}" escapeXml="false"> 
							
							</c:out>--%>
							<div class='RatingStar'>
						        <div class='RatingScore'>
						            <div class='outer-star'><div class='inner-star'></div></div>
						        </div>
						    </div>
							<br /><br />
							<c:out value="맛 : ${totalTasteAvg} ★"/>&emsp;&emsp;<c:out value="가격 : ${totalPriceAvg} ★"/>&emsp;&emsp;<c:out value="서비스 : ${totalServiceAvg} ★"/><br /><br />
						</c:if>
					</div>
					<hr />
					<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: space-between; white-space: normal;">
						<c:forEach var="review" items="${reviews}" begin="0" end="1">
							<div style="width: 40%; padding: 5px 15px;">
								<p style="margin-bottom: 0px;"><c:out value="${review.writer}" /></p><br />
								<c:if test="${review.overallScore eq '5'}">
								<p>★★★★★</p>
								</c:if>
								<c:if test="${review.overallScore eq '4'}">
								<p>★★★★</p>
								</c:if>
								<c:if test="${review.overallScore eq '3'}">
								<p>★★★</p>
								</c:if>
								<c:if test="${review.overallScore eq '2'}">
								<p>★★</p>
								</c:if>
								<c:if test="${review.overallScore eq '1'}">
								<p>★</p>
								</c:if>
								<c:if test="${review.overallScore eq '0'}">
								<p>☆</p>
								</c:if>
								<br />
								<c:out value="맛★ ${review.tasteScore} 가격★ ${review.priceScore} 서비스★ ${review.serviceScore}" /><br />
								<c:out value="${review.content}" /><br />
							</div>
							<br />
						</c:forEach>
					</div>
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
	<br />
	<span></span>
	<br />
	<%@ include file="/WEB-INF/views/restaurant/map.jsp" %>
	<section id="info2">
		<div id="lastDiv">
			<div>
				<p id="gather" style="border-bottom: 1px solid gray; margin-bottom: 10px;">이 가게의 모임</p>
			</div>
			<div style="display: flex;">
				<c:forEach var="gathers" items="${gathers}">
					<div style="background-color: #F1F1F1; margin: 15px; display: flex; width: 25%; white-space: normal;">
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
			
			</div>
			
		</div>
	</section>
	<div style="display: none;">
		<input type="checkbox" id="faved">
	</div>
	
	<script>
	const ratings = {RatingScore: `${totalAvg}`}; 
    const totalRating = 5;
    const table = document.querySelector('.RatingStar');
    function rateIt() {
        for (rating in ratings) {
            const ratingPercentage = ratings[rating] / totalRating * 100;
            const ratingRounded = Math.round(ratingPercentage / 10) * 10 + '%';
            const star = table.querySelector(`.\${rating} .inner-star`); 
            const numberRating = table.querySelector(`.\${rating} .numberRating`);
            star.style.width = ratingRounded;
            //numberRating.innerText = ratings[rating];
        }
    }
    rateIt();
	window.addEventListener('load', ()=> {
		const userNo = document.querySelector("#hiddenMemberNo").value;
		const restaurantNo = '${restaurant.no}';
		rateIt();
		$.ajax({
			url:"${pageContext.request.contextPath}/restaurant/checkFaved",
			method:"GET",
			data:{"userNo":userNo, "restaurantNo":restaurantNo},
			success(response){
				console.log(response);
				if(response){
					document.querySelector("#faved").checked = true;
					document.querySelector("#like-restaurant").value = '💖';
				}
			},
			error:console.log
		})
		
	});
	
	document.querySelector("#like-restaurant").addEventListener('click', ()=>{
		
		const cancelFav = document.querySelector("#cancelFav");
		const userNo = document.querySelector("#hiddenMemberNo").value;
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

				} else {
					document.querySelector("#like-restaurant").value = '💖';
					
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
	
	// 메뉴
	const moreMenuList = document.querySelector("#moreMenuList");
	const btnMenuMore = document.querySelector("#btnMenuMore");
	const closeMenuList = document.querySelector("#closeMenuList");
	const btnMenuClose = document.querySelector("#btnMenuClose");
	
	document.querySelector("#btnMenuMore").addEventListener('click', (e) => {
		moreMenuList.innerHTML = `<c:forEach var="menuList" items="${menuList}" begin="10">
			<li><c:out value="${menuList}" /></li>
			</c:forEach>`;
		btnMenuMore.style.display="none";
		btnMenuClose.style.display="inline";
	})
	document.querySelector("#btnMenuClose").addEventListener('click', (e) => {
		moreMenuList.innerHTML = ``;
		btnMenuMore.style.display="inline";
		btnMenuClose.style.display="none";
	})
	
	const moreReviewList = document.querySelector("#moreReviewList");
	const btnReviewMore = document.querySelector("#btnReviewMore");
	const closeReviewList = document.querySelector("#closeReviewList");
	const btnReviewClose = document.querySelector("#btnReviewClose");
	
	document.querySelector("#btnReviewMore").addEventListener('click', (e) => {
		moreReviewList.innerHTML = `<c:forEach var="review" items="${reviews}" begin="2">
		<div style="width: 40%; padding: 5px 15px;">
			<p style="margin-bottom: 0px;"><c:out value="${review.writer}" /></p><br />
			<c:if test="${review.overallScore eq '5'}">
			<p>★★★★★</p>
			</c:if>
			<c:if test="${review.overallScore eq '4'}">
			<p>★★★★</p>
			</c:if>
			<c:if test="${review.overallScore eq '3'}">
			<p>★★★</p>
			</c:if>
			<c:if test="${review.overallScore eq '2'}">
			<p>★★</p>
			</c:if>
			<c:if test="${review.overallScore eq '1'}">
			<p>★</p>
			</c:if>
			<c:if test="${review.overallScore eq '0'}">
			<p>☆</p>
			</c:if>
			<br />
			<c:out value="맛★ ${review.tasteScore} 가격★ ${review.priceScore} 서비스★ ${review.serviceScore}" /><br />
			<c:out value="${review.content}" /><br />
		</div>
	</c:forEach>`;
		btnReviewMore.style.display="none";
		btnReviewClose.style.display="inline";
	});
	document.querySelector("#btnReviewClose").addEventListener('click', (e) => {
		moreReviewList.innerHTML = ``;
		btnReviewMore.style.display="inline";
		btnReviewClose.style.display="none";
	})
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>