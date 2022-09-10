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
    font-size:18px;
}
td{
    padding-bottom: 20px;
    width: 745px;
    font-size:18px;
    
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
#title{
	font-size:24px;
	font-weight:bold;
}
.gatherRes{
	padding: 5px 0px 5px 0px;
}
</style>
</head>
<body bgcolor="#F0EBEC">
    <div id="container">
        <table>
            <thead>
                <td colspan="2" name="title" id="title" >${gatherD.title}<hr></td>
            </thead>
            <tbody>
                <tr>
                    <th>
                        모임 장소<br><br><br>
                    </th>
                    <td>
                        <span class="gatherRes"><strong>${gatherD.name}</strong></span><br>
                        <span class="gatherRes">${gatherD.type}</span><br>
                        <span class="gatherRes">${gatherD.locaName}</span>
                    </td>
                </tr>
                <tr>
                    <th>모임 인원</th>
                    <!-- 모임 인원 불러올때 +1해주기-->
                    <td>
                        <span id="countNow">0</span>/<span id="">${gather.count+1}</span> 
                        <button type="button" id="gatherIn" onclick="gatherIn()">참여하기</button>
                        <button type="button" id=gatherOut onclick="gatherOut()">참여취소</button>
                        <!-- applyGather form작성하기 -->
                    </td>
                </tr>
                <tr>
                	<th>나이제한</th>
                	<td>
                		<c:if test="${gather.ageRestrictionTop eq '0'}">
                		나이 제한이 없습니다.
                		</c:if>
                		<c:if test="${gather.ageRestrictionTop ne '0'}">
                		<span>${gather.ageRestrictionBottom}</span> ~ <span>${gather.ageRestrictionTop}</span>
                		</c:if>
                	</td>
                </tr>
                <tr>
                	<th>성별제한</th>
                	<td>
                		<c:if test="${empty gather.genderRestriction}">
                			성별 제한이 없습니다.
                		</c:if>
                		<c:if test="${not empty gather.genderRestriction}">
                			<c:if test="${gather.genderRestriction eq 'F'}">
                				<strong>여자</strong>만 참여 가능합니다.
                			</c:if>
    						<c:if test="${gather.genderRestriction eq 'M'}">
    							<strong>남자</strong>만 참여 가능합니다.
    						</c:if>
                		</c:if>
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
                        <button type="button" id="gatherUpdate" 
                        onclick="location.href='<%=request.getContextPath()%>/gather/gatherUpdate?no=${gather.no}';">수정</button>
                         <button type="button" id="gatherDelete" onclick="deleteGather()">삭제</button>
                    </td>
                </tr>
            </tbody>
        </table>
        <form action="<%=request.getContextPath() %>/gather/gatherDelete?no=${gather.no}" method="post" name="gatherDeleteFrm">
        </form>
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
            document.getElementById("countNow").value+=1;
        }
        const gatherOut=()=>{
            document.getElementById("gatherIn").style.display="inline";
            document.getElementById("gatherOut").style.display="none";
            document.getElementById("inChat").style.display="none";
            document.getElementById("writeReview").style.display="none";
        }
        const deleteGather=()=>{
        	if(confirm("정말 모임을 삭제하시겠습니까?")){
        		document.gatherDeleteFrm.submit();
        	}
        }
        
    </script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>