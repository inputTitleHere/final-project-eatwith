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
    <script src="<%= request.getContextPath() %>/resources/js/jquery-3.6.0.js"></script>
    <title>리뷰 작성하기</title>
<style>
#container{
	display:flex;
    font-size:16px;
	width: 1200px;	
	left:0;
	right:0;
	margin:auto;
	padding:100px;
}
aside{
    width:260px;
    margin-left: 10px;
    padding-left: 20px;
    padding-right:20px;
    margin-right: 10px;
    padding-bottom: 20px;
    background-color: white;
}
#review{
	display:flex;
    font-size:16px;
	width: 1200px;	
	background-color: white;
	padding-bottom: 20px;
	margin-left: 10px;
	padding-right: 20px;
	margin-right: 10px;
	padding:30px;
}
#makegather{
    float: right;
}
td{
    padding-left: 10px;
    padding-right: 10px;
}
tr{
    margin-top: 30px;
}
#rateStars{
display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
direction: rtl; /* 이모지 순서 반전 */
border: 0; /* 필드셋 테두리 제거 */
}
#tasteStars,#priceStars,#serviceStars{
    border: 0;
}
#rateStars fieldset legend{
    text-align: left;
}
#rateStars input[type=radio]{
    display: none; /* 라디오박스 감춤 */
}
#rateStars label{
    font-size: 2em; /* 이모지 크기 */
    color: transparent; /* 기존 이모지 컬러 제거 */
    text-shadow: 0 0 0 #e3e3e3; /* 새 이모지 색상 부여 */
}
#rateStars label:hover{
    text-shadow: 0 0 0 #3A3C68 ; /* 마우스 호버 */
}
#rateStars label:hover ~ label{
    text-shadow: 0 0 0 #3A3C68 ; /* 마우스 호버 뒤에오는 이모지들 */
}
#rateStars input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 #3A3C68 ; /* 마우스 클릭 체크 */
}
#stars{
    background-color: #f5f5f5;
    height: 50px;
    width: 300px;
}
#starsName{
    background-color: #f5f5f5;
    width: 60px;
}
#checkstars{
    width: 350px;
}
#content{
    height: 200px;
    width: 700px;
    margin: 20px;
}
#counter{
    margin-left: 660px;
}
#attachFile{
    background-color: #DC948A;
    border: 0;
    color: white;
    margin-left: 100px;
    width: 100px;
    height: 30px;
    border-radius: 3%;
    font-size: 16px;
}
input[type=checkbox]{
    zoom:2;
}
#submitReview{
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
#restaurantName{
	display:block;
	width:240px;
	font-size:20px;
	font-weight:bold;
}
</style>
</head>
<body bgcolor="#F0EBEC">
    <div id="container">
        <aside>
           	<div id="restaurantName">'<span>${reviewInfo.name}</span>' 평가하기</div>
            <h4>음식점 사진</h4>
            <h4>${reviewInfo.naverFoodType}</h4>
            <h5>${reviewInfo.address} [${reviewInfo.dong} ]</h5>
            <h4>${reviewInfo.phone}</h4>
        </aside>
        <section id="review">
            <form:form method="post" action="${pageContext.request.contextPath}/review/enrollReview">
            <table>
                <tbody>
                    <tr>
                        <br>
                        <td id="checkstars">전체평점 * <br>이 음식점에 대한 전반적인 평가를 해주세요.</td>
                        <td id="starsName">평점</td>
                        <td id="stars">
                                <fieldset id="rateStars">
                                    <input type="radio" name="rateStars" value="5" id="rate1"><label for="rate1">⭐</label>
                                    <input type="radio" name="rateStars" value="4" id="rate2"><label for="rate2">⭐</label>
                                    <input type="radio" name="rateStars" value="3" id="rate3"><label for="rate3">⭐</label>
                                    <input type="radio" name="rateStars" value="1" id="rate5"><label for="rate5">⭐</label>
                                    <input type="radio" name="rateStars" value="2" id="rate4"><label for="rate4">⭐</label>
                                </fieldset>
                        </td>
                    </tr>
                </tbody>
            </table>
            <hr>
            <table>
                <tbody>
                    <tr>
                        <td id="checkstars">항목별 평점 * <br>이 음식점의 맛, 가격, 서비스를 항목별로 나누어 평가해주세요.</td>
                        <td id="starsName">
                            맛
                        </td>
                        <td id="stars">
                                <fieldset id="tasteStars">
                                    <input type="radio" name="tasteStars" value="1">
                                    맛없음
                                    <input type="radio" name="tasteStars" value="3">
                                    보통
                                    <input type="radio" name="tasteStars" value="5">
                                    맛있음
                                </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td id="starsName">
                            가격
                        </td>
                        <td id="stars">
                                <fieldset id="priceStars">
                                    <input type="radio" name="priceStars" value="1">
                                    불만족
                                    <input type="radio" name="priceStars" value="3">
                                    보통
                                    <input type="radio" name="priceStars" value="5">
                                    만족함
                                </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td id="starsName">
                            서비스
                        </td>
                        <td id="stars">
                                <fieldset id="serviceStars">
                                    <input type="radio" name="serviceStars" value="1">
                                    불친절
                                    <input type="radio" name="serviceStars" value="3">
                                    보통
                                    <input type="radio" name="serviceStars" value="5">
                                    친절함
                                </fieldset>
                        </td>
                    </tr>
                </tbody>
            </table>
            <hr>
            <div>방문후기*</div>
            <textarea name="content" id="content" cols="30" rows="10" placeholder="음식, 서비스, 분위기, 위생상태 등의 방문 경험을 적어주세요."></textarea>
            <p><span id="counter"></span> / <span id="max-counter"></span></p>
            <hr>
            <table>
                <thead>
                    <tr>
                        <td><strong>음식ㆍ실내외 사진 (<span id="countImg">0</span>/<span id="maxImg">3</span>)</strong></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td> - 본인이 직접 촬영하지 않은 사진</td>
                        <td><input type="button" id="attachFile" value="사진첨부"></td>
                    </tr>
                    <tr>
                        <td> - 형체를 알아볼 수 없는 저해상도의 사진은 통보없이 삭제될 수 있습니다.</td>
                    </tr>
                </tbody>
            </table>
            <hr>
            <table>
                <tbody>
                    <tr id="clean">
                        <td><input type="checkbox" id="cleanPromise"></td>
                        <td>
                            <strong>클린평가서약</strong><br>
                            위 작성된 평가는 허위후기, 음식점 관련자의 홍보성 내용, 경쟁업소의 외곡된 평가가 아님을 서약합니다.</td>
                    </tr>
                </tbody>
            </table>
            <hr>
            <div><input type="submit" id="submitReview" value="리뷰 등록하기"></div>
        </form:form>
        </section>
    </div>
    <script>
        const MAX_COUNTER=1000;
        $("#counter").html(0);
        $("#max-counter").html(MAX_COUNTER);

        $(content).keyup((e)=>{
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

    </script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>