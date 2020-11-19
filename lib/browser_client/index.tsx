/* eslint-disable import/no-internal-modules */
import "core-js/stable";
import "regenerator-runtime/runtime";
import React from "react";
import {render} from "react-dom";
import {BrowserRouter} from "react-router-dom";
import {HelmetProvider} from "react-helmet-async";
import {ApolloProvider} from "@apollo/client";
import {RecoilRoot} from "recoil";

import {Application} from "@clumsy_chinchilla/elements";
import sdk from "./sdk";

render(
  <BrowserRouter>
    <HelmetProvider>
      <RecoilRoot>
        <ApolloProvider client={sdk}>
          <Application />
        </ApolloProvider>
      </RecoilRoot>
    </HelmetProvider>
  </BrowserRouter>,
  document.querySelector("#application")
);
