import { useState } from "react";
import { API_BASE_URL } from "../App-config.js";
import $ from 'jquery';

function PasswordChange(props) {
  const [showPwd, setShowPwd] = useState(false);
  const [passwordPass, setPasswordPass] = useState(false);
  const [warningText, setWarningText] = useState("");
  const [douleCheck, setDoubleCheck] = useState("");

  const togglePassword = (e) => {
    setShowPwd(!showPwd);
  };

  const handlePasswordChange = (e) => {
    const checkPasswordLength = /^.{6,30}$/;
    const checkPasswordNumber = /[0-9]/;
    const checkPasswordEnglish = /[a-zA-Z]/;
    const checkPasswordSpecial = /[!?\\`/<>~@#$%^&*\-+=]/;

    const password = e.target.value;
    if (password.length === 0) {
      setWarningText("");
      setPasswordPass(false);
      return;
    }
    if (!checkPasswordLength.test(password)) {
      setWarningText("비밀번호는 6자리 이상이어야 합니다.");
      setPasswordPass(false);
    } else if (!checkPasswordNumber.test(password)) {
      setWarningText("비밀번호는 숫자를 포함해야 합니다.");
      setPasswordPass(false);
    } else if (!checkPasswordEnglish.test(password)) {
      setWarningText("비밀번호는 영문자를 포함해야 합니다.");
      setPasswordPass(false);
    } else if (!checkPasswordSpecial.test(password)) {
      setWarningText("비밀번호는 특수문자를 포함해야 합니다.");
      setPasswordPass(false);
    } else {
      // setPasswordPass(true);
      setWarningText("");
    }
  };
  const handleCheckPassword = (e) => {
    const passwordCheck = e.target.value;
    const newPassword = document.querySelector("#newPassword").value;
    if(passwordCheck.length===0){
      setDoubleCheck("");
      setPasswordPass(false);
      return;
    }

    if(passwordCheck!==newPassword){
      setDoubleCheck("신규 비밀번호와 동일하게 입력해주세요.");
      setPasswordPass(false);
      return;
    }else{
      setDoubleCheck("");
      setPasswordPass(true);
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // console.log(e.target.newPassword.value);
    let flag=false;
    $.ajax({
      url:`${API_BASE_URL}/member/checkPasswordCookie`,
      method:"GET",
      data:{
        oldPassword:e.target.oldPassword.value
      },
      xhrFields:{
        withCredentials: true
      },
      async:false,
      success(response){
        if(response){
          flag=true;
        }else{
          alert("기존 비밀번호가 틀렸습니다.");
          flag=false;
        }
      },
      error:console.log
    })
    if(!flag){
      return;
    }
    const password = {password:e.target.newPassword.value};
    $.ajax({
      url:`${API_BASE_URL}/member/updatePassword`,
      method:"PUT",
      // dataType:'json',
      data:JSON.stringify(password),
      contentType:'application/json; charset=utf-8',
      xhrFields:{
        withCredentials:true
      },
      success(response){
        alert("비밀번호를 변경하였습니다");
      },
      error:console.log
    })
  };

  return (
    <div className="password-change-wrapper">
      <h1>비밀번호 수정</h1>
      <div className="password-form">
        <form onSubmit={handleSubmit}>
          <table>
            <tbody>
              <tr>
                <td className="title">기존 비밀번호</td>
                <td className="input">
                  <input
                    type={showPwd ? "text" : "password"}
                    name="oldPassword"
                    id="oldPassword"
                  />
                </td>
                <td>
                  <div>
                    {showPwd ? (
                      <img
                        src={`${API_BASE_URL}/resources/image/misc/eye-open.svg`}
                        alt="눈 이미지 안뜸"
                        draggable="false"
                        onClick={togglePassword}
                      />
                    ) : (
                      <img
                        src={`${API_BASE_URL}/resources/image/misc/eye-close.svg`}
                        alt="눈 이미지 안뜸"
                        draggable="false"
                        onClick={togglePassword}
                      />
                    )}
                  </div>
                </td>
              </tr>
              <tr></tr>
              <tr>
                <td className="title">신규 비밀번호</td>
                <td className="input">
                  <input
                    type={showPwd ? "text" : "password"}
                    name="newPassword"
                    id="newPassword"
                    onChange={handlePasswordChange}
                  />
                </td>
              </tr>
              <tr>
                <td colSpan={2} className="warning-text">
                      {warningText}
                </td>
              </tr>
              <tr>
                <td className="title">비밀번호 확인</td>
                <td className="input">
                  <input
                    type={showPwd ? "text" : "password"}
                    id="checkPassword"
                    onChange={handleCheckPassword}
                  />
                </td>
              </tr>
              <tr>
                <td colSpan={2} className="warning-text">
                  {douleCheck}
                </td>
              </tr>
            </tbody>
          </table>
          <div className="button-wrapper">
            <button className="submit-button" disabled={passwordPass?false:true}>
              비밀번호 수정하기
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default PasswordChange;
