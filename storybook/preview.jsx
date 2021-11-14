import React from "react";
import {addDecorator} from "@storybook/react";
import {BrowserRouter} from "react-router-dom";
import {HelmetProvider} from "react-helmet-async";
import {ApolloProvider} from "@apollo/client";
import sdk from "./sdk";

addDecorator((story) => <BrowserRouter>
  <HelmetProvider>
    <ApolloProvider client={sdk}>
      <section>{story()}</section>
    </ApolloProvider>
  </HelmetProvider>
</BrowserRouter>);
