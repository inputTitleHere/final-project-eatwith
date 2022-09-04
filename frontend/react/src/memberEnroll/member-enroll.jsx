const { default: MemberEnrollFrm } = require("./MemberEnrollFrm.jsx");
import ReactDOM from 'react-dom/client';
import React from 'react';

//* 랜더링 부문

const root = ReactDOM.createRoot(document.querySelector("#form-wrapper"));
root.render(
  <div>
    <MemberEnrollFrm/>
  </div>
);

