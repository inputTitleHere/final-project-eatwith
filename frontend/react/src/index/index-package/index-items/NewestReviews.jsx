import React, { useState } from "react";
import $ from "jquery";
import { API_BASE_URL } from "../configs/App-config.js";
import DongFormatter from "../functions/DongFormatter.js";
import RestaurantImage from "../restaurant-info/Restaurant-Image.jsx";
import Stars from "../stars/Stars.jsx";

function NewestReviews(props) {
  const [data, setData] = useState([]);
  const [currPage, setCurrPage] = useState(1);
  const [removeButton, setRemoveButton] = useState(false);

  const loadPage = (currPage) => {
    $.ajax({
      url: `${API_BASE_URL}/review/getNewestReviews`,
      data: {
        currPage: currPage,
      },
      method: "GET",
      success(response) {
        // console.log(response);
        const mapping = [];
        response.forEach((item, index) => {
          mapping.push(<ReviewItem item={item} key={`${currPage}_${index}`} />);
        });
        if (mapping.length < 6) {
          setRemoveButton(true);
        }
        setData([...data, ...mapping]);
      },
      error: console.log,
    });
  };

  const loadMoreReviews = () => {
    loadPage(currPage + 1);
    setCurrPage(currPage + 1);
    console.log(currPage);
  };

  //! 첫번쨰 로드시 데이터 로드 시도
  data.length || loadPage(currPage);

  return (
    <div className="content-wrapper" id="newest-reviews">
      <div className="inner-content">
        <h2 className="title">최신 리뷰</h2>
        <div className="review-wrapper">{data}</div>
      </div>
      {removeButton ? (
        ""
      ) : (
        <div className="expand-wrapper" onClick={loadMoreReviews}>
          <img
            src={API_BASE_URL + "/resources/image/misc/chevron_down.svg"}
            alt="아래꺽쇠 이미지 없음"
            width={25}
            height={25}
          />
          <span className="button-text">더 많은 리뷰 보기</span>
          <img
            src={API_BASE_URL + "/resources/image/misc/chevron_down.svg"}
            alt="아래꺽쇠 이미지 없음"
            width={25}
            height={25}
          />
        </div>
      )}
    </div>
  );
}

function ReviewItem(props) {
  const {
    restaurantName,
    restaurantDong,
    writer,
    overallScore,
    serviceScore,
    tasteScore,
    priceScore,
    content,
    reviewImages,
  } = props.item;
  return (
    <div className="individual-review">
      <h3 className="header">
        {restaurantName}{" "}
        <span className="lighter">{DongFormatter(restaurantDong)}</span>
      </h3>
      <div className="review-wrapper">
        <RestaurantImage image={reviewImages[0]} />
        <span className="bolder">{writer}</span>
        <Stars score={overallScore} />
        <ul className="mid-section">
          <li className="score-li">
            맛 <SingleStar /> {tasteScore}점
          </li>
          <li className="score-li">
            가격 <SingleStar /> {priceScore}
          </li>
          <li className="score-li">
            서비스 <SingleStar /> {serviceScore}
          </li>
        </ul>
        {content}
      </div>
    </div>
  );
}

function SingleStar(props) {
  return <span className="stars">{"\u2605"}</span>;
}

export default NewestReviews;
