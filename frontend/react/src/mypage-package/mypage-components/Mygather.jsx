import { useState } from "react";
import { API_BASE_URL } from "../App-config.js";
import GatherItem from "./sub-components/GatherItem.jsx";

function Mygather(props) {
  const [currentGather, setCurrentGather] = useState(undefined);
  const [pastGather, setPastGather] = useState([]);
  const [cPage, setCPage] = useState(1);
  const [isLast,setIsLast] = useState(false);

  currentGather ||
    fetch(`${API_BASE_URL}/gather/getMyGather`, {
      credentials: "include",
    })
      .then((response) => response.json())
      .then((data) => {
        // console.log(data);
        setCurrentGather(
          data.map((item, index) => {
            return <GatherItem item={item} key={index} />;
          })
        );
      });

  const fetchPastGather=(currPage)=>{
    console.log("currPage",currPage);
    fetch(
      `${API_BASE_URL}/gather/getMyGatherPast?` +
        new URLSearchParams({
          cPage: currPage,
        }),
      {
        credentials: "include",
      }
    )
      .then((response) => response.json())
      .then((data) => {
        console.log("MyGather data = ",data);
        if(data.length<8){
          setIsLast(true);
        }
        return data.map((item, index) => {
          return <GatherItem item={item} key={index} />;
        })
      }).then((data)=>{
        if(data.length>0){
          setPastGather([...pastGather,...data]);
        }
      })
  }

  pastGather.length>0 || fetchPastGather(cPage);

  const handleLoadMore =()=>{
    fetchPastGather(cPage+1);
    // console.log("LoadMore");
    setCPage(cPage+1);
  }

  return (
    <div className="mygather-wrapper">
      <h1>등록한 모임</h1>
      <h2>진행중인 모임</h2>
      <div className="current-gather">
        {currentGather}
      </div>
      <h2>지난 모임</h2>
      <div className={(isLast?"rounder ":"") + " past-gather"}>
        {pastGather}
      </div>
      <div className={`load-more `+(isLast?"hide":"")} onClick={handleLoadMore}>
        이전 모임 더 보기
      </div>
    </div>
  );
}

export default Mygather;
