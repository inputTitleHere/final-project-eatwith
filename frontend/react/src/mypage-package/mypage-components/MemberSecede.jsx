import { API_BASE_URL } from "../App-config.js";
import { useState } from "react";
import $ from 'jquery';


function MemberSecede(props){

  const [showPwd, setShowPwd] = useState(false);


  const togglePassword = (e) => {
    setShowPwd(!showPwd);
  };

  const handleSubmit=(e)=>{
    e.preventDefault();
    if(!window.confirm('정말로 회원 탈퇴 하시겠습니까?')){
      return;
    }
    const pwd = document.querySelector('#oldPassword').value;
    let isPass = false;
    $.ajax({
      url:`${API_BASE_URL}/member/checkPasswordCookie`,
      method:"GET",
      data:{
        oldPassword:pwd
      },
      xhrFields:{
        withCredentials:true
      },
      async:false,
      success(response){
        if(response){
          console.log(response);
          isPass=response;
        }else{
          alert('비밀번호가 틀렸습니다.');
          return;
        }
      },
      error:console.log
    })
    if(isPass){
      e.target.submit();
    }
  }

  return(
    <div className="secede-wrapper">
      <h1>회원 탈퇴</h1>
      <div className="secede-form">
        <form onSubmit={handleSubmit} action={`${API_BASE_URL}/member/memberQuit`} method="post">
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
            </tbody>
          </table>
          <div className="button-wrapper">
            <button className="submit-button">
              회원 탈퇴하기
            </button>
          </div>
        </form>
      </div>
    </div>
  );

}

export default MemberSecede;