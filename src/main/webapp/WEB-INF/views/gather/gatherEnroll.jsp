<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="<%= request.getContextPath() %>/resources/js/jquery-3.6.0.js"></script>        
    <title>모임 작성하기</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/root.css"/>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/image/favicon.ico">

   
<style>
*{
    font:var(--our-font);
}
#container{
    justify-content: center;
    width: 1000px;
}
form{
    background-color: white;
    margin: 20px;
    padding: 30px;
}
th{
    padding-right: 50px;
    padding-bottom: 20px;
    font-weight:bold;
    font-size:18px;   
}
td{
    padding-bottom: 20px;    
}
#gatherTitle{
    width: 700px;
    height: 20px;
}
#gatherContent{
    height: 200px;
    width: 700px;
    font-size: 15px;
}
#counter{
    margin-left: 620px;
}
.notice{
    text-align: center;
}
#gatherSubmit{
    background-color: var(--jjin-pink);
    border: 0;
    color: white;
    margin-top: 10px;
    margin-left: 100px;
    margin-right: 100px;
    width: 500px;
    height: 40px;
    font-size: 20px;
}
#plus,#minus{
	background-color: var(--yeon-pink);
    height: 30px;
    width: 30px;
	border:0px;
	font-size:24px;
}
#countMember{
	font-size:24px;
	padding-left:20px;
	padding-right:20px;
}
#gatherMin,#gatherMax,#gatherTime{
    height: 20px;
}
#findStore{
    height: 20px;
    width:200px;
}
.openBtn {
    margin-left: 5px;
    height: 27px;
    border: 0;
    background-color: #DC948A;
    color: white;
    padding: 5px 10px;
    cursor: pointer;
}
.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}
.modal .bg {
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
}
.modalBox {
    position: absolute;
    background-color: #F0EBEC;
    width: 500px;
    height: 300px;
    padding: 15px;
    overflow: auto;
}
.modalBox::-webkit-scrollbar{
    display: none;
}
.modalBox .closeBtn {
    display: block;
    width: 20px;
    border: 0;
    background-color: #F0EBEC;
    margin: 0 auto;
    margin-left: 475px;
}
.modalBox div{
	display:flex;
	align-item:center;
	justify-content:space-between;
}
.listBox{
    font-size: 20px;
}
.hidden {
  display: none;
}
.selectStore{
    display:flexbox;
}
#pilsu{
	color:#EE4949;
}
.modal-restaurant-title{
	position:relative;
	width:160px;
	font-size:18px;
	font-weight:bold;
	overflow:hidden;
}
.modal-restaurant-district{
	width:80px;
}
.modal-restaurant-type{
	margin-left:10px;
	width:100px;
}
.selectRestaurant{
	width:50px;
	height:30px;
	background-color:var(--jjin-pink);
	color:white;
	border:0;
}
#storeName{
	font-size:18px;
	font-weight:strong;	
}
li{
	list-style:none;
}
</style>
</head>
<body bgcolor="#F0EBEC">
    <div id="container">
        <form name="gatherEnrollFrm"method="post" action="${pageContext.request.contextPath}/gather/gatherEnroll">
            <table>
                <tbody>
                    <tr>
                        <th>
                            모임 제목<span id="pilsu">*</span>
                        </th>
                        <td>
                            <input type="text" name="gatherTitle" id="gatherTitle" placeholder="모임 제목을 입력해 주세요.">
                        </td>
                    </tr>
                    <tr>
                        <th>
                            모임 장소<span id="pilsu">*</span>
                        </th>
                        <td>
                        	<input type="hidden" id="restaurantNo" name="restaurantNo"/>
                        	<input type="hidden" id="foodCode" name="foodCode" />
                        	<input type="hidden" id="districtCode" name="districtCode"/>
                            <input type="text" id="findStore" name="findStore" placeholder="가게 이름을 입력해주세요."><button type="button" class="openBtn">검색</button>
                            <div class="modal hidden">
                                <div class="bg"></div>
                                <div class="modalBox">
                                    <!-- 모달창 내부 -->
                                    <button type="button" class="closeBtn">✖</button>
										<div class="modalContent"></div>
                                </div>
                            </div>
                        </td>
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
                        <th> 
                        </th>
                        <td>
                            <span id="storeName"></span> <br> <span id="storeCategory"></span> <br> <span id="storeLocation"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            모임인원<span id="pilsu">*</span>
                        </th>
                        <td>
                            <div id="countMem">
                                <input type="button" class="count" id="plus" value="+">
                                <span id="countMember">1</span>
                                <input type="button" class="count" id="minus" value="-">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            나이제한
                        </th>
                        <td>
                        	<input type="checkbox" id="ageChk" onchange="toggleAge(event)"/>나이제한X &nbsp;&nbsp;
                            <input type="number" name="gatherMin" id="gatherMin" placeholder="최소나이"> ~ <input type="number" name="gatherMax" id="gatherMax" placeholder="최대나이">
                        </td>
                    </tr>
                    <script>
                    	const toggleAge=(e)=>{
                    		const minInput=document.querySelector('#gatherMin');
                    		const maxInput=document.querySelector('#gatherMax');
                    		minInput.disabled=e.target.checked;
                    		maxInput.disabled=e.target.checked;
                    	}
                    	
                    </script>
                    <tr>
                        <th>
                            성별제한
                        </th>
                        <td>
                        	<input type="checkbox" id="genderChk" onchange="toggleGender(event)" />성별제한X &nbsp;&nbsp;
                            <input type="radio" name="gatherGender" id="gatherGenM" value="M">남
                            <input type="radio" name="gatherGender" id="gatherGenF" value="F">여
                        </td>
                    </tr>
                    <script>
                    	const toggleGender=(e)=>{
                    		const genderM=document.querySelector('#gatherGenM');
                    		const genderF=document.querySelector('#gatherGenF');
                    		genderM.disabled=e.target.checked;
                    		genderF.disabled=e.target.checked;
                    	}
                    </script>
                    <tr>
                        <th>
                            모임시간<span id="pilsu">*</span>
                        </th>
                        <td>
                            <input type="datetime-local" name="gatherTime" id="gatherTime" onchange="setMinValue()" required>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            모임설명<span id="pilsu">*</span>
                        </th>
                        <td>
                            <textarea name="gatherContent" id="gatherContent" cols="30" rows="10" placeholder="모임 출발 장소, 모임에서 찾는 사람 등 모임에 대한 설명을 적어주세요." required></textarea>
                            <p><span name="counter" id="counter"></span> / 1000</p>
                        </tr>
                    <tr>
                        <th></th>
                        <td>
                            <div class="notice">※종교 포교, 다단계 활동 유도 / 무료 행사를 포함한 상업적 목적 / 데이트,연애목적의 글은<br>작성시 서비스 이용이 어려울 수 있습니다.</div> 
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
                        <td>
                            <input type="submit" id="gatherSubmit" onclick="chkAge" value="등록">
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <th>
                            <input type="hidden" name="count" id="count"/>
                            <input type="hidden" name="userNo" id="userNo" value="102" />
                        </th>
                    </tr>
                </tfoot>
            </table>
        </form>
    </div>
