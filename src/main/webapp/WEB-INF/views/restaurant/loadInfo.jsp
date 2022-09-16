<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
	
<style>
body {
	background-color: #F0EBEC;
	
}
#info1 {
	background-color: white;
	margin: 10px 100px;
	height: auto;
}
#info2 {
	background-color: white;
	margin: 10px 100px;
	height: 300px;
}
#gather {
	font-size: 30px;
}
#loadInfoFrm div p {
	font-size: 20px;
}
#loadInfoFrm{
	border-left: 10px;
}
</style>
</head>
<body>

	<script>
	
	</script>
	<section id="info1">
		<form id="loadInfoFrm">
			<section style="border-spacing: 5px">
				<div>
					<p>${restaurant.name} </p>
					
					
					[${district.name}][${restaurant.getDong().trim()}]<br/>
					[${foodType.type}][${restaurant.naverFoodType}]<br/><br/>
					
					${reviews.size()}명의 평가 : (평균) ${avg}
					
				</div>
				<div>
					<p>이 가게 찜하기</p>
					<input type="button" value="♡" id="like-restaurant"/>
					<div id="noFav"></div>
					<div id="fav"></div>
				</div>
			</section>
			<hr />
			<section>
				<div>
					<p>가게 정보</p>
					🚩📌 ${restaurant.address}<br/>
					📞☎️ ${restaurant.phone}<br/>
					❤️💗 이 식당을 n명의 사용자가 찜했습니다.
				</div>
			</section>
			<hr />
			<section>
				<div class="">
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
							<input type="button" value="더보기" id="btnMore"/>
							<div id="moreList"></div>
							<input type="button" value="접기" id="btnClose" style="display: none"/>
							<div id="closeList"></div>
						</c:if>
					</ul>
				</div>
			</section>
			<section>
				<div>
					<p>대표사진</p>
				</div>
			</section>
			<section>
				<div>
					<p>가게리뷰</p>
					<c:forEach var="reviews" items="${reviews}">
						<p><c:out value="${reviews}" /></p>
					</c:forEach>
				</div>
			</section>
		</form>
		
	</section>
	<br />
	<span></span>
	<br />
	<section id="info2">
		<div>
			<p id="gather">이 가게의 모임</p>
			<c:forEach var="gathers" items="${gathers}">
				<div style="background-color: yellow; margin: 15px;">
					<c:out value="${gathers.title}" /><br />
					<c:out value="${foodType.type}" /><br />
					<c:out value="${gathers.meetDate}" /><br />
					<c:out value="모임인원 ( / ${gathers.count+1} )" /><br />
					
					<c:if test="${gathers.ageRestrictionTop eq '0'}">
						<c:out value="나이 제한이 없습니다." /><br />
					</c:if>
					
					<%-- <c:if test="${gathers.ageRestrictionTop eq '0'} && ${gathers.ageRestrictionBottom ne '0'}">
						<c:out value="${gathers.ageRestrictionBottom}부터" /><br />
					</c:if>
					
					<c:if test="${gathers.ageRestrictionTop eq '0'} && ${gathers.ageRestrictionBottom eq '0'}">
						<c:out value="누구나!" /><br />
					</c:if>
					
					<c:if>
						<c:out value="${gathers.ageRestrictionBottom}부터 ~ ${gathers.ageRestrictionTop}까지" /><br />
					</c:if> --%>
					
					<c:choose>
						<c:when test="${gathers.genderRestriction eq 'M' }">
							<c:out value="남자만"/>
						</c:when>
						
						<c:when test="${gathers.genderRestriction eq 'F' }">
							<c:out value="여자만"/>
						</c:when>
						
						<c:otherwise>
							<c:out value="남녀무관" /><br />
						</c:otherwise>
					</c:choose>
				
				</div>
			</c:forEach>
		</div>
	</section>
	
	<script>
	window.onload = function(){
		document.querySelector("#like-restaurant").addEventListener('click', (e) => {
			e.preventDefault();
			
			const likeRes = document.querySelector("#noFav");
			likeRes.style.display="inline";
			$.ajax({
				url:"${pageContext.request.contextPath}/restaurant/checkFaved",
				method:"GET",
				data:{"userNo":e.target.userNo, "restaurantNo":e.target.restaurantNo},
				success(response){
					console.log(response);
				},
				error:console.log
			})
			likeRes.innerHTML = `찜완료!♡❤`;
			
		});
	}
	
	document.querySelector("#loadInfoFrm").addEventListener('submit', (e) => {
		e.preventDefault();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/restaurant/loadInfo",
			method:"GET",
			data:{"restaurant":"restaurant"},
			success(response){
				console.log(response);
				
			},
			error:console.log
		});
	})
	
	const moreData = document.querySelector("#moreList");
	const btnMore = document.querySelector("#btnMore");
	const closeData = document.querySelector("#closeList");
	const btnClose = document.querySelector("#btnClose");
	
	document.querySelector("#btnMore").addEventListener('click', (e) => {
		moreData.innerHTML = `<c:forEach var="menuList" items="${menuList}" begin="10">
			<li><c:out value="${menuList}" /></li>
			</c:forEach>`;
		btnMore.style.display="none";
		btnClose.style.display="inline";
	})
	document.querySelector("#btnClose").addEventListener('click', (e) => {
		moreData.innerHTML = ``;
		btnMore.style.display="inline";
		btnClose.style.display="none";
	})
	</script>
	
</body>
</html>