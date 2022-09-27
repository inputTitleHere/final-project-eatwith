 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="com.kh.eatwith.member.model.dto.Member" %>
<%@page import="com.kh.eatwith.gather.model.dto.Gather"%>
<%@page import="com.kh.eatwith.gather.model.dto.MemberGather"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="<%=request.getContextPath()%>/resources/js/jquery-3.6.0.js"></script>
<title>모임 참여여부 체크</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/root.css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath }/resources/image/favicon.ico">
<style>
*{
	font-family:var(--our-font);
}
#container{
    display: flex;
    justify-content: center;
    width: 1000px;
    font-size: 18px;
	left:0;
	right:0;
margin:20px auto;
padding:0px;
}
table{
    background-color: white;
    margin: 20px;
    padding: 30px;
   	border:4px solid var(--indigo-blue);
	border-radius:10px;
	min-height:800px;
}
tbody{
	display:block;
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
    font-size:20px;
    
}
#gatherTitle{
    width: 900px;
    font-weight: bold;
    font-size: 24px;
}
.gatherIn{
    background-color: #DC948A;
    border: 0;
    color: white;
    margin-top: 10px;
    margin-left: 20px;
    width: 100px;
    height: 40px;
    font-size: 20px;
    cursor : pointer;
    border:0;
	border-radius:10px;
}
#name{
	font-weight:bold;
	padding-left:20px;
	font-size:24px;
}
#gender,#age{
	font-size:24px;
}
#expl{
	padding-left:20px;
	font-size:20px;
}
#count{
	font-weight:bold;
}
.gatherOut{
    background-color: var(--yeon-pink);
    border: 0;
    color: black;
    margin-top: 10px;
    margin-left: 20px;
    width: 100px;
    height: 40px;
    font-size: 20px;
    cursor : pointer;
    border:0;
	border-radius:10px;
}
#title{
	font-size:30px;
	font-weight:bold;
	font-family:var(--short-font);
}
</style>
</head>
<body bgcolor="#F0EBEC">
    <div id="container">
        <table>
            <thead>
                <td colspan="2" name="title" id="title" >모임 참여인원 목록<hr></td>
            </thead>
            <tbody>
            	<tr>
            		<td id="name">총 인원 <span id="count">${check.size()}</span>명 
            		<input type="hidden" id="gatherNo" name="gatherNo" value="${gatherNo}" />
            		</td>
            	</tr>
            	<tr>
            		<td id="expl">실제 모임에 참여했을 경우 체크 해주세요.<br>모임장이 체크시 회원은 리뷰 작성이 가능합니다.</td>
            	</tr>
               	<c:if test="${not empty check}">
               		<c:forEach items="${check}" var="check" varStatus="status">
               		<div class="each-items">
               		<tr><td>
               			<span id="name">${check.name}</span>
               			<c:if test="${check.gender eq 'M'}">
               			<span id="gender">남자</span>
               			</c:if>
               			<c:if test="${check.gender eq 'F'}">
               			<span id="gender">여자</span>
               			</c:if>
               			<span id="age">${2023-check.bornAt}</span>
               			<input type="hidden" id="userNo${status.index}" name="userNo" value="${check.userNo}" />
               			<input type="hidden" id="checked${status.index}" name="checked" value="${check.checked}" />
               			<span id="checked"><button type=button class="gatherIn" value="${check.userNo}" id="gatherIn${status.index}" display="block">참여확인</button></span>
               			<span id="checked"><button type=button class="gatherOut" value="${check.userNo}" id="gatherOut${status.index}" display="none">불참</button></span>
               		</td></tr>
               		</div>
               		  <script>
     					btnOut=document.querySelector('#gatherOut${status.index}');
       					btnIn=document.querySelector('#gatherIn${status.index}');
       					checked=document.querySelector('#checked${status.index}').value;
       					if(checked=='0'){
       						btnOut.style.display="none";
       					}
       					else{
       						btnIn.style.display="none";
       					}
       					userNo${status.index}=btnIn.value;
       					console.log("userNo["+${status.index}+"] = "+userNo${status.index});

 //    					userNo=document.querySelector('#userNo${status.index}').value;
       					gNo=document.querySelector('#gatherNo').value;
						userNo=userNo${status.index};
						
       					console.log("gNo = "+gNo);
	       				console.log("userNo = "+userNo);
	       				btnIn.onclick=
               				function(){
	       						alert("확실히 참가하였습니까?");
               					$.ajax({
               	    				url:"${pageContext.request.contextPath}/gather/checkLeaderIn",
               	    				method:"POST",
               	    				data:{"userNo":userNo${status.index}, "gNo":gNo
               	    					},
               	    				success(data){
               	    					console.log(data);
               	        				if(data=='1'){
               	        					document.querySelector('#gatherOut${status.index}').style.display="initial";
               	        					document.querySelector('#gatherIn${status.index}').style.display="none";
               	           				}
               	    				},
               	    				error:console.log
               	    			})
               					
               				}
						btnOut.onclick=
           				function(){
       						alert("확실히 불참하였습니까?");
           					$.ajax({
           	    				url:"${pageContext.request.contextPath}/gather/checkLeaderOut",
           	    				method:"POST",
           	    				data:{"userNo":userNo${status.index}, "gNo":gNo
           	    					},
           	    				success(data){
           	    					console.log(data);
           	        				if(data=='1'){
           	        					document.querySelector('#gatherIn${status.index}').style.display="initial";
           	           					document.querySelector('#gatherOut${status.index}').style.display="none";
           	           				}
           	    				},
           	    				error:console.log
           	    			})
           				}


               			</script>
               		</c:forEach>
               	</c:if>
    			<c:if test="${check eq null}">
    				<tr>
    					<td>보여줄 참여 멤버가 없습니다.</td>
    				</tr>
    			</c:if>
            </tbody>
        </table>
    </div>
    <script>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>