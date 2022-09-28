import React, { useEffect, useState } from "react";
import { API_BASE_URL } from "../configs/App-config.js";
import $ from 'jquery';
import './scss/member-enroll.scss'

// 이 코드는 Webpack으로 빌드 한 다음 결과를 봐야한다.

function MemberEnrollFrm(props) {
  const url = `${API_BASE_URL}/member/memberEnroll`;
  return (
    <form action={url} method="post">
      <MemberEnrollTable />
    </form>
  );
}

const setAble = (element, text) => {
  element.classList.toggle("able", true);
  element.classList.toggle("unable", false);
  element.innerHTML = text;
};
const setUnable = (element, text) => {
  element.classList.toggle("able", false);
  element.classList.toggle("unable", true);
  element.innerHTML = text;
};

//! 핵심 멤버 테이블 전체
function MemberEnrollTable(props) {
  const [idPass, setIdPass] = useState(false);
  const [passwordPass, setPasswordPass] = useState(false);
  const [passwordCheck, setPasswordCheckPass] = useState(false);
  const [nicknameCheck, setNicknamePass] = useState(false);
  const [phoneCheck, setPhoneCheck] = useState(false);
  const [emailCheck, setEmailPass] = useState(false);
  const [genderCheck, setGenderPass] = useState(false);
  const [bornAtCheck, setBornAtPass] = useState(false);

  const [registerable, setRegisterable] = useState(false);
  // 매번 랜더링된다?
  useEffect(() => {
    setRegisterable(
      idPass &&
        passwordPass &&
        passwordCheck &&
        nicknameCheck &&
        phoneCheck &&
        emailCheck &&
        genderCheck &&
        bornAtCheck
    );
  }, [
    idPass,
    passwordPass,
    passwordCheck,
    nicknameCheck,
    phoneCheck,
    emailCheck,
    genderCheck,
    bornAtCheck,
  ]);

  useEffect(() => {
    if (registerable) {
      const nextButton = document.querySelector("#next-button");
      nextButton.disabled = false;
      nextButton.addEventListener("onclick", handleSwitchTbody);
    } else {
      document.querySelector("#next-button").disabled = true;
    }
  }, [registerable]);

  //* ID check
  const handleId = (e) => {
    const passText = document.querySelector("#id-info-box");
    const id = e.target.value;
    e.target.value = id.replaceAll(" ", "");
    if (id.length < 4) {
      setUnable(passText, "아이디는 4자리 이상이어야 합니다.");
      setIdPass(false);
    } else {
      $.ajax({
        url: `${API_BASE_URL}/member/checkDuplicateId`,
        method: "GET",
        data: {
          id: id,
        },
        success(response) {
          if (response.result) {
            setAble(passText, "사용가능한 ID 입니다.");
            setIdPass(true);
          } else {
            setUnable(passText, "사용 불가능한 ID 입니다.");
            setIdPass(false);
          }
        },
        error: console.log,
      });
    }
  };
  //* password Check
  const checkPasswordLength = /^.{6,30}$/;
  const checkPasswordNumber = /[0-9]/;
  const checkPasswordEnglish = /[a-zA-Z]/;
  const checkPasswordSpecial = /[!?\\`/<>~@#$%^&*\-+=]/;
  const handlePassword = (e) => {
    const passText = document.querySelector("#password-info-box");
    const password = e.target.value;
    if (password.length === 0) {
      setUnable(passText, "");
      setPasswordPass(false);
      return;
    }
    if (!checkPasswordLength.test(password)) {
      setUnable(passText, "비밀번호는 6자리 이상이어야 합니다.");
      setPasswordPass(false);
    } else if (!checkPasswordNumber.test(password)) {
      setUnable(passText, "비밀번호는 숫자를 포함해야 합니다.");
      setPasswordPass(false);
    } else if (!checkPasswordEnglish.test(password)) {
      setUnable(passText, "비밀번호는 영문자를 포함해야 합니다.");
      setPasswordPass(false);
    } else if (!checkPasswordSpecial.test(password)) {
      setUnable(passText, "비밀번호는 특수문자를 포함해야 합니다.");
      setPasswordPass(false);
    } else {
      setPasswordPass(true);
      setAble(passText, "사용 가능한 비밀번호 입니다.");
    }
  };
  //* 패스워드 확인 체크
  const handlePasswordCheck = (e) => {
    const password = document.querySelector("#password").value;
    const passText = document.querySelector("#password-check-info-box");
    if (e.target.value !== password) {
      setUnable(passText, "비밀번호와 다릅니다.");
      setPasswordCheckPass(false);
    } else {
      setAble(passText, "비밀번호와 일치합니다.");
      setPasswordCheckPass(true);
    }
  };
  //* 닉네임 체크
  const handleNickname = (e) => {
    const nickname = e.target.value;
    const passText = document.querySelector("#nickname-info-box");
    if (nickname.length < 1) {
      setUnable(passText, "닉네임을 입력해주세요");
      setNicknamePass(false);
    } else if (/([^a-z가-힣0-9\x20\-_])/i.test(nickname)) {
      // 자음,모음 단독사용시 true 반환.(영문, 일반한글은 false으로 통과)
      setUnable(passText, "특수문자, 자음모음 단독사용은 불가능합니다.");
      setNicknamePass(false);
    } else if (nickname.length > 15) {
      setUnable(passText, "닉네임은 15글자 이하여야 합니다.");
      setNicknamePass(false);
    } else {
      $.ajax({
        url: `${API_BASE_URL}/member/checkDuplicateNickname`,
        data: {
          nickname: nickname,
        },
        method: "GET",
        success(response) {
          if (response.result) {
            // 사용가능한 닉네임
            setAble(passText, "사용가능한 닉네임 입니다.");
            setNicknamePass(true);
          } else {
            // 사용불가 닉네임
            setUnable(passText, "사용 불가능한 닉네임입니다.");
            setNicknamePass(false);
          }
        },
        error: console.log,
      });
    }
  };
  //* 전화번호 체크
  const handlePhone = (e) => {
    const passText = document.querySelector("#phone-info-box");
    e.target.value = e.target.value.replace(/[^0-9]/, "");
    if (e.target.value.length === 11 && e.target.value.startsWith("010")) {
      setAble(passText, "&#10003;");
      setPhoneCheck(true);
    } else {
      setUnable(passText, "올바른 전화번호를 입력해주세요");
      setPhoneCheck(false);
    }
  };
  //* 이메일 관련
  function EmailComponent(props) {
    const [code, setCode] = useState("");
    const [sending, setSending] = useState(false);
    const passText = document.querySelector("#email-info-box");
    const sendAuthEmail = (e) => {
      // 이메일 자체의 무결성 확인
      const email = document.getElementById("email");
      if (!/@.*\./.test(email.value)) {
        setUnable(passText, "올바른 이메일 형식을 입력해주세요");
      } else {
        // 이메일을 보낼 수 있는 경우
        const emailToSend = email.value;
        setSending(true);
        $.ajax({
          url: `${API_BASE_URL}/email/sendEmail`,
          method: "GET",
          data: {
            emailToSend: emailToSend,
          },
          // async: false,
          success(response) {
            setCode(response.code);
          },
          error: console.log,
        });
      }
    };
    if (!code) {
      // 인증코드가 없으면
      if (emailCheck) {
        // 인증이 끝난 상태면
        return (
          <button
            type="button"
            id="email-button"
            onClick={sendAuthEmail}
            disabled
          >
            인증메일 전송
          </button>
        );
      } else {
        if (!sending) {
          return (
            <button type="button" id="email-button" onClick={sendAuthEmail}>
              인증메일 전송
            </button>
          );
        } else {
          return (
            <button
              type="button"
              id="email-button"
              onClick={sendAuthEmail}
              disabled
            >
              전송중
            </button>
          );
        }
      }
    } else {
      // 코드가 있으면
      return (
        <EmailCheck code={code} />
      );
    }
  }

  function EmailCheck(props) {
    const { code } = props;
    const checkEmail = (e) => {
      const input = e.target.value;
      const passText = document.querySelector("#email-info-box");
      if (code === input) {
        setAble(passText, "인증번호가 확인되었습니다.");
        setEmailPass(true);
      } else {
        setUnable(passText, "인증번호가 틀렸습니다.");
        setEmailPass(false);
      }
    };
    return (
      <input
        type="text"
        id="email-check-input"
        onChange={checkEmail}
        placeholder="인증번호"
      />
    );
  }

  //* 성별 클릭시
  const handleGender = (e) => {
    setGenderPass(true);
  };
  //* 생년 체크
  const handleBornAt = (e) => {
    e.target.value = e.target.value.replaceAll(/[^0-9]/g, "");
    const passText = document.querySelector("#bornAt-info-box");
    if (e.target.value < 1900 || e.target.value > new Date().getFullYear()) {
      setUnable(passText, "올바른 생년을 입력해주세요");
      setBornAtPass(false);
    } else {
      setAble(passText, "");
      setBornAtPass(true);
    }
  };

  //* handleSwitchTbody
  const handleSwitchTbody = (e) => {
    const firstTable = document.querySelector("#first-form");
    const secondTable = document.querySelector("#second-form");
    firstTable.classList.toggle("invisible");
    secondTable.classList.toggle("invisible");
  };

  return (
    <div className="table-wrapper">
      <table id="form-root">
        <tbody id="first-form">
          <InputRow title="아이디">
            <input
              type="text"
              name="id"
              id="id"
              onChange={handleId}
              placeholder="사용할 아이디를 입력해주세요."
              required
            />
          </InputRow>
          <InfoRow title="id-info-box" />
          <InputRow title="비밀번호">
            <input
              type="password"
              name="password"
              id="password"
              onChange={handlePassword}
              placeholder="영문, 숫자, 특수문자를 포함한 비밀번호를 입력해주세요."
              required
            />
          </InputRow>
          <InfoRow title="password-info-box" />
          <InputRow title="비밀번호 확인">
            <input
              type="password"
              id="passwordCheck"
              onChange={handlePasswordCheck}
              placeholder="비밀번호를 다시 입력해주세요."
              required
            />
          </InputRow>
          <InfoRow title="password-check-info-box" />
          <InputRow title="이름(닉네임)">
            <input
              type="text"
              name="name"
              id="name"
              onChange={handleNickname}
              placeholder="닉네임을 입력해주세요."
              required
            />
          </InputRow>
          <InfoRow title="nickname-info-box" />
          <InputRow title="전화번호">
            <input
              type="text"
              name="phone"
              id="phone"
              onChange={handlePhone}
              placeholder="(-)없이 휴대전화번호를 입력해주세요."
              required
            />
          </InputRow>
          <InfoRow title="phone-info-box" />
          <InputRow title="이메일">
            <div className="flex-box no-margin">
              <input
                type="text"
                name="email"
                id="email"
                placeholder="이메일을 입력해주세요"
              />
              <EmailComponent />
            </div>
          </InputRow>
          <InfoRow title="email-info-box" />
          <InputRow title="성별">
            <div className="flex-box">
              <label htmlFor="gender-male">&nbsp;남 : </label>
              <input
                type="radio"
                name="gender"
                id="gender-male"
                value="M"
                onClick={handleGender}
                required
              />
              &nbsp;
              <label htmlFor="gender-female">여 : </label>
              <input
                type="radio"
                name="gender"
                id="gender-female"
                value="F"
                onClick={handleGender}
                required
              />
            </div>
          </InputRow>
          <InfoRow title="gender-info-box" />
          <InputRow title="출생년도">
            <input
              type="text"
              name="bornAt"
              id="born-at"
              onChange={handleBornAt}
              placeholder="2000"
            />
          </InputRow>
          <InfoRow title="bornAt-info-box" />
          <InfoRow title="spacer" />
          <tr>
            <td colSpan={2}>
              <div className="flex-box centerize">
                <button
                  type="button"
                  className="big-button"
                  id="next-button"
                  onClick={handleSwitchTbody}
                >
                  다음
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
      <table>
        <tbody id="second-form" className="invisible">
          <tr>
            <th>
              <div className="th-wrapper">선호 모임 지역 선택</div>
            </th>
            <th>
              <div className="th-wrapper">선호 음식 분야 선택</div>
            </th>
          </tr>
          <tr>
            <td>
              <div className="fav-wrapper" id="fav-district">
                <ToggleAll target="favDistrict" />
                <Checkboxs mode="favDistrict" />
              </div>
            </td>
            <td>
              <div className="fav-wrapper" id="fav-food-type">
                <ToggleAll target="favFoodType" />
                <Checkboxs mode="favFoodType" />
              </div>
            </td>
          </tr>
          <tr>
            <td colSpan={2}>
              <div className="flex-box-row button-div">
                <button type="button" id="back" onClick={handleSwitchTbody}>
                  뒤로 가기
                </button>
                <button id="submit-button">가입하기</button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}
function InputRow(props) {
  return (
    <tr>
      <td className="input-title-td">
        <div>{props.title}</div>
      </td>
      <td className="input-section">{props.children}</td>
    </tr>
  );
}
function InfoRow(props) {
  return (
    <tr>
      <td colSpan={2} className="info-text" id={props.title}></td>
    </tr>
  );
}

// name -> input의 name, id :
function Checkboxs(props) {
  const [checkbox, setCheckbox] = useState(undefined);
  const { mode } = props;
  let searchMode;
  if (mode === "favDistrict") {
    searchMode = "district/getAllDistrict";
  } else if (mode === "favFoodType") {
    searchMode = "foodtype/getAllFoodtype";
  }

  checkbox ||
    $.ajax({
      url: `${API_BASE_URL}/${searchMode}`,
      method: "GET",
      success(response) {
        const toRender = response.map((district) => {
          const { code, name, type } = district;
          const title = name ? name : type;
          return (
            <div className="individual-checkbox" key={code}>
              <input type="checkbox" name={mode} id={title} value={code} />
              &nbsp;
              <label htmlFor={title}>{title}</label>
            </div>
          );
        });
        setCheckbox(toRender);
      },
      error: console.log,
    });
  return <div className="checkbox-wrapper">{checkbox}</div>;
}

function ToggleAll(props) {
  const [toggleStatus, setToggleStatus] = useState(true);

  const toggleAll = (e) => {
    if (toggleStatus) {
      setToggleStatus(false);
    } else {
      setToggleStatus(true);
    }
    const targetCheckboxs = document.querySelectorAll(
      `[name="${props.target}"]`
    );
    targetCheckboxs.forEach((item) => {
      item.checked = toggleStatus;
    });
  };
  return (
    <div>
      <button type="button" id={`${props.target}-toggle`} onClick={toggleAll}>
        전체 선택
      </button>
    </div>
  );
}

export default MemberEnrollFrm;
