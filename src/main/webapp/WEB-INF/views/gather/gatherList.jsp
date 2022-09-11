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
h3{
	margin:0.5em 0;
}
#container{
	display:flex;
    font-size:16px;
	width: 1200px;	
	left:0;
	right:0;
	margin:auto;
	padding:100px;
}
aside {
	width: 260px;
	margin-left: 10px;
	padding-left: 20px;
	padding-right: 20px;
	margin-right: 10px;
	padding-bottom: 20px;
	background-color: white;
}
.district-wrapper,.food-wrapper{
	width:240px;
	height:fit-content;
	margin:0;
	display:flex;
	flex-wrap:wrap;
	justify-content:space-between;
}
.district-wrapper label, .food-wrapper label{
	width:40%;
}
#content {
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
tr{
	width:200px;
}
td {
	padding : 0px 10px 10px 10px;
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
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div id="container">
		<aside>
            <h3>모임 지역 선택</h3>
            <input type="checkbox" name="location" id="selectAll" onclick="selectAll(this)">서울 전체<br>
            <div class="district-wrapper">
            <label><input type="checkbox" name="location" value="3220000" id="3220000">강남구</label>
            <label><input type="checkbox" name="location" value="3240000" id="3240000">강동구</label>
            <label><input type="checkbox" name="location" value="3080000" id="3080000">강북구</label>
            <label><input type="checkbox" name="location" value="3150000" id="3150000">강서구</label>
            <label><input type="checkbox" name="location" value="3200000" id="3200000">관악구</label>
            <label><input type="checkbox" name="location" value="3040000" id="3040000">광진구</label>
            <label><input type="checkbox" name="location" value="3160000" id="3160000">구로구</label>
            <label><input type="checkbox" name="location" value="3170000" id="3170000">금천구</label>
            <label><input type="checkbox" name="location" value="3100000" id="3100000">노원구</label>
            <label><input type="checkbox" name="location" value="3090000" id="3090000">도봉구</label>
            <label><input type="checkbox" name="location" value="3050000" id="3050000">동대문구</label>
            <label><input type="checkbox" name="location" value="3190000" id="3190000">동작구</label>
            <label><input type="checkbox" name="location" value="3130000" id="3130000">마포구</label>
            <label><input type="checkbox" name="location" value="3210000" id="3210000">서초구</label>
            <label><input type="checkbox" name="location" value="3120000" id="3120000">서대문구</label>
            <label><input type="checkbox" name="location" value="3030000" id="3030000">성동구</label>
            <label><input type="checkbox" name="location" value="3070000" id="3070000">성북구</label>
            <label><input type="checkbox" name="location" value="3230000" id="3230000">송파구</label>
            <label><input type="checkbox" name="location" value="3140000" id="3140000">양천구</label>
            <label><input type="checkbox" name="location" value="3020000" id="3020000">용산구</label>
            <label><input type="checkbox" name="location" value="3180000" id="3180000">영등포구</label>
            <label><input type="checkbox" name="location" value="3110000" id="3110000">은평구</label>
            <label><input type="checkbox" name="location" value="3000000" id="3000000">종로구</label>
            <label><input type="checkbox" name="location" value="3010000" id="3010000">중구</label>
            <label><input type="checkbox" name="location" value="3060000" id="3060000">중랑구</label>
            </div>
            <hr>
			
            <h3>모임 음식 분야 선택</h3>
            <div class="food-wrapper">
            <label><input type="radio" name="food" value="001" id="001">한식</label>
            <label><input type="radio" name="food" value="002" id="002">일식</label>
            <label><input type="radio" name="food" value="003" id="003">양식</label>
            <label><input type="radio" name="food" value="004" id="004">회/해산물</label>
            <label><input type="radio" name="food" value="005" id="005">중식</label>
            <label><input type="radio" name="food" value="006" id="006">분식/면류</label>
            <label><input type="radio" name="food" value="007" id="007">고기/구이</label>
            <label><input type="radio" name="food" value="008" id="008">치킨/닭요리</label>
            <label><input type="radio" name="food" value="009" id="009">아시아음식</label>
            <label><input type="radio" name="food" value="010" id="010">카페/디저트</label>
            <label><input type="radio" name="food" value="011" id="011">기타</label>            
            </div>
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
			<table id="tbl-gather">
				<tbody>
				<c:if test="${empty lists}">
					<tr>
						<td colspan="8" id="noGather">모임이 아직 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty lists}">
					<c:forEach items="${lists}" var="gather">
						<tr data-no="${gather.no}">
							<td>${gather.title}<br></td>
							<td>${gather.name}</td>
							<td>${gather.type}</td>
							<td>${gather.locaName}</td>
							<td>${gather.meetDate}</td>
							<td><span id="nowCount"></span>/<span id="totalCount">${gather.count+1}</span></td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
		</section>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
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