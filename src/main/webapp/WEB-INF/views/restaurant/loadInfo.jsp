<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>가게 정보 페이지</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
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
	<section id="info1">
		<form id="loadInfoFrm">
			<section style="border-spacing: 5px">
				<div>
					<p>${restaurant.name} </p>
					${district.name}
					[${restaurant.districtCode}][${restaurant.dong}]<br/>
					[${restaurant.foodCode}][${restaurant.naverFoodType}]<br/><br/>
					
					n명의 평가 : (평균) 
				</div>
			</section>
			<hr />
			<section>
				<div>
					<p>가게 정보</p>
					${restaurant.address}<br/>
					${restaurant.phone}<br/>
					찜
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
							<p>더보기</p>
							<input type="submit" value="더보기" id="btn-more" onclick="add_ul()"/>
							<%-- <c:forEach var="menuList" items="${menuList}" begin="10">
								<li><c:out value="${menuList}" /></li>
							</c:forEach> --%>
						</c:if>
						<%-- <c:set var="menuList" value="${menuList}"/> --%>
						<%-- <c:set></c:set> 이용해 분기 / 10개 넘어가면 접어서 높이값 고정 후 누르면 fit-content로 확장 --%>
						
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
			
		</div>
	</section>
	
	<script>
	document.querySelector("#loadInfoFrm").addEventListener('submit', (e) => {
		e.preventDefault();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/restaurant/loadInfo",
			method:"GET",
			data:{"restaurant":restaurant},
			success(response){
				console.log(response);
			},
			error:console.log
		});
	})
	const add_ul = () => {
		const ul1 = document.getElementById("btn-more");
		const btnId = document.createElement('li');
		btnId.innerHTML = `<c:forEach var="menuList" items="\${menuList}" begin="10">
			<li><c:out value="\${menuList}" /></li>
			</c:forEach>`;
	}
	
	</script>
	
</body>
</html>