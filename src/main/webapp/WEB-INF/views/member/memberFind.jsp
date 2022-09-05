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
</head>
<body>
	<div>
        <section>
        <form action="${pageContext.request.contextPath}/member/memberFindId">
            <h2>아이디 찾기</h2>
            <hr>
            <table id="tbl-findId">
                <thead>
                    <tr>
                        <th>이름</th>
                        <td><input type="text" placeholder="이름을 입력해주세요"></td><br>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td><input type="text" placeholder="전화번호를 입력해주세요"></td>
                    </tr>
                </thead>
            </table>
            <input type="button" value="아이디 찾기" >
            <div id="findId"></div>
            <!-- <button>아이디찾기1</button> -->
        </form>
        </section>
        
        <section id="findPassword">
            <h2>비밀번호 찾기</h2>
            <hr>
            <table>
                <thead>
                    <tr>
                        <th>아이디</th>
                        <td><input type="text" placeholder="아이디를 입력해주세요"></td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td><input type="text" placeholder="이름을 입력해주세요"></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td><input type="text" placeholder="이메일을 입력해주세요"></td>
                    </tr>
                    
                </thead>
                <tbody></tbody>
            </table>
        </section>
    </div>
    
	<script>
	const myId = document.querySelector("#findId");
	document.querySelector("#btn1").addEventListener('click', (e) => {
		e.preventDefault();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/member/memberFindId",
			type:"GET",
			success(response){
				console.log(response),
				myId.InnerHTML = html;
			},
			error:console.log
		});
		
	});
	</script>
</body>
</html>