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
			width: 90%;
			height: auto;
			margin: 20px;
			padding: 10px;
			border: 1px solid #000000;
			border-radius: 10px;
			background-color: #eeeeee;
			left: 0;
			display: block;
		}
div#restContainer{
	width: 100%;
}		

#gatherChart{
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
			border: 1px solid #000000;
			border-radius: 10px;
			background-color: #eeeeee;
			left: 0;
			display: block;
			padding: 20px;
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
	display:inlne;
	text-align: left;
    justify-content: left;
    padding-left:22px;
    font-family: var(--short-font);
    font-size: 30px;  
}
h1{
padding-top:30px;
}
section{
	width:100%;
	background-color: rgb(240, 235, 236);
}
div#contents-container{
	width:950px;
	margin : 0 auto;
	border-radius: 10px;
	border: 2px solid;
	background-color: white;
	padding: 20px 0px;
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
div#rest-info{
	display:flex;
	text-align: center;
    justify-content: center;
    align-items: center;
    height:400px;
}
div#middle-info{
	border-left: 4px solid var(--indigo-blue);
	border-right: 4px solid var(--indigo-blue);
}
div#todayGather{
	display: flex;
	font-family: var(--our-font);
	font-size: 18px;
	margin-left: 20px;
}
div#todayGather div{
	padding : 0px 15px;
}
</style>

	</head>
	<body>

		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section>
<div id="contents-container">
	<!--차트가 그려질 부분-->
	<h1>사이트 현황</h1>
	<div id="todayGather">
	<div id="activeGather">
	현재 활동 중인 모임  : ${nowGather}
	</div>
	<div id="middle-info">모임 참여 회원 수 : ${todayGather}</div>
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
<h2>가게 만족도</h2>
<div id="rest-info">
	<div id="restContainer">
		<canvas id="restaurantChart"></canvas>
	</div>
	<div id="plus-box">
		<canvas id="gatherRatioChart"></canvas>
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
</div>
</section>
    <script>

    	window.onload = function() {
    		console.log("");
    		console.log("[window onload] : [start]");
    		console.log("");
  
    		drawRestaurant();
    		drawGather();
    		drawMember();
    		drawGatherRatio();	
    	};


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
    		

    		var ctx = document.getElementById('restaurantChart').getContext('2d');
    		var myChart = new Chart(ctx, {
    			type: 'bar', 
    			data: {
    				labels: ['평점', '맛', '가격', '서비스'],
    				datasets: [{
    					label: '등록가게 고객 만족도', 
    					data: [overall, taste, price, service],
    					backgroundColor: [ 
    						'rgba(255, 99, 132, 0.8)',
    						'rgba(54, 162, 235, 0.8)',
    						'rgba(255, 206, 86, 0.8)',
    						'rgba(75, 192, 192, 0.8)',
    						'rgba(153, 102, 255, 0.8)',
    						'rgba(255, 159, 64, 0.8)'
    					],
    					borderColor: [
    						'rgba(255, 99, 132, 0.8)',
    						'rgba(54, 162, 235, 0.8)',
    						'rgba(255, 206, 86, 0.8)',
    						'rgba(75, 192, 192, 0.8)',
    						'rgba(153, 102, 255, 0.8)',
    						'rgba(255, 159, 64, 0.8)'
    					],
    					borderWidth: 0.5
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
    		
    		var ctx = document.getElementById('gatherChart').getContext('2d');
    		var myChart = new Chart(ctx, {
    			type: 'line', 
    			data: {
    				labels: day,
    				datasets: [{
    					label: '모임현환',
    					data: count,
    					fill: true,
    					backgroundColor: [
    						'rgba(129, 166, 211, 1)'
    					],
    					borderColor: [
    						'rgba(129, 166, 211, 1)'
    					],
    					borderWidth: 0.5
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
	    
    		var ctx = document.getElementById('memberChart').getContext('2d');
    		var myChart = new Chart(ctx, {
    			type: 'line',
    			data: {
    				labels: dayo,
    				datasets: [{
    					label: '이용자 가입 현황',
    					data: counto,
    					fill: true,
    					backgroundColor: [
    						'rgba(129, 166, 211, 1)'
    					],
    					borderColor: [
    						'rgba(129, 166, 211, 1)'    					],
    					fillColor: [
    						'rgba(129, 166, 211, 1)'
    					],
    					borderWidth: 0.5
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
    		
    		var ctx = document.getElementById('gatherRatioChart').getContext('2d');
    		var myChart = new Chart(ctx, {
    			type: 'pie',
    			data: {
    				labels: name ,
    				datasets: [{
    					label: '지역별 모임 현황',
    					data: num,
    					backgroundColor: [
    						'rgba(255, 99, 132, 0.2)',
    						'rgba(54, 162, 235, 0.2)',
    						'rgba(255, 206, 86, 0.2)',
    						'rgba(75, 192, 192, 0.2)',
    						'rgba(153, 102, 255, 0.2)',
    						'rgba(255, 159, 64, 0.2)'
    					],
    					borderColor: [
    						'rgba(255, 99, 132, 1)',
    						'rgba(54, 162, 235, 1)',
    						'rgba(255, 206, 86, 1)',
    						'rgba(75, 192, 192, 1)',
    						'rgba(153, 102, 255, 1)',
    						'rgba(255, 159, 64, 1)'
    					],
    					borderWidth: 0.5
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
