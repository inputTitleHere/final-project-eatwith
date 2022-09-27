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
					<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css" />
			<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">
			<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	
					<title>공지사항 작성</title>
	</head>	
		
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>
  <!-- 서머노트를 위해 추가해야할 부분 -->
  <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
  <script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
  <!--  -->
<style>
body{
	width:100%;
	background-color: rgb(240, 235, 236);
}
section{
    position: relative;
    width: 800px;
    height: 450px;
    border: 4px solid #3a3c68;
    border-radius: 10px;
    background-color: #fefefe;
    margin: 20px auto;
    padding: 10px;
}
div#summernote-editor{
	width: 100%;
	hight : 250px;
	margin: 0 auto;
}
form#notice-insert{
	margin: 0 auto;
}
input#noticeTitle{
	width: 200px;
}
h1{
}
button.btn{
	border-radius: 10px;
	border: 3px solid var(--jjin-pink);
	padding: 10px;
	font-family:var(--short-font);
	font-size:18px;
}
#btn-wrapper{
	margin: 10px auto;
	display: flex;
	justify-content: center;
	align-item: center;
}
</style>

<section id="notice-container" class="container">
<h1>게시글 작성하기</h1>
<form action="${pageContext.request.contextPath
	}/notice/noticeInsert" method="post" enctype="multipart/form-data"
	id="notice-insert">
	
<input type="text" class="form-control" placeholder="제목" 
	name="noticeTitle" id="noticeTitle" required>

<div id="summernote-editor">
  <textarea class="summernote" name="noticeContents"></textarea>
</div>
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}">
	<div id="btn-wrapper">
	<button type="submit" class="btn">저장</button>
</div>
</form>
</section>


<script>

$('.summernote').summernote({
	  height: 150,
	  lang: "ko-KR",
      width: '800px',
      height: '300px'
	});
	
   
/*
 * 이미지 첨부
 
 var setting = {
	        height : 300,
	        minHeight : null,
	        maxHeight : null,
	        focus : true,
	        lang : 'ko-KR',
	        callbacks : { 
	        	onImageUpload : function(files, editor, welEditable) {
	        for (var i = files.length - 1; i >= 0; i--) {
	        uploadSummernoteImageFile(files[i],
	        this);
	        		}
	        	}
	        }
	     };
 
 function uploadSummernoteImageFile(file, el) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "uploadSummernoteImageFile",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				$(el).summernote('editor.insertImage', data.url);
			}
		});
	}
 
 */


</script>
 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
