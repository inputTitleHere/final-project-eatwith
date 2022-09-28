import React from "react";
import {Route, Routes, NavLink} from "react-router-dom";
import EnrolledGather from "./EnrolledGather.jsx";
import MyFavorites from "./MyFavorites.jsx";
import Mygather from "./Mygather.jsx";
import Notification from "./Notifications.jsx";
import PasswordChange from "./PasswordChange.jsx";
import UserInfo from "./UserInfo.jsx";
import MemberSecede from "./MemberSecede.jsx";
import '../scss/mypage.scss'

export default function Mypage(){
 
  return(
    <div className="content-wrapper">
      <aside>
        <h1>마이페이지</h1>
        <ul>
          <li><NavLink end to="eatwith/mypage/" className={"lavender"}>알림</NavLink></li>
          <li><NavLink to="eatwith/mypage/myfavs" className={"rose"}>찜한 가게</NavLink></li>
          <li><NavLink to="eatwith/mypage/mygather" className={"indigo"}>등록한 모임</NavLink></li>
          <li><NavLink to="eatwith/mypage/enrolledGather" className={"indigo"}>참가한 모임</NavLink></li>
          <li><NavLink to="eatwith/mypage/userinfo" className={"orange"}>회원 정보 수정</NavLink ></li>
          <li><NavLink to="eatwith/mypage/password" className={"orange"}>비밀번호 수정</NavLink></li>
          <li><NavLink to="eatwith/mypage/secede" className={"lavender"}>회원 탈퇴</NavLink></li>
        </ul>
      </aside>
      <section>
        <Routes>
          <Route exact path="eatwith/mypage/" element={<Notification/>}/>
          <Route path="eatwith/mypage/myfavs"element={<MyFavorites/>}/>
          <Route path="eatwith/mypage/mygather" element={<Mygather/>}/>
          <Route path="eatwith/mypage/enrolledGather" element={<EnrolledGather/>}/>
          <Route path="eatwith/mypage/userinfo"element={<UserInfo/>}/>
          <Route path="eatwith/mypage/password" element={<PasswordChange/>}/>
          <Route path="eatwith/mypage/secede" element={<MemberSecede/>}/>
        </Routes>
      </section>
    </div>
  );
}



