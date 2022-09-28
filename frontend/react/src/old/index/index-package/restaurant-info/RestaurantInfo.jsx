import { useState } from "react";
import { API_BASE_URL } from "../../configs/App-config.js";
import DongFormatter from "../functions/DongFormatter.js";
import Stars from "../stars/Stars.jsx";
/**
 * 이 부분은 음식점의 정보를 찍는 컴포넌트이다.
 *
 *
 */
function RestaurantInfo(props) {
  const [xloc, setXloc] = useState(undefined);
  const { image, name, dong, foodType, reviewCount, avgScore } = props.children;
  const trimedAvgScore = Math.round(avgScore * 10) / 10;
  let dongMod = DongFormatter(dong);
  let nameMod = name;
  if(nameMod.length > 9){
    nameMod = nameMod.substring(0,9) + "..."
  }

  const redirect =()=>{
    window.location.href = `${API_BASE_URL}/restaurant/loadinfo?no=${props.children.restaurantNo}`;
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
    <div className="restaurant-info-wrapper" onMouseDown={saveXloc} onMouseUp={evalXloc}>
      <RestaurantImage image={image} />
      <div className="restaurant-info">
        <h2 className="restaurant-title">{nameMod}</h2>
        <div className="restaurant-loc-type">
          {dongMod} | {foodType}
        </div>
        {reviewCount === 0 ? (
          <div className="restaurant-score">아직 평가가 없습니다.</div>
        ) : (
          <div className="restaurant-score">
            {reviewCount}명의 평가 {trimedAvgScore}점
            <Stars score={trimedAvgScore} />
          </div>
        )}
      </div>
    </div>
  );
}

function RestaurantImage(props) {
  if (props.image) {
    return (
      <div className="img-section">
        <img
          src={`${API_BASE_URL}/resources/image/review/${props.image}`}
          alt="원본이미지 주소 문제"
          width="175px"
          height="175px"
        />
      </div>
    );
  } else {
    return (
      <div className="img-section">
        <img
          src={`${API_BASE_URL}/resources/image/no_img.svg`}
          alt="이거 이미지 주소 확인"
          width="175px"
          height="175px"
        />
      </div>
    );
  }
}

export default RestaurantInfo;
