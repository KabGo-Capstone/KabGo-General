import React from 'react';
import ReactDOM from 'react-dom/client';

import './index.css';

import App from './App';

import { BrowserRouter } from "react-router-dom";
import { Provider } from "react-redux";

import * as serviceWorkerRegistration from './serviceWorkerRegistration';
import reportWebVitals from './reportWebVitals';

import { store } from "~/store";
import { ConfigProvider } from "antd";
import {StyleProvider} from '@ant-design/cssinjs';

import '@fortawesome/fontawesome-free/css/all.min.css';
import { ApolloClient, InMemoryCache, ApolloProvider, gql } from '@apollo/client';

const client = new ApolloClient({
  uri: 'http://localhost:4003',
  cache: new InMemoryCache(),
});

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
root.render(
  <BrowserRouter>
    {/* <Provider store={store}> */}
      <ConfigProvider
        theme={{
          token: {
            fontFamily: "Montserrat",
            colorPrimary: '#F86C1D',
            fontSize: 13
          },
          components: {
            Button: {
              colorPrimary: '#F86C1D',
            },
            Table: {
              rowHoverBg: '#FFF4EF',
            },
          }
        }}>
          <StyleProvider hashPriority= "high">
            <ApolloProvider client={client}>
              <App />
            </ApolloProvider>
          </StyleProvider>
      </ConfigProvider>
    {/* </Provider> */}
  </BrowserRouter>
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://cra.link/PWA
serviceWorkerRegistration.unregister();

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
