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
			<title>통계관리</title>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
			<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">
			<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
			
			<!--차트js-->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.0/chart.min.js"></script>
<style>

#restaurantChart{
			/* 가로 width 크기에 따라서 차트 크기가 지정됩니다 */
			width: 80%;
			height: auto;
			margin: 20px;
			padding: 10px;
			border: 1px solid #000000;
			border-radius: 10px;
			background-color: #eeeeee;
			left: 0;
			display: block;
		}
		

#gatherChart{
			/* 가로 width 크기에 따라서 차트 크기가 지정됩니다 */
			width: 800px;
			height: auto;
			margin: 20px;
			padding: 10px;
			border: 1px solid #000000;
			border-radius: 10px;
			background-color: #eeeeee;
			left: 0;
			display: block;
		}
		
#memberChart{
			/* 가로 width 크기에 따라서 차트 크기가 지정됩니다 */
			width: 800px;
			height: auto;
			margin: 20px;
			padding: 10px;
			border: 1px solid #000000;
			border-radius: 10px;
			background-color: #eeeeee;
			left: 0;
			display: block;
		}
		
#gatherRatioChart{
			/* 가로 width 크기에 따라서 차트 크기가 지정됩니다 */
			border: 1px solid #000000;
			border-radius: 10px;
			background-color: #eeeeee;
			left: 0;
			display: block;
		}
		
#gather-info{
	display: flex;
	margin: 0 auto;
	text-align: center;
    justify-content: center;
    align-items: center;
}

#member-info{
	display: flex;
	margin: 0 auto;
	text-align: center;
    justify-content: center;
    align-items: center;
}
h2,h1{
	display:block;
	text-align: left;
    justify-content: left;
    padding-left:22px;
    color: ;
}
h1{
padding-top:30px;
font-weight:
}
section{
	background-color:#ECC7C5;
	width:60%;
	margin : 0 auto;
	border-radius: 10px;
}
canvas{
	display:inline;
	margin: 0 auto;
}
#plus-box{
width:350px;
height:300px;
display:inline-block;
margin: 20px;
}
div#restContainer{
	display:flex;
	text-align: center;
    justify-content: center;
    align-items: center;
}
div#activeGather{
display:inline;
float: right;
}
div#todayGather{
display:inline;
}

div#todayGather *{
display:inline;
}
</style>

	</head>
	<body>

		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section>
	<!--차트가 그려질 부분-->
	<h1>사이트 현황</h1>
	<div id="todayGather">
	<div id="activeGather">
	현재 활동 중인 모임  : ${nowGather}
	</div>
	<div>모임 참여 회원 수 : ${todayGather}</div>
	<c:if test= "${todayGather > lastGather || todayGather eq lastGather}">
		<div>
		전일 대비 : ${todayGather - lastGather}
		<img src="${pageContext.request.contextPath}/resources/image/up.png" alt="" height='15px'/>
	</div>
	</c:if>
	<c:if test= "${todayGather < lastGather}">
		<div id="compareToday">전일 대비 : ${lastGather - todayGather}
				<img src="${pageContext.request.contextPath}/resources/image/down.png" alt="" height='15px'/>
		</div>
	</c:if>
	</div>
<div id="rest-info">
	<h2>가게 만족도</h2>
	<div id="restContainer">
		<canvas id="restaurantChart"></canvas>
	<div id="plus-box">
		<canvas id="gatherRatioChart"></canvas>
	</div>
	</div>
	
</div>
<div id="gather-info">
	<div id="gatherContainer">
		<h2>모임 현황</h2>
			<canvas id="gatherChart"></canvas>
	</div>
	<div>
	
	</div>
</div>

<div id="member-info">
	<div id="memberContainer">
		<h2>가입 현황</h2>
			<canvas id="memberChart"></canvas>
	</div>
</div>

