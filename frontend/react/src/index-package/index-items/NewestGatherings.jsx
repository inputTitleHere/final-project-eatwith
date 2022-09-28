import React, { useState } from "react";
import $ from "jquery";
import { API_BASE_URL } from "../../configs/App-config.js";

function NewestGatherings(props) {
  const [data, setData] = useState("");

  data ||
    $.ajax({
      url: `${API_BASE_URL}/gather/getNewestGatherings`,
      method: "GET",
      success(response) {
        // console.log(response);
        const processed = [];
        response.forEach((item, index) => {
          processed.push(<GatherItem item={item} key={index} />);
        });
        setData(processed);
      },
    });

  const toListPage=()=>{
    window.location.href=`${API_BASE_URL}/gather/gatherList`;
  };

  return (
    <div className="inner-content-ext">
      <h2 className="title">최신 모임</h2>
      <div id="newest-gather">{data}</div>
      <div id="button-section" onClick={toListPage}>
        <span>더 많은 모임 보기</span>
      </div>
    </div>
  );
}

//eslint-disable-next-line
function GatherItem(props) {
  const {
    ageRestrictionBottom,
    ageRestrictionTop,
    genderRestriction,
    // content,
    count: maxCount,
    districtName,
    restaurantName,
    enrolledCount,
    foodType,
    meetDate,
    no,
    title,
  } = props.item;

  const redirect = () => {
    window.location.href = `${API_BASE_URL}/gather/gatherDetail?no=${no}`;
  };

  const parseTime = (time) => {
    const splitted = time.split(/[-T:]/);
    return `${Number(splitted[1], 10)}월 ${splitted[2]}일 ${
      splitted[3] >= 12 ? "오후" : "오전"
    } ${splitted[3] > 12 ? splitted[3] - 12 : splitted[3]}:${splitted[4]}`;
  };
  const formatRestriction = () => {
    const result = [];
    if (ageRestrictionBottom) {
      const str = `나이제한 : ${ageRestrictionBottom}살 ~ ${ageRestrictionTop}살`;
      result.push(
        <span id="age-restriction" key={1}>
          {str}
        </span>
      );
    }
    if (genderRestriction) {
      const str = `성별제한 : ${
        genderRestriction === "F" ? "여성만" : "남성만"
      }`;
      result.push(
        <span id="gender-restriction" key={2}>
          {str}
        </span>
      );
    }
    if (result.length === 0) {
      result.push("누구나 참여가능합니다.");
    }
    return <div className="restrictions">{result}</div>;
  };

  return (
    <div className="gather-item" onClick={redirect}>
      <h2 className="title">
        {title.length >= 15 ? title.substring(0, 15) + "..." : title}
      </h2>
      <div>
        <span id="restaurant-name">{restaurantName}</span>
      </div>
      <div>
        <span id="district">{districtName}</span>
        <span id="food-type">{foodType}</span>
      </div>
      <div>
        <span id="meet-time">{parseTime(meetDate)}</span>
      </div>
      <div>
        <span id="people-count">
          모임인원 ( {enrolledCount} / {maxCount+1} )
        </span>
      </div>
      {formatRestriction()}
    </div>
  );
}

export default NewestGatherings;
