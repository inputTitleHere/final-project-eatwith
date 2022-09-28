import React, { useState } from "react";
import $ from "jquery";
import { API_BASE_URL } from "../../configs/App-config.js";
import Slider from "react-slick";
import RestaurantInfo from "../restaurant-info/RestaurantInfo.jsx";

function NearClosureGatherings(props) {
  const [data, setData] = useState(undefined);

  if (!data) {
    $.ajax({
      url: `${API_BASE_URL}/gather/getNearClosure`,
      method: "GET",
      async: false,
      success(response) {
        // console.log(response);
        setData(response);
      },
      error: console.log,
    });
  }

  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
  };

  if (data) {
    return (
      <div className="inner-content">
        <h2 className="title">마감임박 모임!</h2>
        <Slider {...settings}>
          {data.map((item, index) => {
            return <GatherItem key={index}>{item}</GatherItem>;
          })}
        </Slider>
      </div>
    );
  } else {
    <div className="inner-content">
      <h2 className="title">마감임박 모임!</h2>
      --데이터 없음--
    </div>;
  }
}

/**
 * 카로셀 아이템 하나.
 *
 */
function GatherItem(props) {
  // console.log(props.children);

  return (
    <div className="carousel-item">
      <RestaurantInfo>{props.children}</RestaurantInfo>
      <GatherInfo>{props.children}</GatherInfo>
    </div>
  );
}

function GatherInfo(props) {
  const [xloc, setXloc] = useState(undefined);
  const { no, title, enrolledCount, count, meetDate, content } = props.children;
  let modMeetDate = meetDate.split(/[-T:]/);
  modMeetDate[5] = modMeetDate[3] < 12 ? "오전" : "오후";
  modMeetDate[3] = modMeetDate[3] > 12 ? modMeetDate[3] - 12 : modMeetDate[3];

  modMeetDate = `${modMeetDate[0]}년 ${parseInt(modMeetDate[1],10)}월 ${parseInt(modMeetDate[2], 10)}일 ${modMeetDate[5]} ${modMeetDate[3]}:${modMeetDate[4]}`;

  const redirect =()=>{
    console.log(props.children);
    window.location.href = `${API_BASE_URL}/gather/gatherDetail?no=${no}`;
  }
  const saveXloc=(e)=>{
    setXloc(e.clientX);
  }
  const evalXloc=(e)=>{
    if(Math.abs(e.clientX - xloc)<5){
      redirect();
    }
  }

  return (
    <div className="gather-info" onMouseDown={saveXloc} onMouseUp={evalXloc} >
      <h2>{title}</h2>
      <div className="enrolled">
        <span className="bolder">모임 인원</span>
        ( {enrolledCount} / {count} )
      </div>
      <div className="gather-time">
        <span className="bolder">모임 시간</span>
          {modMeetDate}
      </div>
      <GatherRestrictions>{props.children}</GatherRestrictions>
      <div className="content">{content}</div>
    </div>
  );
}

function GatherRestrictions(props){
  const {genderRestriction, ageRestrictionTop, ageRestrictionBottom} = props.children;

  const gr = genderRestriction?genderRestriction==='M'?'남자':'여자':'성별무관';
  const ageRes = ageRestrictionBottom && ageRestrictionTop ? `${ageRestrictionBottom}살 ~ ${ageRestrictionTop}살` : "나이무관";
  return(
    <div className="restrictions">
      <span className="bolder">성별제한</span> {gr} 
      &nbsp;&nbsp;&nbsp;
      <span className="bolder">나이제한</span> {ageRes}
    </div>
  );

}

export default NearClosureGatherings;
