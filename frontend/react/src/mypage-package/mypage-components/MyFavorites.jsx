import { useState } from "react";
// import Restaurant from "./sub-components/Restaurant.jsx";
import GatherItem from "./sub-components/GatherItem.jsx";
import $ from "jquery";
import { API_BASE_URL } from "../App-config.js";

function MyFavorites(props) {
  const [data, setData] = useState();

  // const test = [1,2,3,4,5];
  // while(test.length>0){
  //   console.log(test.splice(0,4));
  // }

  data ||
    $.ajax({
      url: `${API_BASE_URL}/favoriteRestaurant/getFavoriteRestaurant`,
      method: "GET",
      xhrFields: {
        withCredentials: true,
      },
      success(response) {
        console.log("getFavRestaurant = ",response);
        // 한줄에 4칸씩 데이터 잘라 넣기
        const spliced = [];
        let counter = 0;
        while (response.length > 0) {
          spliced.push(<FavRow data={response.splice(0, 4)} key={counter} />);
          counter++;
        }
        // console.log(spliced);
        setData(spliced);

        // setData(response);
      },
      error: console.log,
    });

  return (
    <div className="myfavorites-wrapper">
      <h1>찜한 가게</h1>
      {data}
    </div>
  );
}

function FavRow({ data }) {
  // console.log(data);
  const [currentOpen, setCurrentOpen] = useState(undefined);
  const [rowData, setRowData] = useState('');
  const [windowMode, setWindowMode] = useState('close');
  const [currRestaurantNo, setCurrRestaurantNo] = useState('');
  /**
   * 
   * @param {event} e 
   * @param {string} no (restaurant no)
   * @returns 
   */
  const handleRestaurantClick=(e, no)=>{
    if(currentOpen===no){
      setCurrentOpen('');
      // console.log("closing");
      setRowData('');
      setWindowMode('close');
      setCurrRestaurantNo('');
      return;
    }
    setCurrentOpen(no);
    setWindowMode('open');
    setCurrRestaurantNo(no);
    $.ajax({
      url:`${API_BASE_URL}/gather/getRestaurantGathering`,
      data:{
        no:no
      },
      method:"GET",
      async:false,
      success(response){
        console.log(response);
        if(response.length===0){
          setRowData(
            <h2>모임이 없어요...</h2>
          )
        }else{
          setRowData(response.map((item)=>{
            return <GatherItem item={item} key={item.no} />
          }));
        }
      },
      error:console.log
    })

  }

  const toRestaurant=(e)=>{
    e.stopPropagation();
    window.location.href=`${API_BASE_URL}/restaurant/loadInfo?no=${currRestaurantNo}`;
  }

  return (
    <div className="favrow">
      <div className="favitem-wrapper">
        {data.map((item) => {
          return <FavItem data={item} key={item.no} handler={handleRestaurantClick}/>;
        })}
      </div>
      <div className={"favinfo "+windowMode}>
        <h1>이 가게의 모임 <button type="button" onClick={toRestaurant}>가게 페이지로 가기</button></h1>
        <div className="favinfo-content">
          {rowData}
        </div>
      </div>
    </div>
  );
}

function FavItem({ data,handler }) {
  // console.log(data);
  const [toggleFav, setToggleFav] = useState(true);
  const { no, image, foodName, districtName, name } = data;

  const handleFav=(e)=>{
    e.stopPropagation();
    $.ajax({
      url:`${API_BASE_URL}/favoriteRestaurant/toggleFavoriteRestaurant`,
      method:"POST",
      data:{
        restaurantNo:no,
        setTo:!toggleFav
      },
      xhrFields:{
        withCredentials:true
      },
      error:console.log
    })
    setToggleFav(!toggleFav);
  }


  return (
    <div className="favitem" onClick={(e)=>{handler(e,no)}}>
      <div className="image-wrapper">
        <ImageItem src={image} />
      </div>
      <div className="title">
        {name.length>10?name.substring(0,10)+"...":name}
      </div>
      <div className="info">
        <span className="left">{districtName}</span>
        <span className="right">{foodName}</span>
        <div className="fav-button-wrapper">
          {toggleFav ? (
            <img
              src={`${API_BASE_URL}/resources/image/misc/heart_red_fill.svg`}
              alt=""
              height={20}
              width={20}
              onClick={handleFav}
            />
          ) : (
            <img
              src={`${API_BASE_URL}/resources/image/misc/heart_red_empty.svg`}
              alt=""
              height={20}
              width={20}
              onClick={handleFav}
            />
          )}
        </div>
      </div>
    </div>
  );
}

function ImageItem({ src }) {
  if (src) {
    return (
      <img src={`${API_BASE_URL}/resources/upload/review/${src}`} alt="" />
    );
  } else {
    return <img src={`${API_BASE_URL}/resources/image/no_img.svg`} alt="" />;
  }
}

export default MyFavorites;
