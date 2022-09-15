import React from 'react';
import ReactDOM from 'react-dom/client';
import Index from './index-package/Index.jsx';

const root = ReactDOM.createRoot(document.getElementById('content-root'));
root.render(
  <React.StrictMode>
    <Index/>
  </React.StrictMode>
);

