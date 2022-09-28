import {API_BASE_URL} from "../../App-config.js";


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
    }else if(result.length===2){
      result.splice(1,0,<br key={3}/>)
    }
    return <div className="restrictions">{result}</div>;
  };

  return (
    <div className="gather-item" onClick={redirect}>
      <h2 className="title">
        {title.length >= 12 ? title.substring(0, 12) + "..." : title}
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

export default GatherItem;