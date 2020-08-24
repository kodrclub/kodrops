import React from 'react';
import ReactDOM from 'react-dom';
import App from './app';

const version = process.env.REACT_APP_VERSION;

ReactDOM.render(<App version={version} />, document.getElementById('root'));
