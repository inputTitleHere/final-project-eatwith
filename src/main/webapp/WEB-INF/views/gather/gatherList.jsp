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
	width:45%;
}
#content {
	width: 720px;
	background-color: white;
	padding-bottom: 20px;
	margin-left: 10px;
	margin-right: 10px;
}
#makegather {
	float: right;
}
#seeSelect {
	height: 30px;
}
#makeGather {
	margin-left: 520px;
	color: white;
	background-color: #DC948A;
	border: 0;
	width: 180px;
	height: 40px;
	margin-top: 10px;
	margin-bottom: 10px;
	font-size:28px;
	font-family:var(--short-font);
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
.gatherList{
	width:750px;
	padding-bottom:10px;
}
.gather-items{
	display:flex;
	width:100%;
	margin-left:20px;
	justify-content:flex-start;
	flex-wrap:wrap;
}
.each-items{
	width:25%;
	margin:5px;
	padding:5px 15px;
	background-color:var(--seperate-gray);
	cursor:pointer;
	font-size:16px;
	display:block;
	min-height:150px;
}
div#type, div#locaName{
	display:flex;
}
#moreBtn{
	background-color: #e3e3e3;
	width:-webkit-fill-available;
    height: 36px;
    border: 0px;
    font-size: 20px;
    margin:0 20px;
}
#noMore{
	margin-left:290px;
	font-size:20px;
	font-weight:bold;
	font-family:var(--short-font);
}
#title{
	font-size:20px;
	font-family:var(--short-font);	
}
#name{
	font-weight:bold;
	margin:8px 0;
}
#seperate{
	border-right:3px var(--indigo-blue) solid;
	padding-right:4px;
}
#seperate2{
	padding-left:4px;
}
#type{
	margin:8px 0;
}
#meetDate{
	margin:8px 0;
}
#count{
	margin:8px 0;
}
</style>
</head>
<body bgcolor="#F0EBEC">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div id="container">
		<aside>
            <h3>모임 지역별로 보기</h3>
            <input type="checkbox" name="location" id="selectAll" onclick="selectAll(this)">서울 전체<br>
            <div class="district-wrapper">
            <label><input type="checkbox" name="location" value="3220000" id="3220000" onclick="selectLoca()">강남구</label>
            <label><input type="checkbox" name="location" value="3240000" id="3240000" onclick="selectLoca()">강동구</label>
            <label><input type="checkbox" name="location" value="3080000" id="3080000" onclick="selectLoca()">강북구</label>
            <label><input type="checkbox" name="location" value="3150000" id="3150000" onclick="selectLoca()">강서구</label>
            <label><input type="checkbox" name="location" value="3200000" id="3200000" onclick="selectLoca()">관악구</label>
            <label><input type="checkbox" name="location" value="3040000" id="3040000" onclick="selectLoca()">광진구</label>
            <label><input type="checkbox" name="location" value="3160000" id="3160000" onclick="selectLoca()">구로구</label>
            <label><input type="checkbox" name="location" value="3170000" id="3170000" onclick="selectLoca()">금천구</label>
            <label><input type="checkbox" name="location" value="3100000" id="3100000" onclick="selectLoca()">노원구</label>
            <label><input type="checkbox" name="location" value="3090000" id="3090000" onclick="selectLoca()">도봉구</label>
            <label><input type="checkbox" name="location" value="3050000" id="3050000" onclick="selectLoca()">동대문구</label>
            <label><input type="checkbox" name="location" value="3190000" id="3190000" onclick="selectLoca()">동작구</label>
            <label><input type="checkbox" name="location" value="3130000" id="3130000" onclick="selectLoca()">마포구</label>
            <label><input type="checkbox" name="location" value="3210000" id="3210000" onclick="selectLoca()">서초구</label>
            <label><input type="checkbox" name="location" value="3120000" id="3120000" onclick="selectLoca()">서대문구</label>
            <label><input type="checkbox" name="location" value="3030000" id="3030000" onclick="selectLoca()">성동구</label>
            <label><input type="checkbox" name="location" value="3070000" id="3070000" onclick="selectLoca()">성북구</label>
            <label><input type="checkbox" name="location" value="3230000" id="3230000" onclick="selectLoca()">송파구</label>
            <label><input type="checkbox" name="location" value="3140000" id="3140000" onclick="selectLoca()">양천구</label>
            <label><input type="checkbox" name="location" value="3020000" id="3020000" onclick="selectLoca()">용산구</label>
            <label><input type="checkbox" name="location" value="3180000" id="3180000" onclick="selectLoca()">영등포구</label>
            <label><input type="checkbox" name="location" value="3110000" id="3110000" onclick="selectLoca()">은평구</label>
            <label><input type="checkbox" name="location" value="3000000" id="3000000" onclick="selectLoca()">종로구</label>
            <label><input type="checkbox" name="location" value="3010000" id="3010000" onclick="selectLoca()">중구</label>
            <label><input type="checkbox" name="location" value="3060000" id="3060000" onclick="selectLoca()">중랑구</label>
            </div>
            <hr>
            <script>
            function selectLoca(){
				const list = document.querySelector('.gather-items');
			    var addListHtml = "";  
                var chk_location=[];
                $("input[name=location]:checked").each(function(){
                    var chkLoca=$(this).val();
                    chk_location.push(chkLoca);
                })
                console.log(chk_location);
                
    			$.ajax({
    				url:"${pageContext.request.contextPath}/gather/checkLoca",
    				method:"GET",
    				data:{chk_location:chk_location},
    				success(loca){
    					console.log(loca);
    					list.innerHTML=``;
    					for(var i=0;i<loca.length;i++){
		                    addListHtml += `<div class="each-items" data-no="`+loca[i].no+`">`;
    	                    addListHtml += `<div id="title">`+ loca[i].title + `</div>`;
    	                    addListHtml += `<div id="name">`+ loca[i].name + `</div>`;
		                    addListHtml += `<div id="type"><span id="seperate">`+ loca[i].type+`</span><span id="seperate2">`+ loca[i].locaname+`</span></div>`;
    	                    addListHtml += `<div id="meetDate">`+ loca[i].meetDate + `</div>`;
    	                    addListHtml += `<div id="count"><span id="nowCount">`+loca[i].nowcount+`</span>/`+`<span id="totalCount">`+(loca[i].count+1)+`<span></div>`;
    	                    addListHtml += `</div>`;
        				}
	                    list.innerHTML+=addListHtml;
	                	document.querySelector('#moreBtn').style.display="none";
	                	if(loca.length==0){
		                	document.querySelector('#noMore').innerHTML="더이상 모임이 없습니다.";
	                	}
	                    const gatherDetail=document.querySelectorAll("div[data-no]").forEach((tr) => {
	                    	tr.addEventListener('click', (e) => {
	                    		// console.log(e.target); // td
	                    		const tr = e.target.parentElement;
	                    		const no = tr.dataset.no;
	                    		if(no){
	                    			location.href = "${pageContext.request.contextPath}/gather/gatherDetail?no=" + no;
	                    		}
	                    	});     	
	                    });
    				},
    				error:console.log
    			})
            }
            </script>
			
            <h3>모임 음식별로 보기</h3>
            <div class="food-wrapper">
            <label><input type="radio" name="food" value="001" id="001" onclick="selectFood()">한식</label>
            <label><input type="radio" name="food" value="002" id="002" onclick="selectFood()">일식</label>
            <label><input type="radio" name="food" value="003" id="003" onclick="selectFood()">양식</label>
            <label><input type="radio" name="food" value="004" id="004" onclick="selectFood()">회/해산물</label>
            <label><input type="radio" name="food" value="005" id="005" onclick="selectFood()">중식</label>
            <label><input type="radio" name="food" value="006" id="006" onclick="selectFood()">분식/면류</label>
            <label><input type="radio" name="food" value="007" id="007" onclick="selectFood()">고기/구이</label>
            <label><input type="radio" name="food" value="008" id="008" onclick="selectFood()">치킨/닭요리</label>
            <label><input type="radio" name="food" value="009" id="009" onclick="selectFood()">아시아음식</label>
            <label><input type="radio" name="food" value="010" id="010" onclick="selectFood()">카페/디저트</label>
            <label><input type="radio" name="food" value="011" id="011" onclick="selectFood()">기타</label>            
            </div>
			<hr>
			<script>
			function selectFood(){
				const list = document.querySelector('.gather-items');
			    var addListHtml = "";  
				var checkFood=$("input[name=food]:checked").val();
				console.log(checkFood);
    			$.ajax({
    				url:"${pageContext.request.contextPath}/gather/checkFood",
    				method:"GET",
    				data:{
    					"checkFood":checkFood
    				},
    				success(loca){
    					console.log(loca);
    					list.innerHTML=``;
    					for(var i=0;i<loca.length;i++){
		                    addListHtml += `<div class="each-items" data-no="`+loca[i].no+`">`;
	                    addListHtml += `<div id="title">`+ loca[i].title + `</div>`;
	                    addListHtml += `<div id="name">`+ loca[i].name + `</div>`;
	                    addListHtml += `<div id="type"><span id="seperate">`+ loca[i].type+`</span><span id="seperate2">`+ loca[i].locaname+`</span></div>`;
	                    addListHtml += `<div id="meetDate">`+ loca[i].meetDate + `</div>`;
	                    addListHtml += `<div id="count"><span id="nowCount">`+loca[i].nowcount+`</span>/`+`<span id="totalCount">`+(loca[i].count+1)+`<span></div>`;
	                    addListHtml += `</div>`;
    					}
	                    list.innerHTML+=addListHtml;
	                	document.querySelector('#moreBtn').style.display="none";
	                	if(loca.length==0){
		                	document.querySelector('#noMore').innerHTML="더이상 모임이 없습니다.";
	                	}
	                    const gatherDetail=document.querySelectorAll("div[data-no]").forEach((tr) => {
	                    	tr.addEventListener('click', (e) => {
	                    		// console.log(e.target); // td
	                    		const tr = e.target.parentElement;
	                    		const no = tr.dataset.no;
	                    		if(no){
	                    			location.href = "${pageContext.request.contextPath}/gather/gatherDetail?no=" + no;
	                    		}
	                    	});     	
	                    });
    				},
    				error:console.log
    			})
			}
			</script>
			
			<h3>모임 정렬</h3>
			<select name="see" id="seeSelect">
				<option value="">보기 설정</option>
				<option value="최신순">최신순 보기</option>
				<option value="마감임박순">마감임박순 보기</option>
			</select>
		</aside>
		<section id="content">
			<sec:authorize access="isAuthenticated()">
			<input type="button" id="makeGather" value="모임 만들기"
				onclick="gatherEnroll();">
			<script>
            const gatherEnroll=()=>{
            	location.href='<%=request.getContextPath()%>/gather/gatherEnroll';
            }
            </script>
            
			<br></sec:authorize><br>
			<div class="gatherList">
				<div class="gather-items">
     				<c:if test="${not empty lists}" >
 					 <c:forEach items="${lists}" var="gather" varStatus="status" begin="0" end="8">
					 <input type="hidden" id="checkMore" value="${page}"/>
					 <div class="each-items" data-no="${gather.no}" >
					 	<div id="title">${gather.title}</div>
					 	<div id="name">${gather.name}</div>
					 	<div id="type"><span id="seperate">${gather.type}</span><span id="seperate2">${gather.locaName}</span></div>
					 	<div id="meetDate">${gather.meetDate}</div>
					 	<div id="count">모임인원 ( <span id="nowCount">${gather.nowcount}</span> / <span id="totalCount">${gather.count+1}</span> )</div>
					 </div>
					 </c:forEach>
				</c:if>
				</div>
			</div>
			<c:if test="${lists.size() gt page*9}">
			<div class="moreZone">
				<div id="noMore"></div>
				<button type="button" id="moreBtn" onclick="more()" display="block">더보기</button>
			</div>
			<script>
	    

			</script>
			</c:if>
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
        const gatherDetail=document.querySelectorAll("div[data-no]").forEach((tr) => {
        	tr.addEventListener('click', (e) => {
        		// console.log(e.target); // td
        		const tr = e.target.parentElement;
        		const no = tr.dataset.no;
        		if(no){
        			location.href = "${pageContext.request.contextPath}/gather/gatherDetail?no=" + no;
        		}
        	});     	
        });
		function more(){
		    var startNum = $(".gather-items .each-items").length;  //마지막 리스트 번호를 알아내기 위해서 tr태그의 length를 구함.
		    var addListHtml = "";  
		    console.log("startNum", startNum); //콘솔로그로 startNum에 값이 들어오는지 확인
			console.log("모어버튼");
			$.ajax({
				url:"${pageContext.request.contextPath}/gather/gatherListNew",
				method:"GET",
		        data : {"startNum":startNum},
				success(data){
					console.log(data);
		                for(var i=0; i<data.length;i++) {
		                    var idx = Number(startNum)+Number(i)+1;   
							 //<div class="each-items" data-no="${gather.no}" >
							 	//<div id="title">${gather.title}</div>
							 	//<div id="name">${gather.name}</div>
					 			//<div id="type"><span id="seperate">${gather.type}</span><span id="seperate2">${gather.locaName}</span></div>
							 	//<div id="meetDate">${gather.meetDate}</div>
					 			//<div>모임인원 ( <span id="nowCount">${gather.nowcount}</span> / <span id="totalCount">${gather.count+1}</span> )</div>
							 //</div>
		                    // 글번호 : startNum 이  10단위로 증가되기 때문에 startNum +i (+1은 i는 0부터 시작)
		                    addListHtml += `<div class="each-items" data-no="`+data[i].no+`">`;
		                    addListHtml += `<div id="title">`+ data[i].title + `</div>`;
		                    addListHtml += `<div id="name">`+ data[i].name + `</div>`;
		                    addListHtml += `<div id="type"><span id="seperate">`+ data[i].type+`</span><span id="seperate2">`+ data[i].locaName+`</span></div>`;
		                    addListHtml += `<div id="meetDate">`+ data[i].meetDate + `</div>`;
		                    addListHtml += `<div id="count">모임인원 ( <span id="nowCount">`+data[i].nowcount+`</span> / `+`<span id="totalCount">`+(data[i].count+1)+`<span> )</div>`;
		                    addListHtml += `</div>`;}
		                if(data.length<=8){
		                	document.querySelector('#moreBtn').style.display="none";
		                	document.querySelector('#noMore').innerHTML+="더이상 모임이 없습니다.";
		                }
		                $(".gather-items").append(addListHtml);
		                startNum+=9;
		                console.log(data.length);
		                const gatherDetail=document.querySelectorAll("div[data-no]").forEach((tr) => {
		                	tr.addEventListener('click', (e) => {
		                		// console.log(e.target); // td
		                		const tr = e.target.parentElement;
		                		const no = tr.dataset.no;
		                		 console.log(no)
		                		if(no){
		                			location.href = "${pageContext.request.contextPath}/gather/gatherDetail?no=" + no;
		                		}
		                	});     	
		                });
		        	},
				error:console.log
			})
		}
        
    </script>
</body>
</html>