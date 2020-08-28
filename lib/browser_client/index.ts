/* eslint-disable no-console */
/* eslint-disable import/no-internal-modules */
import "core-js/stable";
import "regenerator-runtime/runtime";
import React from "react";
import {render} from "react-dom";
import {BrowserRouter} from "react-router-dom";
import {HelmetProvider} from "react-helmet-async";
import {Provider as ReduxProvider} from "react-redux";
import {ApolloProvider} from "@apollo/client";
import {RecoilRoot} from "recoil";


import {Application} from "@clumsy_chinchilla/elements";
import sdk from "./sdk";
import store from "./store";

store.dispatch.database.initialize()
  .then(() => console.info("Database loaded"))
  .catch(console.error);


render(
  <BrowserRouter>
    <HelmetProvider>
      <RecoilRoot>
        <ReduxProvider store={store}>
          <ApolloProvider client={sdk}>
            <Application />
          </ApolloProvider>
        </ReduxProvider>
      </RecoilRoot>
    </HelmetProvider>
  </BrowserRouter>,
  document.querySelector("#application")
);
