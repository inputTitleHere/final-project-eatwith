import { useState } from "react";
import $ from "jquery";
import { API_BASE_URL } from "../App-config.js";
import { useEffect } from "react";

function UserInfo(props) {
  const [originalName, setOriginalName] = useState("");
  const [values, setValues] = useState({
    no: "",
    id: "",
    password: "",
    email: "",
    name: "",
    phone: "",
    // point: "",
    gender: "",
    bornAt: "",
    favDistrict: "",
    favFoodType: "",
  });
  const [info, setInfo] = useState({ district: [], foodType: [] });
  const [showPwd, setShowPwd] = useState(false);
  const [nameCheck, setNameCheck] = useState(true);

  const { district, foodType } = info;

  //! 테스트용 쿠키
  // const date = new Date();
  // date.setTime(date.getTime() + 1000 * 60 * 60 * 24 * 7);
  // document.cookie = `no=144;expires=${date.toUTCString()};path=/eatwith`;

  useEffect(() => {
    $.ajax({
      url: `${API_BASE_URL}/mypage/currentUser`,
      method: "GET",
      success(response) {
        console.log(response);
        setValues(response);
        setOriginalName(response.name);
      },
      xhrFields: {
        withCredentials: true,
      },
      error: console.log,
    });
    $.ajax({
      url: `${API_BASE_URL}/mypage/loadInfo`,
      method: "GET",
      success(response) {
        console.log(response);
        setInfo(response);
      },
      error: console.log,
    });
  }, []);

  const handleInput = (e) => {
    // console.log(e.target);
    const { name, value } = e.target;
    setValues({ ...values, [name]: value });
  };
  const handleNumberInput = (e) => {
    //TODO 년도 확인은 submit때 하자.
    let { name, value } = e.target;
    if (value.length > 4) {
      value = value.substring(0, 4);
    }
    value = value.replace(/[^0-9]/g, "");
    setValues({ ...values, [name]: value });
  };
  const handleNameCheck = () => {
    const nameVal = document.querySelector("input#name").value;
    // console.log(nameVal);
    $.ajax({
      url: `${API_BASE_URL}/member/checkDuplicateNickname`,
      method: "GET",
      data: {
        nickname: nameVal,
      },
      success(response) {
        const { result } = response;
        console.log(result);
        if (result) {
          setNameCheck(true);
          document
            .querySelector("button#nameCheckBtn")
            .classList.remove("focus");
          alert("사용가능한 닉네임 입니다.");
        }
      },
    });
  };
  const handleNameInput = (e) => {
    const { name, value } = e.target;
    if (value === originalName) {
      setNameCheck(true);
    } else {
      setNameCheck(false);
    }
    setValues({ ...values, [name]: value });
  };

  const handleGenderChange=(e)=>{
    setValues({...values,'gender':e.target.value});
  }

  const togglePassword = () => {
    setShowPwd(!showPwd);
  };

  const closeWindow = () => {
    const alertArea = document.querySelector(".alert");
    alertArea.classList.add("hidden");
    alertArea.classList.remove("fade-in-box");
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // console.log("updateUser TODO");
    if (!values.password) {
      alert("비밀번호 확인을 입력해주세요!");
      document.querySelector("input#password").focus();
      return;
    }
    if (!nameCheck) {
      alert("닉네임 중복 확인을 해주세요.");
      document.querySelector("button#nameCheckBtn").classList.add("focus");
      return;
    }
    if (values.bornAt < 1900 || values.bornAt > new Date().getFullYear) {
      alert("출생년도를 확인해주세요");
      document.querySelector("input#bornAt").focus();
      return;
    }
    // 일반 확인 끝.
    // 비밀번호 확인
    let passwordPass = false;
    $.ajax({
      url: `${API_BASE_URL}/member/checkPassword`,
      method: "GET",
      data: {
        no: values.no,
        password: values.password,
      },
      async: false,
      success(response) {
        // console.log(response);
        if (!response) {
          alert("비밀번호가 틀렸습니다. 비밀번호를 맞게 입력하세요.");
          document.querySelector("input#password").focus();
          console.log("RETURNING PASSWORD");
        } else {
          passwordPass = response;
        }
      },
    });
    if (!passwordPass) {
      return;
    }
    console.log("PASSED PASSWORD");
    // 비밀번호 통과하였음
    // console.log("values => ",JSON.stringify(values));
    $.ajax({
      url: `${API_BASE_URL}/member/updateMember`,
      method: "PUT",
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify(values),
      success(response) {
        // alert("회원 정보를 변경하였습니다!");
        const alertSection = document.querySelector(".alert");
        alertSection.classList.remove("hidden");
        alertSection.classList.add("fade-in-box");
      },
      error: console.log,
    });
  };

  return (
    <div className="user-info-wrapper">
      <h1>회원 정보 수정</h1>
      <div className="change-user-info">
        <form onSubmit={handleSubmit}>
          <input type="hidden" name="no" value={values.no} id="no" />
          <table className="basic-info">
            <tbody>
              <tr>
                <td className="label">아이디</td>
                <td className="input">
                  <input
                    type="text"
                    name="id"
                    id="id"
                    value={values.id}
                    disabled
                  />
                </td>
              </tr>
              <tr>
                <td className="label">비밀번호 확인</td>
                <td className="input">
                  <input
                    type={showPwd ? "text" : "password"}
                    name="password"
                    id="password"
                    onChange={handleInput}
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
              <tr>
                <td className="label">이름(닉네임)</td>
                <td className="input">
                  <input
                    type="text"
                    name="name"
                    id="name"
                    value={values.name}
                    onChange={handleNameInput}
                  />
                </td>
                <td>
                  <button
                    type="button"
                    onClick={handleNameCheck}
                    id="nameCheckBtn"
                    disabled={nameCheck}
                  >
                    중복 확인
                  </button>
                </td>
              </tr>
              <tr>
                <td className="label">전화번호</td>
                <td className="input">
                  <input
                    type="text"
                    name="phone"
                    id="phone"
                    value={values.phone}
                    onChange={handleInput}
                  />
                </td>
              </tr>
              <tr>
                <td className="label">이메일</td>
                <td className="input">
                  <input
                    type="email"
                    name="email"
                    id="email"
                    value={values.email}
                    disabled
                    // onChange={handleInput}
                  />
                </td>
              </tr>
              <tr>
                <td className="label">성별</td>
                <td className="input">
                  <div className="gender-item">
                    <label htmlFor="genderM">남</label>
                    <input
                      type="radio"
                      name="gender"
                      id="genderM"
                      checked={values.gender === "M" ? "checked" : ""}
                      onChange={handleGenderChange}
                      value="M"
                    />
                    <span></span>
                    <label htmlFor="genderF">여</label>
                    <input
                      type="radio"
                      name="gender"
                      id="genderF"
                      checked={values.gender === "F" ? "checked" : ""}
                      onChange={handleGenderChange}
                      value="F"
                    />
                    
                  </div>
                </td>
              </tr>
              <tr>
                <td className="label">출생년도</td>
                <td className="input">
                  <input
                    type="text"
                    name="bornAt"
                    id="bornAt"
                    value={values.bornAt}
                    onChange={handleNumberInput}
                  />
                </td>
              </tr>
              <tr>
                <td colspan="2">※ 아이디와 이메일은 변경 불가능 합니다.</td>
              </tr>
            </tbody>
          </table>
          <div className="select-wrapper">
            <div className="district-wrapper">
              <h2>선호 모임 지역 선택</h2>
              <div className="district-selection">
                {district.map((item, index) => {
                  return (
                    <District
                      name={item.name}
                      code={item.code}
                      key={index}
                      selected={values.favDistrict}
                      values={values}
                      setValues={setValues}
                    ></District>
                  );
                })}
              </div>
            </div>
            <div className="foodtype-wrapper">
              <h2>선호 음식 분야 선택</h2>
              <div className="foodtype-selection">
                {foodType.map((item, index) => {
                  return (
                    <FoodType
                      type={item.type}
                      code={item.code}
                      key={index}
                      selected={values.favFoodType}
                      values={values}
                      setValues={setValues}
                    ></FoodType>
                  );
                })}
              </div>
            </div>
          </div>
          <div className="button-wrapper">
            <button type="submit">회원정보 수정하기</button>
          </div>
        </form>
      </div>
      <div className="alert hidden">
        <div className="alert-text">회원정보가 수정되었습니다.</div>
        <button type="button" onClick={closeWindow}>
          닫기
        </button>
      </div>
    </div>
  );
}