</section>
 <!-- 내부 JS 지정 -->
    <script>

    	/*
    	[JS 요약 설명]
    	1. window.onload : 브라우저 로드 완료 상태를 나타냅니다 
    	2. chart js : <canvas> 사용해 차트를 렌더링 하며 단일 노드와 함께 페이지에 포함된 스크립트만 있으면 됩니다
    	3. chart js 공식 사이트 : https://www.chartjs.org/docs/latest/
    	4. chart js cdn 참고 사이트 : https://cdnjs.com/libraries/Chart.js
    	*/

   	
    	
    	/* [html 최초 로드 및 이벤트 상시 대기 실시] */
    	window.onload = function() {
    		console.log("");
    		console.log("[window onload] : [start]");
    		console.log("");
    		
    		/* 제일 높은 순서대로 가져왔다. 아이고 */
/* 	    		var arr1 =[];
	    		var arr2 =[];
	    		<c:forEach items="${restaurant}" var="item">
		    		arr1.push("${item.name}");
		    		arr2.push("${item.score}");
	    		</c:forEach>   
	    		console.log(arr1);
	    		console.log(arr2); */
    		/* 여기까지 */
    		
    		
    		/* [bar 세로 막대 : 그리기 실시] */
    		drawRestaurant();
    		drawGather();
    		drawMember();
    		drawGatherRatio();	
    	};


    	/* [bar 세로 막대 : 그리기 함수] */
    	function drawRestaurant(){
    		console.log("");
    		console.log("[drawBarHeight] : [start]");
    		console.log("");
			
 		    var overall;
    		var service;
    		var taste;
    		var price;
    		
    		<c:forEach items="${restaurant}" var="item">
	    		var overall = ${item.overall};
	    		var service = ${item.service};
	    		var taste = ${item.taste};
	    		var price = ${item.price};
	    	</c:forEach> 
	    	
    		console.log(overall);
    		console.log(service);
    		
    		// [body 에 선언된 캔버스 id 지정 실시]
    		var ctx = document.getElementById('restaurantChart').getContext('2d');
    		var myChart = new Chart(ctx, {
    			type: 'bar', // [차트 타입 지정]
    			data: {
    				labels: ['평점', '맛', '가격', '서비스'], // [데이터 제목 : 별점 5 ~ 1 점 오면 되겠다.]
    				datasets: [{
    					label: '등록가게 고객 만족도', // [데이터 시트 제목 : 가게 만족도 들어가면 되겠다.]
    					data: [overall, taste, price, service], // [데이터 : 여기에 별점 별 레스토랑 숫자 오면 되겠다.]
    					backgroundColor: [ // [막대 배경 색상 : 동일해도 됨 ]
    						'rgba(255, 99, 132, 0.8)',
    						'rgba(54, 162, 235, 0.8)',
    						'rgba(255, 206, 86, 0.8)',
    						'rgba(75, 192, 192, 0.8)',
    						'rgba(153, 102, 255, 0.8)',
    						'rgba(255, 159, 64, 0.8)'
    					],
    					borderColor: [ // [막대 테두리 색상 : Red ~ Orange ]
    						'rgba(255, 99, 132, 0.8)',
    						'rgba(54, 162, 235, 0.8)',
    						'rgba(255, 206, 86, 0.8)',
    						'rgba(75, 192, 192, 0.8)',
    						'rgba(153, 102, 255, 0.8)',
    						'rgba(255, 159, 64, 0.8)'
    					],
    					borderWidth: 0.5 // [막대 테두리 굵기 설정]
    				}]
    			},
    			options: {
    				responsive: false,
    				plugins:{
    					legend: {
    						display: false
    					}
    				},
    			    elements: {
    			    	   point: {
    			    	   radius: 0,
    			    	  },
    			    },
    				scales: {
    					y: {
    						min:3,
    						stepSize : 0.5
    					}
    				}
    			}
    		});
    	};

    	/* [bar 세로 막대 : 그리기 함수] */
    	function drawGather(){
    		console.log("");
    		console.log("[drawBarHeight] : [start]");
    		console.log("");
			
    		
    		var day =[];
    		var count =[];
    		<c:forEach items="${gather}" var="item">
	    		day.push("${fn:substring(item.day,6,13)}");
	    		count.push("${item.count}");
    		</c:forEach>   
    		console.log(day);
    		console.log(count);
    		<fmt:parseDate value="${gathers.meetDate}" var="meetTime" pattern="yyyy-MM-dd'T'HH:mm"/>
            <fmt:formatDate value="${meetTime}" pattern="MM월dd일 a HH:mm"/>
	    	
    		// [body 에 선언된 캔버스 id 지정 실시]
    		var ctx = document.getElementById('gatherChart').getContext('2d');
    		var myChart = new Chart(ctx, {
    			type: 'line', // [차트 타입 지정]
    			data: {
    				labels: day, // [데이터 제목 : 별점 5 ~ 1 점 오면 되겠다.]
    				datasets: [{
    					label: '등록가게 고객 만족도', // [데이터 시트 제목 : 가게 만족도 들어가면 되겠다.]
    					data: count,
    					fill: true, // [데이터 : 여기에 별점 별 레스토랑 숫자 오면 되겠다.]
    					backgroundColor: [ // [막대 배경 색상 : 동일해도 됨 ]
    						'rgba(129, 166, 211, 1)'
    					],
    					borderColor: [ // [막대 테두리 색상 : Red ~ Orange ]
    						'rgba(129, 166, 211, 1)'
    					],
    					borderWidth: 0.5 // [막대 테두리 굵기 설정]
    				}]
    			},
    			options: {
    				responsive: false,
    				plugins:{
    					legend: {
    						display: false
    					}
    				},
    			    elements: {
    			    	   point: {
    			    	   radius: 0,
    			    	  },
    			    },
    			    xAxis: {
    			    	  lineWidth: 0,
    			    	  minorGridLineWidth: 0,
    			    	  lineColor: 'transparent'
    			    	},
    				scales: {
    					y: {
    						beginAtZero: true,
    						fontSize : 14,
    						stepSize : 1
    					}
    				}
    			}
    		});
    	};
    	
  
    	/* [bar 세로 막대 : 그리기 함수] */
    	function drawMember(){
    		console.log("");
    		console.log("[drawBarHeight] : [start]");
    		console.log("");
			
    		var dayo =[];
    		var counto =[];
    		<c:forEach items="${member}" var="item">
	    		dayo.push("${fn:substring(item.day,6,13)}");
	    		counto.push("${item.count}");
    		</c:forEach>   
    		console.log(dayo);
    		console.log(counto);
	    
    		
    		// [body 에 선언된 캔버스 id 지정 실시]
    		var ctx = document.getElementById('memberChart').getContext('2d');
    		var myChart = new Chart(ctx, {
    			type: 'line', // [차트 타입 지정]
    			data: {
    				labels: dayo, // [데이터 제목 : 별점 5 ~ 1 점 오면 되겠다.]
    				datasets: [{
    					label: '등록가게 고객 만족도', // [데이터 시트 제목 : 가게 만족도 들어가면 되겠다.]
    					data: counto,
    					fill: true,// [데이터 : 여기에 별점 별 레스토랑 숫자 오면 되겠다.]
    					backgroundColor: [ // [막대 배경 색상 : 동일해도 됨 ]
    						'rgba(129, 166, 211, 1)'
    					],
    					borderColor: [ // [막대 테두리 색상 : Red ~ Orange ]
    						'rgba(129, 166, 211, 1)'    					],
    					fillColor: [ // [막대 테두리 색상 : Red ~ Orange ]
    						'rgba(129, 166, 211, 1)'
    					],
    					borderWidth: 0.5 // [막대 테두리 굵기 설정]
    				}]
    			},
    			options: {
    				responsive: false,
    				plugins:{
    					legend: {
    						display: false
    					}
    				},
    			    elements: {
    			    	   point: {
    			    	   radius: 0,
    			    	  },
    			    },
    			    xAxis: {
    			    	  lineWidth: 0,
    			    	  minorGridLineWidth: 0,
    			    	  lineColor: 'transparent'
    			    	},
    				scales: {
    					y: {
    						beginAtZero: true,
    						fontSize : 14,
    						stepSize : 0.1
    					}
    				}
    			}
    		});
    	};
    	
    	function drawGatherRatio(){
    		console.log("");
    		console.log("[drawBarHeight] : [start]");
    		console.log("");
			
    		var name =[];
    		var num =[];
    		<c:forEach items="${gatherRatio}" var="item">
	    		name.push("${item.name}");
	    		num.push("${item.num}");
    		</c:forEach>   
    		
    		// [body 에 선언된 캔버스 id 지정 실시]
    		var ctx = document.getElementById('gatherRatioChart').getContext('2d');
    		var myChart = new Chart(ctx, {
    			type: 'pie', // [차트 타입 지정]
    			data: {
    				labels: name , // [데이터 제목 : 별점 5 ~ 1 점 오면 되겠다.]
    				datasets: [{
    					label: '등록가게 고객 만족도', // [데이터 시트 제목 : 가게 만족도 들어가면 되겠다.]
    					data: num, // [데이터 : 여기에 별점 별 레스토랑 숫자 오면 되겠다.]
    					backgroundColor: [ // [막대 배경 색상 : 동일해도 됨 ]
    						'rgba(255, 99, 132, 0.2)',
    						'rgba(54, 162, 235, 0.2)',
    						'rgba(255, 206, 86, 0.2)',
    						'rgba(75, 192, 192, 0.2)',
    						'rgba(153, 102, 255, 0.2)',
    						'rgba(255, 159, 64, 0.2)'
    					],
    					borderColor: [ // [막대 테두리 색상 : Red ~ Orange ]
    						'rgba(255, 99, 132, 1)',
    						'rgba(54, 162, 235, 1)',
    						'rgba(255, 206, 86, 1)',
    						'rgba(75, 192, 192, 1)',
    						'rgba(153, 102, 255, 1)',
    						'rgba(255, 159, 64, 1)'
    					],
    					borderWidth: 0.5 // [막대 테두리 굵기 설정]
    				}]
    			},
    			options: {
    				responsive: false,
    			    elements: {
    			    	   point: {
    			    	   radius: 0,
    			    	  },
    			    },
    				scales: {
    				}
    			}
    		});
    	};
</script>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</body>
	
</html>
