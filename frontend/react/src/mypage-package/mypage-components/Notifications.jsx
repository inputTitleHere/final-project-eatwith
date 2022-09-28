// import { NavLink } from "react-router-dom";

import { useState } from "react";
import $ from "jquery";
import { API_BASE_URL } from "../App-config.js";
import { useEffect } from "react";

function parseDay(jsonDate) {
  const strDate = jsonDate[0] + "-" + jsonDate[1] + "-" + jsonDate[2];
  const week = ["일", "월", "화", "수", "목", "금", "토"];
  const yoil = week[new Date(strDate).getDay()];
  return `${jsonDate[0]}년 ${jsonDate[1]}월 ${jsonDate[2]}일 ${yoil}요일`;
}

function Notification(props) {
  const [data, setData] = useState(undefined);

  useEffect(() => {
    console.log("CURRENT DATA = ", data);
  }, [data]);

  const handleDelete = (e, no) => {
    const filterd = data.filter((item) => item.no !== no);
    console.log("filtered = ", filterd);
    setData(filterd);
  };

  data ||
    $.ajax({
      url: `${API_BASE_URL}/notification/getNotifications`,
      method: "GET",
      xhrFields: {
        withCredentials: true,
      },
      success(response) {
        // console.log("response = ", response);
        setData(response);
        // setData(
        //   response.map((item, index) => {
        //     item.sentAt = parseDay(item.sentAt);
        //     return <NotificationItem key={index} data={item} ori={data}/>;
        //   })
        // );
      },
      error: console.log,
    });

  if (Array.isArray(data) && data.length > 0) {
    return (
      <div className="notification-wrapper">
        <h1>알림 페이지</h1>
        {data.map((item) => {
          if (Array.isArray(item.sentAt)) {
            item.sentAt = parseDay(item.sentAt);
          }
          // console.log(item.sentAt);
          return (
            <NotificationItem
              key={item.no}
              data={item}
              parentHandleDelete={handleDelete}
            />
          );
        })}
      </div>
    );
  } else {
    return (
      <div className="notification-wrapper">
        <h1>알림 페이지</h1>
        <h2>알림이 없습니다</h2>
      </div>
    );
  }
}

function NotificationItem(props) {
  const { no, readAt, sentAt, content, gatherNo, restaurantNo, type, title } =
    props.data;
  const [isOpen, setIsOpen] = useState(false);
  const [readMode, setReadMode] = useState(readAt ? "read" : "unread");
  const [isRead, setIsRead] = useState(readAt ? true : false);

  const handleClick = (e) => {
    if (isOpen) {
      // 이미 열려있으면
      setReadMode("read"); // 읽음처리
      setIsOpen(!isOpen); // 닫기
    } else {
      // 열려있지 않으면
      setReadMode("reading"); // 펼치기
      setIsOpen(!isOpen);
      if (!isRead) {
        // 읽은적 없으면
        $.ajax({
          url: `${API_BASE_URL}/notification/readNotification`,
          method: "POST",
          data: {
            no: no,
          },
          success(response) {
            setIsRead(true);
            // console.log("시간보내기 성공");
          },
          error: console.log,
        });
      }
    }
  };
  const toRestaurant = (e) => {
    e.stopPropagation();
    window.location.href = `${API_BASE_URL}/restaurant/loadInfo?no=${restaurantNo}`;
  };
  const toGather = (e) => {
    e.stopPropagation();
    window.location.href = `${API_BASE_URL}/gather/gatherDetail?no=${gatherNo}`;
  };

  const handleDelete = (e, no) => {
    // console.log("runHandleDelete!!");
    e.stopPropagation();
    console.log("TO DELETE + ",no);
    $.ajax({
      url:`${API_BASE_URL}/notification/deleteNotification`,
      method:"POST",
      data:{
        no:no
      },
      success(response){
        // console.log("삭제 성공....?");
      },
      error:console.log
    })

    
    setReadMode("squish");
    setTimeout(() => {
      props.parentHandleDelete(e, no);
    }, 300);
  };

  return (
    <div
      className={"notification-item clickable " + readMode}
      onClick={handleClick}
    >
      <div className="header">
        <span className="delete">
          <img
            src={`${API_BASE_URL}/resources/image/misc/x_circle_icon.svg`}
            alt="x버튼없음"
            width={30}
            height={30}
            onClick={(e) => handleDelete(e, no)}
          />
        </span>
        <span>{sentAt}</span>
        <span className="read-mode">
          {readMode === "read"
            ? "읽었음 "
            : readMode === "reading"
            ? "읽는 중"
            : readMode === "unread"
            ? "안 읽음"
            : " "}
        </span>
      </div>
      <div className="title">
        <span className="type">
          {type === "N"
            ? "알림"
            : type === "J"
            ? "참가"
            : type === "W"
            ? "경고"
            : "  "}
        </span>
        {title}
      </div>
      <div className="content">
        {content.split("\n").map((line, index) => {
          return (
            <div className="content-text" key={index}>
              {line}
              <br />
            </div>
          );
        })}
      </div>
      <div className="buttons">
        <button type="button" onClick={toRestaurant}>
          가게 페이지로
        </button>
        <button type="button" onClick={toGather}>
          모임 페이지로
        </button>
      </div>
    </div>
  );
}

export default Notification;
