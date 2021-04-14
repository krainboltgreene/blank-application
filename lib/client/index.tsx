import "core-js/stable";
import "regenerator-runtime/runtime";
import {render} from "react-dom";
import {BrowserRouter} from "react-router-dom";
import {HelmetProvider} from "react-helmet-async";
import {ApolloProvider} from "@apollo/client";
import {RecoilRoot} from "recoil";

import {Application} from "@find_reel_love/elements";
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
