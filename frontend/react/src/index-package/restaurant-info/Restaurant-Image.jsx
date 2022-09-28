import { API_BASE_URL } from "../../configs/App-config.js";

/**
 * 
 * @param {image}파라미터로 image의 이름을 전달. undefined도 괜찮음.
 * @returns 
 */
function RestaurantImage(props) {
  // console.log(props);
  if (props.image) {
    // console.log("props.image = ",props.image);
    return (
      <div className="img-section">
        <img
          src={`${API_BASE_URL}/resources/upload/review/${props.image.imageName}`}
          alt="원본이미지 주소 문제"
        />
      </div>
    );
  } else {
    return (
      <div className="img-section">
        <img
          src={`${API_BASE_URL}/resources/image/no_img.svg`}
          alt="이거 이미지 주소 확인"
        />
      </div>
    );
  }
}
export default RestaurantImage;