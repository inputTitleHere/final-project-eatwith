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
<title>모임 작성하기</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/root.css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath }/resources/image/favicon.ico">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/gather/gatherEnroll.css" />

</head>
<body bgcolor="#F0EBEC">
	<div id="container">
		<form name="gatherEnrollFrm" method="post"
			action="${pageContext.request.contextPath}/gather/gatherEnroll">
			<table>
				<tbody>
					<tr>
						<th>모임 제목<span id="pilsu">*</span>
						</th>
						<td><input type="text" name="title" id="title"
							placeholder="모임 제목을 입력해 주세요."></td>
					</tr>
					<tr>
						<th>모임 장소<span id="pilsu">*</span>
						</th>
						<td><input type="hidden" id="restaurantNo"
							name="restaurantNo" /> <input type="hidden" id="foodCode"
							name="foodCode" /> <input type="hidden" id="districtCode"
							name="districtCode" /> <input type="text" id="findStore"
							name="findStore" placeholder="가게 이름을 입력해주세요.">
						<button type="button" class="openBtn">검색</button>
							<div class="modal hidden">
								<div class="bg"></div>
								<div class="modalBox">
									<!-- 모달창 내부 -->
									<button type="button" class="closeBtn">✖</button>
									<div class="modalContent"></div>
								</div>
							</div></td>
					</tr>
					<script>
						let chkRestaurant = 0;
						const setRestaurant=(e)=>{
							const no=e.target.value;
							const name=e.target.dataset.name;
							const districtName=e.target.dataset.districtName;
							const type = e.target.dataset.type;
							const inputRestaurantNo=document.querySelector('#restaurantNo');
							const restaurantName=document.querySelector('#storeName');        
							const restaurantDistrict=document.querySelector('#storeLocation');
							const restaurantType=document.querySelector('#storeCategory');
							const foodCode=document.querySelector('#foodCode');
							const districtCode=document.querySelector('#districtCode');
							
							restaurantName.innerHTML=name;
							restaurantDistrict.innerHTML=districtName;
							restaurantType.innerHTML=type;
							                    		
							inputRestaurantNo.value=no;
							chkRestaurant=1;
							console.log(inputRestaurantNo);
							
							foodCode.value=e.target.dataset.foodCode;
							districtCode.value=e.target.dataset.districtCode;
							
							document.querySelector(".modal").classList.add("hidden");
						}
					      const open = () => {
					        document.querySelector(".modal").classList.remove("hidden");
					        const searchString = document.querySelector('#findStore').value;
					        if(searchString==""){
					        	alert('검색어를 입력 후 검색해주세요.');
					        	document.querySelector(".modal").classList.add("hidden");
					        }
					        else{
					        $.ajax({
					        	url:"${pageContext.request.contextPath}/restaurant/findRestaurantByName",
					        	method:"GET",
					        	data:{
					        		"searchString":searchString
					        	},
					        	success(response){
					           		console.log(response);
					           		const modalContent=document.querySelector('.modalContent');
					           		const html=response.reduce((merge,item)=>{
					           			const {no,name,districtName,type,foodCode,districtCode}=item;
					           			return merge+`
					           			<li>
					           				<div class="modal-restaurant">
					           					<span class="modal-restaurant-title">\${name}</span>
					           					<span class="modal-restaurant-district">\${districtName}</span>
					        					| <span class="modal-restaurant-type">\${type}</span>
					           					<button type="button" class="selectRestaurant" data-name=\${name} data-district-name=\${districtName} data-type=\${type} data-food-code=\${foodCode} data-district-code=\${districtCode} onclick="setRestaurant(event)" value=\${no}>선택</button>
					           				</div>
					       					<hr />
					           			</li>
					           			`
					           		},'')
					           		const ulHtml=`<ul>\${html}</ul>`
					           		modalContent.innerHTML=ulHtml;
					           		console.log('무언가 일어남',modalContent);
					        	},
					        	error:console.log
					        })
					        	
					        }
					    }

					    const close = () => {
					        document.querySelector(".modal").classList.add("hidden");
					    }

					    document.querySelector(".openBtn").addEventListener("click", open);
					    document.querySelector(".closeBtn").addEventListener("click", close);
					    document.querySelector(".bg").addEventListener("click", close);

						</script>
					<tr>
						<th></th>
						<td><span id="storeName"></span> <br> <span
							id="storeCategory"></span> <br> <span id="storeLocation"></span>
						</td>
					</tr>
					<tr>
						<th>모임인원<span id="pilsu">*</span>
						</th>
						<td>
							<div id="countMem">
								<input type="button" class="count" id="plus" value="+">
								<span id="countMember">1</span> <input type="button"
									class="count" id="minus" value="-">
							</div>
						</td>
					</tr>
					<tr>
						<th>나이제한</th>
						<td>
							<input type="checkbox" id="ageChk" onchange="toggleAge(event)" checked /> 나이제한O &nbsp;&nbsp;
							<input type="number" name="ageRestrictionBottom" id="gatherMin" placeholder="최소나이" disabled> ~ 
							<input type="number" name="ageRestrictionTop" id="gatherMax" placeholder="최대나이" disabled>
						</td>
					</tr>
					<tr>
						<th>성별제한</th>
						<td>
							<input type="checkbox" id="genderChk" onchange="toggleGender(event)" checked/> 성별제한O &nbsp;&nbsp; 
							<input type="radio" name="genderRestriction" value="M" id="gatherGenM" disabled>남
							<input type="radio" name="genderRestriction" value="F" id="gatherGenF" disabled>여
						</td>
					</tr>
					<tr>
						<th>모임시간<span id="pilsu">*</span>
						</th>
						<td><input type="datetime-local" name="meetDate"
							id="gatherTime" onchange="setMinValue()" required></td>
					</tr>
					<tr>
						<th>모임설명<span id="pilsu">*</span><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
						</th>
						<td><textarea name="content" id="gatherContent"
								cols="30" rows="10"
								placeholder="모임 출발 장소, 모임에서 찾는 사람 등 모임에 대한 설명을 적어주세요." required></textarea>
							<p>
								<span name="counter" id="counter"></span> / 1000
							</p>
					</tr>
					<tr>
						<th></th>
						<td>
							<div class="notice">
								※종교 포교, 다단계 활동 유도 / 무료 행사를 포함한 상업적 목적 / 데이트,연애목적의 글은<br>작성시
								서비스 이용이 어려울 수 있습니다.
							</div>
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<div class="notice">※모임 생성시 500p의 포인트를 사용합니다.</div>
						</td>
					</tr>
					<tr>
						<th></th>
						<td><input type="submit" id="gatherSubmit" onclick="chkAge"
							value="등록"></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<th>
						<input	type="hidden" name="userNo" id="userNo" value="102" />
						<input type="hidden" name="count" id="count" />
						<script>
							
						</script>
						</th>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<script type="text/javascript"
		src="/eatwith/resources/js/gather/gatherEnroll.js"></script>
		    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
		
</body>
</html>