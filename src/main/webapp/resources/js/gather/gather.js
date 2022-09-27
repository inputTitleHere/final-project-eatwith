    	console.log(document.querySelector('#countMember').innerText);
		document.getElementById("count").value=document.querySelector('#countMember').innerText;
		
		const wAge = document.querySelector('#writerAge').value;
		const wGender=document.querySelector('#writerGender').value;
		
		const minInput=document.querySelector('#gatherMin');
		const maxInput=document.querySelector('#gatherMax');
		
    	const toggleAge=(e)=>{
		minInput.disabled=e.target.checked;
		maxInput.disabled=e.target.checked;
		}
    
    	const genderM=document.querySelector('#gatherGenM');
		const genderF=document.querySelector('#gatherGenF');
		
    	const toggleGender=(e)=>{
    		genderM.disabled=e.target.checked;
    		genderF.disabled=e.target.checked;
		}
		genderM.addEventListener("click",function(){
			console.log("남자에체크");
			if(genderM.value==wGender){
			}
			else{
				alert("본인 성별이 아닙니다.");
				genderM.checked=false;
			}			
		})
		genderF.addEventListener("click",function(){
			console.log("여자에체크");
			if(genderF.value==wGender){
			}
			else{
				alert("본인 성별이 아닙니다.");
				genderF.checked=false;
			}
		})


    
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
	