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
<style>
#container{
    display: flex;
    justify-content: center;
    width: 1000px;
}
form{
    background-color: white;
    margin: 20px;
    padding: 10px;
}
th{
    padding-right: 50px;
    padding-bottom: 20px;
}
td{
    padding-bottom: 20px;
}
#gatherTitle{
    width: 700px;
    height: 30px;
}
#gatherContent{
    height: 200px;
    width: 700px;
    font-size: 15px;
}
#counter{
    margin-left: 660px;
}
.notice{
    text-align: center;
}
#gatherSubmit{
    background-color: #DC948A;
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
	background-color:#ECC7C5;
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
</style>
</head>
<body bgcolor="#F0EBEC">
    <div id="container">
        <form name="gatherEnrollFrm"method="post" action="">
            <table>
                <tbody>
                    <tr>
                        <th>
                            모임 제목
                        </th>
                        <td>
                            <input type="text" name="gatherTitle" id="gatherTitle" placeholder="모임 제목을 입력해 주세요.">
                        </td>
                    </tr>
                    <tr>
                        <th>
                            모임 장소
                        </th>
                        <td>
                            검색창 만들기
                        </td>
                    </tr>
                    <tr>
                        <th> 
                        </th>
                        <td>
                            음식점이름 <br> 음식카테고리 <br> ㅇㅇ구
                        </td>
                    </tr>
                    <tr>
                        <th>
                            모임인원
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
                            <input type="number" name="gatherMin" id="gatherMin" placeholder="최소나이"> ~ <input type="number" name="gatherMax" id="gatherMax" placeholder="최대나이">
                        </td>
                    </tr>
                    <tr>
                        <th>
                            성별제한
                        </th>
                        <td>
                            <input type="radio" name="gatherGender" id="gatherGender" value="all" checked>제한 없음
                            <input type="radio" name="gatherGender" id="gatherGender" value="M">남
                            <input type="radio" name="gatherGender" id="gatherGender" value="F">여
                        </td>
                    </tr>
                    <tr>
                        <th>
                            모임 시간
                        </th>
                        <td>
                            <input type="datetime-local" name="gatherTime" id="gatherTime" onchange="setMinValue()" required>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            모임 설명
                        </th>
                        <td>
                            <textarea name="gatherContent" id="gatherContent" cols="30" rows="10" placeholder="모임 출발 장소, 모임에서 찾는 사람 등 모임에 대한 설명을 적어주세요." required></textarea>
                            <p><span id="counter"></span> / <span id="max-counter"></span></p>
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
                            <input type="submit" id="gatherSubmit" value="등록">
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <th>
                            <input type="hidden" name="count" id="count"/>
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

    //모임 설명 글자세기
    const MAX_COUNTER=1000;
        $("#counter").html(0);
        $("#max-counter").html(MAX_COUNTER);

        $(gatherContent).keyup((e)=>{
            const {target:{value}}=e;
            console.log(value);
            const len=value.length;
            const $counter = $(counter);
            $counter.html(len);
            if(len<=MAX_COUNTER){
                $counter.css('color',"initial");
            }else{
                $counter.css('color',"red");
            }
        })
  
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
        //나이설정문제, 모임장소선택 확인
    }


</script>
</body>
</html>