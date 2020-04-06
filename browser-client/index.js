/* eslint-disable import/no-extraneous-dependencies, import/no-unassigned-import, import/no-internal-modules */
import "core-js/stable";
import "regenerator-runtime/runtime";
import React from "react";
import {render} from "react-dom";
import {BrowserRouter} from "react-router-dom";
import {HelmetProvider} from "react-helmet-async";
import {Provider as ReduxProvider} from "react-redux";
import {ApolloProvider} from "@apollo/react-hooks";

import sdk from "./sdk";
import store from "./store";
import {Application} from "@internal/elements";

store.dispatch.database.initialize()
  .then(
    () => render(
      <BrowserRouter>
        <HelmetProvider>
          <ReduxProvider store={store}>
            <ApolloProvider client={sdk}>
              <Application />
            </ApolloProvider>
          </ReduxProvider>
        </HelmetProvider>
      </BrowserRouter>,
      document.querySelector("#application")
    )
  )
  .catch(console.error);
