<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 권한체크용, form(후에 header.jsp) -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/root.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/header.css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath }/resources/image/favicon.ico">

	<!-- header 생성 : 09/06 임규완-->

	<header>
		<!-- 전체 해더 메뉴 담는 div -->
		<div class="header-container">
		
			<!-- 로그인 여부 관계 없이 공통 제공 사항
				1) 로고 : index 연결
				2) 검색 바 : 기능 x
				 -->
			<div class="common-container">
				<img id="logo-image" src='${pageContext.request.contextPath}/resources/image/eatwith-banner.png'
					alt="MemberEnrollHeader.jsx확인 바람" height='100px' onclick='location.href="${pageContext.request.contextPath}/"' />
				<form id="searchform" action="${pageContext.request.contextPath}/search/searchResult" method="GET">
					<button class="btn-search" type="button" onclick = "search()">검색</button>
					<input type="text" name="searchWord" placeholder="검색 바 임시" value = '' id="searchWord"/>
					<input type="hidden" name="searchType" value = "recent" id="searchWord"/>
				</form>
			</div>

			<!-- 비 로그인 시 제공 메뉴 
				 1) 공지사항 : 페이지 연결 x
				 2) 로그인 : 로그인 창으로 연결
				 3) 회원가입 : 회원가입 페이지로 연결-->
			<sec:authorize access="isAnonymous()">
				<div class="nonlogin-container">
				<ul>
					<li><a href="${pageContext.request.contextPath}/">공지사항</a></li>
					<li><a href="${pageContext.request.contextPath}/member/memberLogin">로그인</a></li>
					<li><a href="${pageContext.request.contextPath}/member/memberEnroll">회원가입</a></li>
				</ul>
				</div>
			</sec:authorize>

			<!-- 로그인 시 제공 메뉴 
				 1) 유저 이름 노출
				 2) 공지사항 : 페이지 연결 x
				 3) 마이페이지 / 관리자 페이지 : 페이지 연결 x
				 4) 로그아웃 : 메인으로 redirect-->
			<sec:authorize access="isAuthenticated()">
				<div class="login-container">
					<span> <sec:authentication property="principal.name" />님, 안녕하세요 </span>
					<img id="notice-image" src='${pageContext.request.contextPath}/resources/image/notification_img.png'
						alt="" onclick='location.href="${pageContext.request.contextPath}/"' />			
					<ul>
						<li><a href="${pageContext.request.contextPath}/notice/noticeList">공지사항</a></li>
						<sec:authorize access="hasRole('USER')">
							<li>
								<a href="${pageContext.request.contextPath}/mypage">마이페이지<span id="notification-count"></span>
								</a>
							</li>
						</sec:authorize>
						<sec:authorize access="hasRole('ADMIN')">
							<li><a href="${pageContext.request.contextPath}/member/memberEnroll">관리자페이지</a></li>
						</sec:authorize>
						<li>
							<form action="${pageContext.request.contextPath}/member/memberLogout" method="post">
								<button class="btn btn-logout" type="submit">로그아웃</button>
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}">
							</form>						
						</li>
					</ul>
				</div>
			</sec:authorize>
		</div>
		
		<sec:authorize access="hasRole('USER')">
			<script>
				window.addEventListener('load',()=>{
					// load notification count;
					$.ajax({
						url:'${pageContext.request.contextPath}/notification/getNotificationCount',
						method:"GET",
						success(response){
							console.log(response);
							const notiCnt = document.querySelector("#notification-count");
							notiCnt.innerHTML = response;
						},
						error:console.log
					})
				})
			</script>
		</sec:authorize>
	
		<script>
		
	 	const search=()=>{
//    		const searchBar = document.querySelector("#searchBar").value;
//    		document.querySelector("#searchWord").value = searchBar;
//    		console.log(searchWord);
//   		console.log('1234');
    		document.querySelector('#searchform').submit();
    	}
		</script>
		
	</header>
