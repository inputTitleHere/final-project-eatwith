<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<style>
body {
	background-color: #F0EBEC;
	text-align: center;
}
h2 {
	border-bottom: 1px gray solid;
	padding-bottom: 10px;
	width: 500px;
	display: flex;
	position: relative;
	justify-content: space-around;
	margin-inline: auto;
	margin-bottom: 20px;
	font-size: 30px;
}
th{
	text-align: left;
	width: 125px;
	font-weight: bold;
}
table{
	border-spacing: 10px;
	margin: 10px auto;
}
#findIdFrm {
	margin: 0 auto;
}
#btn1 {
	width: 400px;
	height: 40px;
	background-color: #3A3C68;
	color: white;
	font-weight: bold;
	padding: 1px 0;
}
#findId span {
	color: red;
	margin: 15px auto;
	font-weight: bold;
}
#findId {
	margin-top: 30px;
}
#resetPw span {
	color: red;
	margin: 15px auto;
	font-weight: bold;
}
#resetPw {
	margin-top: 30px;
}
input {
	width: 250px;
	height: 25px;
	font-size: 12px;
}
</style>
</head>
<body>
<br />
<br />
<br />
	<div>
        <section>
        <h2>아이디 찾기</h2>
	        <form id="findIdFrm">
	            <table id="tbl-findId">
	                <thead>
	                    <tr>
	                        <th>이름</th>
	                        <td><input type="text" id="name" placeholder="이름을 입력해주세요" name="name" value="홍길동"></td>
	                    </tr>
	                    <tr>
	                        <th>전화번호</th>
	                        <td><input type="text" id="phone" placeholder="전화번호를 입력해주세요" name="phone" value="01012345678"></td>
	                    </tr>
	                </thead>
	            </table>
	            <input type="submit" value="아이디 찾기" id="btn1">
	            <div id="findId"></div>
	        </form>
        </section>
    </div>
    <br /><br />
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
		                        <td><input type="text" id="id" placeholder="아이디를 입력해주세요" name="id" value="honggd"></td>
		                    </tr>
		                    <tr>
		                        <th>이름</th>
		                        <td><input type="text" id="name2" placeholder="이름을 입력해주세요" name="name" value="홍길동"></td>
		                    </tr>
		                    <tr>
		                        <th>이메일</th>
		                        <td><input type="text" id="email" placeholder="이메일을 입력해주세요" name="email" value="honggd@mail.com"></td>
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
</body>
</html>