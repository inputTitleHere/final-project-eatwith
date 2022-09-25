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
    cursor : pointer;
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
    cursor : pointer;
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
                			성별 제한이 없습니다.<input type="hidden" id="genderRestriction" value="A">
                		</c:if>
                		<c:if test="${not empty gather.genderRestriction}">
                			<c:if test="${gather.genderRestriction eq 'F'}">
                				<input type="hidden" id="genderRestriction" value="F">
                				<strong>여자</strong>만 참여 가능합니다.
                			</c:if>
    						<c:if test="${gather.genderRestriction eq 'M'}">
    							<input type="hidden" id="genderRestriction" value="M">
    							<strong>남자</strong>만 참여 가능합니다.
    						</c:if>
                		</c:if>
                	</td>
                </tr>
                <tr>
                    <th>모임 인원</th>
                    <!-- 모임 인원 불러올때 +1해주기-->
                    <td>
                        <sec:authorize access="isAnonymous()">
                        <input type="hidden" name="gatherNo" id="gatherNo" value="${gather.no}" />
                        <span id="countNow">${count+n}</span>/<span id="">${gather.count+1}</span>
                        <button type="button" id="gatherIn" onclick="gatherIn()">참여하기</button>
                        <script>
                        	var n=0;
                        	const gatherIn=()=>{
                        		alert("로그인을 하고 이용해주세요.");
                        	}
                        </script>
                        </sec:authorize>
                       	<sec:authorize access="isAuthenticated()">
                       	<sec:authentication property="principal.no" var="loginMember"/>
                  		<input type="hidden" name="loginMember" id="loginMember" value="${loginMember}"/>
                       	<input type="hidden" name="gatherNo" id="gatherNo" value="${gather.no}" />
                        <span id="countNow">${count+n}</span>/<span id="">${gather.count+1}</span>
						<button type="button" id="gatherIn" onclick="gatherIn()">참여하기</button>
                        <button type="button" id=gatherOut onclick="gatherOut()">참여취소</button>
                       	
                       	</sec:authorize>
                        <!-- applyGather form작성하기 -->

                        <form action="<%=request.getContextPath() %>/gather/applyGather?no=${gather.no}" 
                        method="post" name="applyGatherFrm">
                        	<input type="hidden" name="gatherNo" value="${gather.no}" />
                        	<sec:authorize access="isAuthenticated()">
                        	<sec:authentication property="principal.no" var="loginMember"/>
                        	<input type="hidden" name="userNo" id="login" value="${loginMember}"/>
                        	</sec:authorize>

        				</form>
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
                        <sec:authorize access="isAuthenticated()">
                    	<sec:authentication property="principal" var="loginMember"/>
                    	<c:if test="${gather.userNo eq loginMember.no}">
                        <button type="button" id="inChat" onclick="goCheck()">모임 인원체크하기</button><br>
                        <form action="<%=request.getContextPath() %>/gather/checkLeader?no+${gather.no}" method="GET" name="goCheckFrm">
                        	<input type="hidden" name="gatherNo" value="${gather.no}">
                        </form>
                        </c:if>
                        <button type="button" id="writeReview"
                        onclick="writeReview()">리뷰 작성하러 가기</button>
                        <form action="<%=request.getContextPath() %>/review/writeReview" 
                        method="POST" name="writeReviewFrm">
                        <input type="hidden" name="gatherNo" value="${gather.no}">
                        </form>
                        </sec:authorize>
                    </td>
                </tr>
                <script>
                	const goCheck=()=>{
                		document.goCheckFrm.submit();
                	}
                
                console.log(${gather.no});
                	const writeReview=()=>{
                		document.writeReviewFrm.submit();
                	}
                </script>
                <tr>
                    <th></th>
                    <td>
                    <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal" var="loginMember"/>
                    <c:if test="${gather.userNo eq loginMember.no}">
                    <br>
                        <button type="button" id="gatherUpdate" onclick="location.href='<%=request.getContextPath()%>/gather/gatherUpdate?no=${gather.no}';">수정</button>
                         <button type="button" id="gatherDelete" onclick="deleteGather()">삭제</button>
                    </c:if>
                    </sec:authorize>
                    </td>
                </tr>
            </tbody>
        </table>
        <form action="<%=request.getContextPath() %>/gather/gatherDelete?no=${gather.no}" 
        method="post" name="gatherDeleteFrm">
        </form>
    </div>
    <script>
	    document.getElementById("gatherIn").style.display="inline";
	    document.getElementById("gatherOut").style.display="none";
	    const gatherNo=document.querySelector('#gatherNo').value;
	    const loginMember=document.querySelector('#loginMember').value;
		//참여하기 버튼 디스플레이 설정
		window.onload=function(){
			$.ajax({
				url:"${pageContext.request.contextPath}/gather/chkGatherIn",
				method:"POST",
				data:{
					"gatherNo":gatherNo,
					"loginMember":loginMember
				},
				success(response){
					console.log(response);
					if(response==0){
	       		        document.getElementById("gatherIn").style.display="inline";
	       		        document.getElementById("gatherOut").style.display="none";
					}else{
                    document.getElementById("gatherIn").style.display="none";
                    document.getElementById("gatherOut").style.display="inline";
					}
				},
				error:console.log
			})
		}

		//참여하기 비동기제출
		function gatherInAjax(gatherNo,loginMember){
	    	console.log(gatherNo,loginMember);
       		$.ajax({
       			url:"${pageContext.request.contextPath}/gather/applyGather",
       			method:"POST",
       			data:{
       				"gatherNo":gatherNo,
       				"loginMember":loginMember
       			},
       			success(response){
       				console.log(response);
                       document.getElementById("gatherIn").style.display="none";
                       document.getElementById("gatherOut").style.display="inline";
                       document.querySelector('#countNow').innerText=${count+1};
       			},
       			error:console.log
       		})
	    }
    
	    <sec:authorize access="isAuthenticated()">
	    var n=0;
	    const gatherIn=()=>{
		    const genderRestriction = document.querySelector('#genderRestriction').value;
		    
		    console.log(genderRestriction);
	    	if(confirm("모임 참여시 200포인트가 차감됩니다.")){
	        	if(loginMember==${gather.userNo}){
	        		alert('이미 참가한 모임입니다.');
	        	}
	        	else{
	        		if(genderRestriction=='A'){
	        			if(${gather.ageRestrictionTop}==0){
	        				gatherInAjax(gatherNo,loginMember);
	        			}
	        			else if(${gather.ageRestrictionBottom}<=${2023-member.bornAt}&&${gather.ageRestrictionTop}>=${2023-member.bornAt}){
	        				gatherInAjax(gatherNo,loginMember);
	        			}
	        			else{
	        				alert('조건이 맞지 않아 참여할 수 없습니다.');
	        			}
	        		}
	        		else if(genderRestriction=='${member.gender}'){
	        			if(${gather.ageRestrictionTop}==0){
	        				gatherInAjax(gatherNo,loginMember);
	        			}
	        			else if(${gather.ageRestrictionBottom}<=${2023-member.bornAt}&&${gather.ageRestrictionTop}>=${2023-member.bornAt}){
	        				gatherInAjax(gatherNo,loginMember);
	        			}
	        			else{
	        				alert('조건이 맞지 않아 참여할 수 없습니다.');
	        			}
	        		}
	        		else{
	        			alert('조건이 맞지 않아 참여할 수 없습니다.');
	        		}

	        	}
	    	}
	    }
	    //참여취소
	    const gatherOut=()=>{
		    const gatherNo=document.querySelector('#gatherNo').value;
		    const loginMember=document.querySelector('#loginMember').value;
		    
		    if(confirm("참여를 취소하시겠습니까?")){
	       		$.ajax({
	       			url:"${pageContext.request.contextPath}/gather/cancelGather",
	       			method:"POST",
	       			data:{
	       				"gatherNo":gatherNo,
	       				"loginMember":loginMember
	       			},
	       			success(response){
	       				console.log(response);
		       		        document.getElementById("gatherIn").style.display="inline";
		       		        document.getElementById("gatherOut").style.display="none";
	                        document.querySelector('#countNow').innerText=${count-1};
	       			},
	       			error:console.log
	       		})
		    }
	    }
	    </sec:authorize>
        const deleteGather=()=>{
        	if(confirm("정말 모임을 삭제하시겠습니까?")){
        		document.gatherDeleteFrm.submit();
        	}
        }
        
    </script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>