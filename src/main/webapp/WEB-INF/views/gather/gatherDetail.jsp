<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="<%=request.getContextPath()%>/resources/js/jquery-3.6.0.js"></script>
<title>모임 상세보기</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/root.css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath }/resources/image/favicon.ico">
<style>
#container{
    display: flex;
    justify-content: center;
    width: 1000px;
    font-size: 18px;
	left:0;
	right:0;
	margin:auto;
	padding:100px;
}
table{
    background-color: white;
    margin: 20px;
    padding: 30px;
}
th{
    padding-right: 50px;
    padding-bottom: 20px;
    width: 100px;
}
td{
    padding-bottom: 20px;
    width: 745px;
}
#gatherTitle{
    width: 900px;
    font-weight: bold;
    font-size: 24px;
}
#gatherIn{
    background-color: #DC948A;
    border: 0;
    color: white;
    margin-top: 10px;
    margin-left: 20px;
    width: 80px;
    height: 30px;
    font-size: 16px;
}
#gatherOut{
    background-color: #ECC7C5;
    border: 0;
    color: black;
    margin-top: 10px;
    margin-left: 20px;
    width: 80px;
    height: 30px;
    font-size: 16px;
}
#inChat, #writeReview{
    background-color: #DC948A;
    border: 0;
    color: white;
    margin-top: 10px;
    margin-left: 20px;
    width: 500px;
    height: 50px;
    font-size: 20px;
}
#gatherUpdate,#gatherDelete{
    background-color: #DC948A;
    border: 0;
    color: white;
    margin-top: 10px;
    margin-left: 40px;
    width: 200px;
    height: 40px;
    font-size: 16px;
}
</style>
</head>
<body bgcolor="#F0EBEC">
    <div id="container">
        <table>
            <thead>
                <td colspan="2" name="title" id="title" ><p>${gather.title}</p><hr></td>
            </thead>
            <tbody>
                <tr>
                    <th>
                        모임 장소<br><br><br>
                    </th>
                    <td>
                        ${gather.restaurantNo}<br>${gather.foodCode}<br>${gather.districtCode}
                    </td>
                </tr>
                <tr>
                    <th>모임 인원</th>
                    <td>
                        <span id="countNow">0</span>/<span id="">${gather.count}</span> 
                        <button type="button" id="gatherIn" onclick="gatherIn()">참여하기</button>
                        <button type="button" id=gatherOut onclick="gatherOut()">참여취소</button>
                        <!-- applyGather form작성하기 -->
                    </td>
                </tr>
                <tr>
                    <th>모임 시간</th>
                    <td>${gather.meetDate}</td>
                </tr>
                <tr>
                    <th>모임 설명</th>
                    <td>${gather.content}</td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <br><br><br>
                        <button type="button" id="inChat">모임 채팅방 입장하기</button><br>
                        <button type="button" id="writeReview">리뷰 작성하러 가기</button>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <br>
                        <button type="button" id="gatherUpdate">수정</button> <button type="button" id="gatherDelete">삭제</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <script>
        document.getElementById("gatherOut").style.display="none";
        document.getElementById("inChat").style.display="none";
        document.getElementById("writeReview").style.display="none";

        const gatherIn=()=>{
        	confirm("모임 참여시 200포인트가 차감됩니다.")
            document.getElementById("gatherIn").style.display="none";
            document.getElementById("gatherOut").style.display="inline";
            document.getElementById("inChat").style.display="inline";
            document.getElementById("writeReview").style.display="inline";
        }
        const gatherOut=()=>{
            document.getElementById("gatherIn").style.display="inline";
            document.getElementById("gatherOut").style.display="none";
            document.getElementById("inChat").style.display="none";
            document.getElementById("writeReview").style.display="none";
        }
    </script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>