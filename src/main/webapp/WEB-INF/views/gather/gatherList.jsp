<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.kh.eatwith.gather.model.dto.Gather"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 리스트</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/root.css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath }/resources/image/favicon.ico">
<style>
aside {
	float: left;
	width: 260px;
	margin-left: 10px;
	padding-left: 20px;
	padding-right: 20px;
	margin-right: 10px;
	padding-bottom: 20px;
	background-color: white;
}

#content {
	float: left;
	width: 700px;
	background-color: white;
	padding-bottom: 20px;
	margin-left: 10px;
	padding-right: 20px;
	margin-right: 10px;
}

#makegather {
	float: right;
}

td {
	width: 200px;
	padding-left: 20px;
	padding-right: 20px;
	padding-bottom: 20px;
	font-size: 18px;
	text-align: center;
}

#seeSelect {
	height: 30px;
}

#makeGather {
	margin-left: 610px;
	color: white;
	background-color: #DC948A;
	border: 0;
	width: 100px;
	height: 30px;
	margin-top: 10px;
	margin-bottom: 10px;
}

#seeMore {
	background-color: #e3e3e3;
	margin-left: 20px;
	margin-right: 5px;
	text-align: center;
}

#moreGather {
	background-color: #e3e3e3;
	height: 36px;
	border: 0px;
	font-size: 20px;
}

.goGatherBtn {
	border: 0;
	width: 130px;
	height: 30px;
	margin-top: 3px;
	margin-left: 28px;
	color: white;
	background-color: #DC948A;
	display: flex;
	justify-content: center;
}

#noGather{
	text-align:center;
	width:720px;
	font-size:24px;
}
</style>
</head>
<body bgcolor="#F0EBEC">
	<div id="container">
		<aside>
			<h3>모임 지역 선택</h3>
			<input type="checkbox" name="location" onclick="selectAll(this)">서울
			전체<br> <input type="checkbox" name="location">강남구 <input
				type="checkbox" name="location">강동구<br> <input
				type="checkbox" name="location">강북구 <input type="checkbox"
				name="location">강서구<br> <input type="checkbox"
				name="location">관악구 <input type="checkbox" name="location">광진구<br>
			<input type="checkbox" name="location">구로구 <input
				type="checkbox" name="location">금천구<br> <input
				type="checkbox" name="location">노원구 <input type="checkbox"
				name="location">도봉구<br> <input type="checkbox"
				name="location">동대문구 <input type="checkbox" name="location">동작구<br>
			<input type="checkbox" name="location">마포구 <input
				type="checkbox" name="location">서초구<br> <input
				type="checkbox" name="location">서대문구 <input type="checkbox"
				name="location">성동구<br> <input type="checkbox"
				name="location">성북구 <input type="checkbox" name="location">송파구<br>
			<input type="checkbox" name="location">양천구 <input
				type="checkbox" name="location">용산구<br> <input
				type="checkbox" name="location">영등포구 <input type="checkbox"
				name="location">은평구<br> <input type="checkbox"
				name="location">종로구 <input type="checkbox" name="location">중구<br>
			<input type="checkbox" name="location">중랑구
			<hr>
			<h3>모임 음식 분야 선택</h3>
			<input type="radio" name="food" />한식 <input type="radio" name="food" />일식<br>
			<input type="radio" name="food" />양식 <input type="radio" name="food" />회/해산물<br>
			<input type="radio" name="food" />중식 <input type="radio" name="food" />분식/면류<br>
			<input type="radio" name="food" />고기/구이 <input type="radio"
				name="food" />치킨/닭요리<br> <input type="radio" name="food" />아시아음식
			<input type="radio" name="food" />카페/디저트<br> <input
				type="radio" name="food" />기타 <input type="radio" name="food" />테스트음식타입
			<hr>
			<h3>모임 정렬</h3>
			<select name="see" id="seeSelect">
				<option value="">보기 설정</option>
				<option value="최신순">최신순 보기</option>
				<option value="마감임박순">마감임박순 보기</option>
			</select>
		</aside>
		<section id="content">
			<input type="button" id="makeGather" value="모임 만들기"
				onclick="gatherEnroll();">
			<script>
            const gatherEnroll=()=>{
            	//loginMember==null일때 조건 추가
            	location.href='<%=request.getContextPath()%>/gather/gatherEnroll';
            }
            </script>
			<br> <br>
			<table id="tbl-gather" class="table table-striped table-hover">
				<c:if test="${empty list}">
					<tr>
						<td colspan="3" id="noGather">모임이 아직 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty list}">
					<c:forEach items="${list}" var="gather">
						<tr data-no="${gather.no}">
							<td>${gather.title}</td>
							<td>${gather.restaurantNo}</td>
							<td>${gather.foodCode}</td>
							<td>${gather.districtCode}</td>
							<td>${gather.meetDate}</td>
							<td><span id="nowCount"></span>/<span id="totalCount">${gather.count}</span></td>
							<td><button type="button" id="gatherDetail" onclick="gatherDetail()" value="모임 참여하기"/></td>
						</tr>
					</c:forEach>
				</c:if>
			
			</table>
		</section>

	</div>
	<script>
        function selectAll(selectAll){
            const checkboxes = document.getElementsByName('location');
            checkboxes.forEach((checkbox)=>{
                checkbox.checked=selectAll.checked;
            })
        }
        const gatherDetail=document.querySelectorAll("tr[data-no]").forEach((tr) => {
        	tr.addEventListener('click', (e) => {
        		// console.log(e.target); // td
        		const tr = e.target.parentElement;
        		const no = tr.dataset.no;
        		// console.log(no);
        		if(no){
        			location.href = "${pageContext.request.contextPath}/gather/gatherDetail?no=" + no;
        		}
        	});     	
        });
    </script>
</body>
</html>