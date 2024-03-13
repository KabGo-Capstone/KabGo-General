import React from "react";
import ReactDOM from "react-dom/client";

import "./index.css";

import App from "./App";

import { BrowserRouter } from "react-router-dom";
import { Provider } from "react-redux";

import * as serviceWorkerRegistration from "./serviceWorkerRegistration";
import reportWebVitals from "./reportWebVitals";

import { store } from "~/store";
import { ConfigProvider } from "antd";
import { StyleProvider } from "@ant-design/cssinjs";

import "@fortawesome/fontawesome-free/css/all.min.css";
import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
  gql,
} from "@apollo/client";
import { Auth0ProviderWithNavigate } from "./components/Authentication/auth0-provider-with-navigate";

const client = new ApolloClient({
  uri: `${process.env.REACT_APP_BACKEND_HOST ?? "http://localhost:5003"}/graph`,
  cache: new InMemoryCache(),
});

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);
root.render(
  <BrowserRouter>
    {/* <Provider store={store}> */}
    <ConfigProvider
      theme={{
        token: {
          fontFamily: "Montserrat",
          colorPrimary: "#F86C1D",
          fontSize: 13,
        },
        components: {
          Button: {
            colorPrimary: "#F86C1D",
          },
          Table: {
            rowHoverBg: "#FFF4EF",
          },
        },
      }}
    >
      <StyleProvider hashPriority="high">
        <ApolloProvider client={client}>
          <Auth0ProviderWithNavigate>
            <App />
          </Auth0ProviderWithNavigate>
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