function District({ name, code, selected, values, setValues }) {
  const [checked, setChecked] = useState(selected.includes(code));
  const handleClick = (e) => {
    const district = values.favDistrict;
    if (checked) {
      // 현제 checked이면 클릭시 체크가 풀린다.
      const loc = district.indexOf(code);
      if (loc > -1) {
        district.splice(loc, 1);
      }
      setValues({ ...values, favDistrict: district });
    } else {
      // 체크가 안되어있으면 체크됨으로 변경될 것이므로 추가한다.
      district.push(code);
      setValues({ ...values, favDistrict: district });
    }
    setChecked(!checked);
  };
  return (
    <div className="district-item">
      <input
        type="checkbox"
        name="favDistrict"
        id={code}
        value={code}
        checked={checked ? "checked" : ""}
        onChange={handleClick}
      />
      <label htmlFor={code}>{name}</label>
    </div>
  );
}
function FoodType({ type, code, selected, values, setValues }) {
  const [checked, setChecked] = useState(selected.includes(code));
  const handleClick = (e) => {
    const foodType = values.favFoodType;
    if (checked) {
      // 현제 checked이면 클릭시 체크가 풀린다.
      const loc = foodType.indexOf(code);
      if (loc > -1) {
        foodType.splice(loc, 1);
      }
      setValues({ ...values, favFoodType: foodType });
    } else {
      // 체크가 안되어있으면 체크됨으로 변경될 것이므로 추가한다.
      foodType.push(code);
      setValues({ ...values, favFoodType: foodType });
    }
    setChecked(!checked);
  };
  return (
    <div className="foodtype-item">
      <input
        type="checkbox"
        name="favFoodType"
        id={code}
        value={code}
        checked={checked ? "checked" : ""}
        onChange={handleClick}
      />
      <label htmlFor={code}>{type}</label>
    </div>
  );
}

export default UserInfo;
