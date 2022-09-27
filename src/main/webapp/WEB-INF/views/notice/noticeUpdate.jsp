<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>
  <!-- 서머노트를 위해 추가해야할 부분 -->
  <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
  <script src="${pageContext.request.contextPath}/resources/summernote/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
  <!--  -->
<style>
div#totalcontent{
width: 900px;
height: 700px;
margin: 0 auto;
    border: 4px solid #3a3c68;
    border-radius: 10px;
    background-color: #fefefe;
    margin: 20px auto;
    padding: 10px;
}
.note-editor note-frame{
margin: 0 auto;
}
</style>

<div id="totalcontent">
		<c:set var = "updatedAt" value = "${notice.updatedAt}" />
		<c:set var = "deletedAt" value = "${notice.deletedAt}" />
		<c:if test="${not empty updatedAt}">
			<div>최종 수정일(수정있음) : ${notice.updatedAt}</div>
		</c:if>
		<c:if test="${empty updatedAt}">
			<div>최종 수정일(수정없음) : ${notice.noticeDate}</div>
		</c:if>
	<form id="noticeUpdate" name="noticeUpdate" 
			action="${pageContext.request.contextPath}/notice/noticeUpdate" 
			method="post"
			enctype="multipart/form-data" >
					<input type="hidden" name="noticeNo" value="${notice.noticeNo}"> 
					<input type="hidden" name="deletedAt" value="${notice.deletedAt}" />
					<input type="text" name="noticeTitle" value="${notice.noticeTitle}" />
				  	<textarea class="summernote" name="noticeContents">
				  		${notice.noticeContents}</textarea>  
		<input type="submit" class="btn btn-outline-success" value="수정" >
	</form>						
</div>

	<nav>
		${pagebar}
	</nav>


<script>
$('.summernote').summernote({
	  height: 150,
	  lang: "ko-KR",
        width: '800px',
        height: '480px'
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
