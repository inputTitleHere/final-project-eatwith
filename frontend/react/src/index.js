import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter} from "react-router-dom";
import Mypage from './mypage-package/mypage-components/Mypage.jsx';
// import MemberEnrollFrm from "./register-package/MemberEnrollFrm.jsx";
// import Index from "./index-package/Index.jsx";

const root = ReactDOM.createRoot(document.getElementById("content-root"));
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Mypage />
    </BrowserRouter>
    {/* <Index/> */}
    {/* <MemberEnrollFrm/> */}
  </React.StrictMode>
);
