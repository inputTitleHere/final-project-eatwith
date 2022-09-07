
    	const toggleAge=(e)=>{
		const minInput=document.querySelector('#gatherMin');
		const maxInput=document.querySelector('#gatherMax');
		minInput.disabled=e.target.checked;
		maxInput.disabled=e.target.checked;
	}
    
    	const toggleGender=(e)=>{
		const genderM=document.querySelector('#gatherGenM');
		const genderF=document.querySelector('#gatherGenF');
		genderM.disabled=e.target.checked;
		genderF.disabled=e.target.checked;
	}

    
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