<script>
    //모임시간설정
    let dateElement = document.getElementById('gatherTime');
    let date = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -8);
    dateElement.value = date;
    dateElement.setAttribute("min", date);
    function setMinValue() {
        if(dateElement.value < date) {
            alert('현재 시간보다 이전의 날짜는 설정할 수 없습니다.');
            dateElement.value = date;
        }
    }

    

    //모임 설명 글자세기
    $(document).ready(function() {
    $('#gatherContent').on('keyup', function() {
        $('#counter').html($(this).val().length);
 
        if($(this).val().length > 1000) {
            $(this).val($(this).val().substring(0, 1000));
            $('#counter').html("1000");
        }
    });
    });

    //+,-버튼 작동
    let countMem=document.querySelector('#countMem');
    const plusBtn=countMem.querySelector('#plus');
    const minusBtn=countMem.querySelector('#minus');
    const number = countMem.querySelector('span');

    plusBtn.addEventListener('click',function(){
        let count=Number(number.textContent)
        if(number.textContent<9){
            count=count+1;
            number.textContent=count;
        }
        document.getElementById("count").value=count;
        console.log(document.getElementById("count").value);
    });
    minusBtn.addEventListener('click',function(){
        let count=Number(number.textContent)
        if(number.textContent>1){
            count=count-1;
            number.textContent=count;
        }
        document.getElementById("count").value=count;
        console.log(document.getElementById("count").value);
    });
    document.getElementById("count").value=number.textContent;
  
    //유효성검사
    document.gatherEnrollFrm.onsubmit=(e)=>{
        const frm=e.target;
        if(!/^.+$/.test(frm.gatherTitle.value)){
            alert("제목을 작성해주세요.");
            frm.gatherTitle.focus();
            return false;
        }
        if(!/^(.|\n)+$/.test(frm.gatherContent.value)){
            alert("내용을 작성해주세요.");
            frm.gatherContent.focus();
            return false;
        }
        //나이설정문제
        if(frm.gatherMin.value>frm.gatherMax.value){
            alert("나이 제한을 올바르게 입력해주세요.");
            frm.gatherMin.focus();
            return false;
        }

        //모임 장소선택
        if(chkRestaurant==0){
        	alert("모임 음식점 장소를 정해주세요.");
        	return false;
        }
    }


</script>
</body>
</html>