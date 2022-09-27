<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
	<link rel="shortcut icon"
		href="${pageContext.request.contextPath }/resources/image/favicon.ico">
	<link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css'/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberFind.css" />

</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div>
        <section>
        <h2>아이디 찾기</h2>
	        <form id="findIdFrm">
	            <table id="tbl-findId">
	                <thead>
	                    <tr>
	                        <th>이름</th>
	                        <td><input type="text" id="name" placeholder="이름을 입력해주세요" name="name"></td>
	                    </tr>
	                    <tr>
	                        <th>전화번호</th>
	                        <td><input type="text" id="phone" placeholder="전화번호를 입력해주세요" name="phone"></td>
	                    </tr>
	                </thead>
	            </table>
	            <input type="submit" value="아이디 찾기" id="btn1">
	            <div id="findId"></div>
	        </form>
        </section>
    </div>
	<script>
	document.querySelector("#findIdFrm").addEventListener('submit', (e) => {
		e.preventDefault();
		console.log("버튼클릭됨!!!");
		const name = document.querySelector("#name").value;
		const phone = document.querySelector("#phone").value;
		const findId = document.querySelector("#findId");
		$.ajax({
			url:"${pageContext.request.contextPath}/member/memberFindById",
			method:"GET",
			data:{"name":name, "phone":phone},
			success(response){
				console.log(response);
				const {id} = response;
				findId.innerHTML = `
				<span>회원님의 아이디는 \${id} 입니다.</span>
				`;
			},
			error:console.log
		});
		
	});
	</script>
	
	<div>
        <section>
            <h2>비밀번호 찾기</h2>
				<form id="resetPwFrm">
		            <table>
		                <thead>
		                    <tr>
		                        <th>아이디</th>
		                        <td><input type="text" id="id" placeholder="아이디를 입력해주세요" name="id"></td>
		                    </tr>
		                    <tr>
		                        <th>이름</th>
		                        <td><input type="text" id="name2" placeholder="이름을 입력해주세요" name="name"></td>
		                    </tr>
		                    <tr>
		                        <th>이메일</th>
		                        <td><input type="text" id="email" placeholder="이메일을 입력해주세요" name="email"></td>
		                    </tr>
		                </thead>
		            </table>
					<input type="submit" value="임시 비밀번호 발급받기" id="btn1">
	            	<div id="resetPw"></div>		                    
				</form>
        </section>
	</div>
	
	<script>
	document.querySelector("#resetPwFrm").addEventListener('submit', (e) => {
		e.preventDefault();
		console.log("비밀번호 초기화버튼!!!");
		const id = document.querySelector("#id").value;
		const name2 = document.querySelector("#name2").value;
		const email = document.querySelector("#email").value;
		const resetPw = document.querySelector("#resetPw");
		$.ajax({
			url:"${pageContext.request.contextPath}/member/memberResetPassword",
			method:"GET",
			data:{"id":id, "name":name2, "email":email},
			success(response){
				console.log(response);
				const {password} = response;
				resetPw.innerHTML = `
				<span>회원님의 임시 비밀번호는 \${password} 입니다.</span>
				`;
			},
			error:console.log
		});
	})
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>