<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>같이먹을래 - 회원가입</title>
<!-- 
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
<script crossorigin src="https://unpkg.com/react@17/umd/react.production.min.js"></script>
<script crossorigin src="https://unpkg.com/react-dom@17/umd/react-dom.production.min.js"></script>
 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member-enroll.css"/>
</head>
<body>
<div id="react-practice"></div>
<div id="content-wrapper">
  <h1>신규 회원 가입</h1>
  <div id="form-wrapper"></div>
  <!-- 
  <form action="${pageContext.request.contextPath }/member/memberEnroll" method="POST" id="enrollFrm" name="enrollFrm">

    <input type="text" name="id" placeholder="사용할 아이디를 입력해주세요" id="id"/>

    <input type="password" name="password" id="password" placeholder="비밀번호는 (조건조건)" />

    <input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호를 다시 입력해주세요"/>
    <br />
    <input type="text" name="name" id="name" placeholder="사용할 닉네임을 적어주세요" />
    <br />
    <input type="text" name="phone" id="phone" placeholder="전화번호를 입력해주세요">
    <br />
    <input type="email" name="email" id="email" placeholder="이메일을 입력해주세요" />
    <br />
    <input type="radio" name="gender" id="genderMale" value="M" required="required"/>
    <input type="radio" name="gender" id="genderFemale" value="F" required="required" />
    <br />
    <input type="number" name="bornAt" id="bornAt" placeholder="생년도를 입력해주세요"/>
    <br />
    <span>포인트는 가입시 1000</span>
    <br />
    <button>가입하기</button>
  </form>
   -->
  <!-- <script type="text/javascript" src="/eatwith/resources/js/app-config.js"></script> -->
  <script type="text/javascript" src="/eatwith/resources/js/bundle/member-enroll.js"></script>
  
  
  


</div>  

</body>
</html>