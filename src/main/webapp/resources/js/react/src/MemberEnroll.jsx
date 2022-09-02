import React, { useEffect, useState } from 'react'
import { API_BASE_URL } from '../../app-config';

function MemberEnrollFrm(props){
  const handleSubmit=(e)=>{
    e.preventDefault();
  };

  return(
    <form action='{API_BASE_URL}/member/memberEnroll' method="post" onSubmit={handleSubmit}>
      <MemberEnrollTable/>
    </form>
  )
}
//! 핵심 멤버 테이블 전체
function MemberEnrollTable(props){
  const [idPass, setIdPass]=useState(false);
  const [passwordPass, setPasswordPass] = useState(false);
  const [passwordCheck, setPasswordCheckPass] = useState(false);
  const [nicknameCheck, setNicknamePass] = useState(false);
  const [phoneCheck, setPhoneCheck] = useState(false);
  const [emailCheck, setEmailPass] = useState(false);
  const [genderCheck, setGenderPass] = useState(false);
  const [bornAtCheck, setBornAtPass] = useState(false);

  const [registerable, setRegisterable] = useState(false);
  // 매번 랜더링된다?
  useEffect(()=>{
    setRegisterable(idPass&&passwordPass&&passwordCheck&&nicknameCheck&&phoneCheck&&emailCheck&&genderCheck&&bornAtCheck);
    console.log("updated registerable : value = ",registerable);
  },[idPass,passwordPass,passwordCheck,nicknameCheck,phoneCheck,emailCheck,genderCheck,bornAtCheck]);

  useEffect(()=>{
    if(registerable){
      document.querySelector("#next-button").disabled=false;
    }else{
      document.querySelector("#next-button").disabled=true;
    }
  },[registerable])
  const setAble=(element, text)=>{
    element.classList.toggle('able',true);
    element.classList.toggle('unable',false);
    element.innerHTML=text;
  };
  const setUnable=(element, text)=>{
    element.classList.toggle('able',false);
    element.classList.toggle('unable',true);
    element.innerHTML=text;
  }

  //* ID check
  const handleId=(e)=>{
    const passText = document.querySelector('#id-info-box');
    const id = e.target.value;
    if(id.length < 4){
      setUnable(passText,"아이디는 4자리 이상이어야 합니다.");
      setIdPass(false);
    }else{
      console.log(id);
      $.ajax({
        url:`${API_BASE_URL}/member/checkDuplicateId`,
        method:"GET",
        data:{
          "id" : id
        },
        success(response){
          console.log("checkIDDuplicate",response);
          // 추가 처리.
          if(response.result){
            setAble(passText,"사용가능한 ID 입니다.")
            setIdPass(true);
          }else{
            setUnable(passText,"사용 불가능한 ID 입니다.")
            setIdPass(false);
          }
        },
        error: console.log
      });
    }
  }
  //* password Check
  const checkPasswordLength = /^.{6,30}$/;
  const checkPasswordNumber = /[0-9]/;
  const checkPasswordEnglish = /[a-zA-Z]/;
  const checkPasswordSpecial = /[!?<>~@#$%^&*-+=]/;
  const handlePassword=(e)=>{
    const passText = document.querySelector('#password-info-box');
    const password = e.target.value;
    if(password.length===0){
      setUnable(passText, "");
      setPasswordPass(false);
      return;
    }
    if(!checkPasswordLength.test(password)){
      setUnable(passText,"비밀번호는 6자리 이상이어야 합니다.");
      setPasswordPass(false);
    }else if(!checkPasswordNumber.test(password)){
      setUnable(passText,"비밀번호는 숫자를 포함해야 합니다.");
      setPasswordPass(false);
    }else if(!checkPasswordEnglish.test(password)){
      setUnable(passText,"비밀번호는 영문자를 포함해야 합니다.");
      setPasswordPass(false);
    }else if(!checkPasswordSpecial.test(password)){
      setUnable(passText,"비밀번호는 특수문자를 포함해야 합니다.");
      setPasswordPass(false);
    }else{
      setPasswordPass(true);
      setAble(passText,"사용 가능한 비밀번호 입니다.");
    }
  }
//* 패스워드 확인 체크
  const handlePasswordCheck=(e)=>{
    const password = document.querySelector('#password').value;
    const passText = document.querySelector('#password-check-info-box');
    if(e.target.value!==password){
      setUnable(passText,"비밀번호와 다릅니다.");
      setPasswordCheckPass(false);
    }else{
      setAble(passText,"비밀번호와 일치합니다.");
      setPasswordCheckPass(true);
    }
  }
//* 닉네임 체크
  const handleNickname=(e)=>{
    const nickname = e.target.value;
    const passText = document.querySelector('#nickname-info-box');
    if(nickname.length<1){
      setUnable(passText, "닉네임을 입력해주세요");
      setNicknamePass(false);
    }else if(/([^a-z가-힣0-9])/i.test(nickname)){ // 자음,모음 단독사용시 true 반환.(영문, 일반한글은 false으로 통과)
      setUnable(passText,"자음모음 단독사용은 불가능합니다.");
      setNicknamePass(false);
    }else if(nickname.length>15){
      setUnable(passText, "닉네임은 15글자 이하여야 합니다."); 
      setNicknamePass(false);
    }else{
      $.ajax({
        url:`${API_BASE_URL}/member/checkDuplicateNickname`,
        data:{
          'nickname':nickname
        },
        method:"GET",
        success(response){
          if(response.result){ // 사용가능한 닉네임
            setAble(passText,"사용가능한 닉네임 입니다.");
            setNicknamePass(true);
          }else{ // 사용불가 닉네임
            setUnable(passText,"사용 불가능한 닉네임입니다.");
            setNicknamePass(false);
          }
        },
        error:console.log
      })
    }
  }
//* 전화번호 체크
  const handlePhone=(e)=>{
    const passText = document.querySelector("#phone-info-box");
    e.target.value = e.target.value.replace(/[^0-9]/,"");
    if(e.target.value.length==11&&e.target.value.startsWith('010')){
      setAble(passText,"&#10003;");
      setPhoneCheck(true);
    }else{
      setUnable(passText,"올바른 전화번호를 입력해주세요");
      setPhoneCheck(false);
    }
  }
//* 이메일 관련
  const sendAuthEmail=(e)=>{
    const email = document.getElementById("email");
    const passText = document.querySelector("#email-info-box");
    console.log("email = ",email.value);
    if(!/@.*\./.test(email.value)){
      setUnable(passText,"올바른 이메일 형식을 입력해주세요");
    }else{
      console.log("지금은 이메일 확인 없이 그냥 통과시킵니다.");
      setAble(passText, "이메일이 확인되었습니다.");
      setEmailPass(true);
    }
  }
  //* 성별 클릭시
  const handleGender=(e)=>{
    setGenderPass(true);
  }
  //* 생년 체크
  const handleBornAt=(e)=>{
    e.target.value = e.target.value.replaceAll(/[^0-9]/g,"");
    setBornAtPass(true);
  }

  //* handleSwitchTbody
  const handleSwitchTbody=(e)=>{
    const firstTable = document.querySelector("#first-form");
    const secondTable = docuemtn.querySelector("#second-form");
    firstTable.classList.toggle("invisible");
    secondTable.classList.toggle("invisible");


  }


  return(
    <table id="form-root">
      <tbody id='first-form'>
        <tr>
          <td>아이디</td>
          <td><input type="text" name="id" id="id" onChange={handleId} placeholder="사용할 아이디를 입력해주세요." required/></td>
        </tr>
        <tr>
          <td className="info-text" id='id-info-box' colSpan={2}>&nbsp;</td>
        </tr>
        <tr>
          <td>비밀번호</td>
          <td><input type="password" name="password" id="password" onChange={handlePassword} placeholder="영문, 숫자, 특수문자를 포함한 비밀번호를 입력해주세요." required/></td>
        </tr>
        <tr>
          <td className='info-text' id="password-info-box" colSpan={2}>&nbsp;</td>
        </tr>
        <tr>
          <td>비밀번호 확인</td>
          <td><input type="password" id="passwordCheck" onChange={handlePasswordCheck} placeholder='비밀번호를 다시 입력해주세요.' required/></td>
        </tr>
        <tr>
          <td className='info-text' id="password-check-info-box" colSpan={2}>&nbsp;</td>
        </tr>
        <tr>
          <td>이름(닉네임)</td>
          <td><input type="text" name='name' id='name' onChange={handleNickname} placeholder="닉네임을 입력해주세요." required /></td>
        </tr>
        <tr>
          <td className='info-text' id="nickname-info-box" colSpan={2}>&nbsp;</td>
        </tr>
        <tr>
          <td>전화번호</td>
          <td><input type="text" name='phone' id='phone' onChange={handlePhone} placeholder='(-)없이 휴대전화번호를 입력해주세요.' required /></td>
        </tr>
        <tr>
          <td className='info-text' id="phone-info-box" colSpan={2}>&nbsp;</td>
        </tr>
        <tr>
          <td>이메일</td>
          <td>
            <div className="left-div">
              <input type="text" name="email" id="email" placeholder="이메일을 입력해주세요"/>
            </div>
            <div className="right-div">
              <button type='button' onClick={sendAuthEmail}>인증메일 전송(미완)</button>
            </div>
          </td>
        </tr>
        <tr>
          <td className='info-text' id="email-info-box" colSpan={2}>&nbsp;</td>
        </tr>
        <tr>
          <td>성별</td>
          <td>
            <label>남 : <input type="radio" name="gender" id="gender-male" value="M" onClick={handleGender} required/></label>
            <label>여 : <input type="radio" name="gender" id="gender-female" value="F" onClick={handleGender} required/></label>
          </td>
        </tr>
        <tr>
          <td>출생년도</td>
          <td><input type="text" name="bornAt" id="born-at" onChange={handleBornAt} placeholder="2000" /></td>
        </tr>
        <tr>
          <td>포인트</td>
          <td>포인트는 기본 1000p 적립됩니다.</td>
        </tr>
        <tr>
          <td colSpan={2}><button type='button' className='big-button' id='next-button' onClick={handleSwitchTbody} disabled>다음</button></td>
        </tr>
      </tbody>
      <tbody id='second-form' className='invisible'>
        <tr>
          <th>
            <div className="th-wrapper">
              선호 모임 지역 선택
            </div> 
          </th>
          <th>
            <div className="th-wrapper">
              선호 음식 분야 선택
            </div> 
          </th>
        </tr>
        <tr>
          <td>
            <div className='chec-wrapper'>
              <ToggleAll target="district"/>
              <Checkboxs mode='district'/>
            </div>
          </td>
          <td>
            <div className=''></div>
            <ToggleAll target="foodtype"/>
            <Checkboxs mode='foodtype'/>
          </td>
        </tr>
      </tbody>
    </table>
  );
}

// name -> input의 name, id : 
function Checkboxs(props){
  const [checkbox, setCheckbox] = useState(undefined);
  const {mode} = props;
  let searchMode;
  if(mode==='district'){
    searchMode="district/getAllDistrict"
  }else if(mode==='foodtype'){
    searchMode="foodtype/getAllFoodtype"
  }

  checkbox||$.ajax({
    url:`${API_BASE_URL}/${searchMode}`,
    method:"GET",
    success(response){
      console.log(response);
      const toRender = response.map((district)=>{
        const {code, name} = district;
        return(
          <div className="individual-checkbox">
            <input type="checkbox" name={mode} id={name} value={code} />
            &nbsp;
            <span>{name}</span>
          </div>
        );
      });
      setCheckbox(toRender);
    },
    error:console.log
  })
  return(
    <div className="checkbox-wrapper">
      {checkbox}
    </div>
  );
  
}


function ToggleAll(props){
  const [toggleStatus, setToggleStatus] = useState(false);

  const toggleAll=(e)=>{
    if(toggleStatus){
      setToggleStatus(false);
    }else{
      setToggleStatus(true);
    }
    const regions = document.querySelectorAll(`[name="${props.target}"]`);
    regions.forEach((item)=>{
      item.checked=toggleStatus;
    })
  }
  return(
    <div>
      <button type='button' id='toggleAll' onClick={toggleAll}>전체 선택</button>
    </div>
  )
}

export default MemberEnrollFrm;