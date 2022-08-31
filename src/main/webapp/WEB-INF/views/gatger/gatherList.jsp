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
    <title>모임 리스트</title>
<style>

aside{
    float: left;
    width:260px;
    margin-left: 10px;
    padding-left: 20px;
    padding-right:20px;
    margin-right: 10px;
    padding-bottom: 20px;
    background-color: white;
}
#content{
    float: left;
    width: 700px;
    background-color: white;
    padding-bottom: 20px;
    margin-left: 10px;
    padding-right:20px;
    margin-right: 10px;
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
#seeSelect{
    height: 30px;
}
#makeGather{
    margin-left: 90%;
}
#seeMore{
    background-color: #e3e3e3;
    margin-left: 20px;
    margin-right: 5px;
    text-align: center;
}
#moreGather{
    background-color: #e3e3e3;
    border: 0px;
}
</style>
</head>
<body bgcolor="#F0EBEC">
    <div id="container">
        <aside>
            <h3>모임 지역 선택</h3>
            <input type="checkbox" name="location" onclick="selectAll(this)">서울 전체<br>
            <input type="checkbox" name="location">강남구
            <input type="checkbox" name="location">강동구<br>
            <input type="checkbox" name="location">강북구
            <input type="checkbox" name="location">강서구<br>
            <input type="checkbox" name="location">관악구
            <input type="checkbox" name="location">광진구<br>
            <input type="checkbox" name="location">구로구
            <input type="checkbox" name="location">금천구<br>
            <input type="checkbox" name="location">노원구
            <input type="checkbox" name="location">도봉구<br>
            <input type="checkbox" name="location">동대문구
            <input type="checkbox" name="location">동작구<br>
            <input type="checkbox" name="location">마포구
            <input type="checkbox" name="location">서초구<br>
            <input type="checkbox" name="location">서대문구
            <input type="checkbox" name="location">성동구<br>
            <input type="checkbox" name="location">성북구
            <input type="checkbox" name="location">송파구<br>
            <input type="checkbox" name="location">양천구
            <input type="checkbox" name="location">용산구<br>
            <input type="checkbox" name="location">영등포구
            <input type="checkbox" name="location">은평구<br>
            <input type="checkbox" name="location">종로구
            <input type="checkbox" name="location">중구<br>
            <input type="checkbox" name="location">중랑구
            <hr>
            <h3>모임 음식 분야 선택</h3>
            <input type="radio" name="food">양식
            <input type="radio" name="food">한식<br>
            <input type="radio" name="food">중식
            <input type="radio" name="food">일식<br>
            <input type="radio" name="food">카페&디저트
            <input type="radio" name="food">기타
            <hr>
            <h3>모임 정렬</h3>
            <select name="see" id="seeSelect">
                <option value="">보기 설정</option>
                <option value="최신순">최신순 보기</option>
                <option value="마감임박순">마감임박순 보기</option>
            </select>
        </aside>
        <section id="content">
            <input type="button" id="makeGather" value="모임 만들기">
            <br><br>
            <table>
                <tbody>
                    <tr>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                    </tr>
                    <tr>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                    </tr>
                    <tr>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                        <td>모임제목 <br>모임 음식점 장소 <br>음식점카테고리<br>모임 시간<br> 모임 인원(0/2)<br><input type="button" value="모임 참여하기"></td>
                    </tr>
                </tbody>
            </table>
            <div id="seeMore"><input type="button" id="moreGather" value="더보기"></div>
        </section>

    </div>
    <script>
        function selectAll(selectAll){
            const checkboxes = document.getElementsByName('location');
            checkboxes.forEach((checkbox)=>{
                checkbox.checked=selectAll.checked;
            })
        }
    </script>
</body>
</html>