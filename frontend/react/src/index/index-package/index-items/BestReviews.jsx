import React, {useState} from "react";
import $ from "jquery";
import { API_BASE_URL } from "../configs/App-config.js";
import Slider from "react-slick";
import "../css/slick.css";
import "../css/slick-theme.css";
import Stars from "../stars/Stars.jsx";
import RestaurantInfo from "../restaurant-info/RestaurantInfo.jsx";

function BestReviews(props) {
  const [data, setData] = useState(undefined);
  // console.log("LOADING BEST REVIEWS");
  if (!data) {
    $.ajax({
      url: `${API_BASE_URL}/review/getBestReviews`,
      method: "GET",
      async:false,
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
        <h2 className="title">Best 리뷰 TOP 5</h2>
        <Slider {...settings}>
          {data.map((item, index) => {
            return <ReviewItem key={index}>{item}</ReviewItem>;
          })}
        </Slider>
      </div>
    );
  } else {
    return (
      <div className="inner-content">
        <h2 className="title">Best 리뷰 TOP 5</h2>
        - 데이터 없음 -
      </div>
    );
  }
}

function ReviewItem(props) {
  return (
    <div className="carousel-item">
      <RestaurantInfo>{props.children}</RestaurantInfo>
      <ReviewInfo>{props.children}</ReviewInfo>
    </div>
  );
}

function ReviewInfo(props){
  const {writer, overallScore,tasteScore, serviceScore, priceScore,content} = props.children;
  return(
    <div className="review-info">
      <div className="top-section">
        <span className="writer">{writer}</span>
        <Stars score={overallScore}/>
      </div>
      <ul className="mid-section">
        <li className="score-li">
          맛 <SingleStar/> {tasteScore}점
        </li>
        <li className="score-li">
          가격 <SingleStar/> {priceScore}
        </li>
        <li className="score-li">
          서비스 <SingleStar/> {serviceScore}
        </li>
      </ul>
      <div className="bottom-section">
        <div className="review-content">
          {content}
        </div>
      </div>
    </div>
  )
}



function SingleStar(props){
  return(
    <span className="stars">{'\u2605'}</span>
  );
}




export default BestReviews;
