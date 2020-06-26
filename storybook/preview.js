import React from "react";
import {addDecorator} from "@storybook/react";
import {Provider as ReduxProvider} from "react-redux";
import {BrowserRouter} from "react-router-dom";
import {HelmetProvider} from "react-helmet-async";
import {withA11y} from "@storybook/addon-a11y";
import {withKnobs} from "@storybook/addon-knobs";
import {ApolloProvider} from "@apollo/react-hooks";
import sdk from "./sdk";
import store from "./store";

addDecorator(withKnobs);
addDecorator(withA11y);
addDecorator((story) => <BrowserRouter>
  <HelmetProvider>
    <ReduxProvider store={store}>
      <ApolloProvider client={sdk}>
        <section css={{padding: "25px"}}>{story()}</section>
      </ApolloProvider>
    </ReduxProvider>
  </HelmetProvider>
</BrowserRouter>);
