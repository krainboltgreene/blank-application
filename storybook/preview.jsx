import {addDecorator} from "@storybook/react";
import {BrowserRouter} from "react-router-dom";
import {HelmetProvider} from "react-helmet-async";
import {withA11y} from "@storybook/addon-a11y";
import {withKnobs} from "@storybook/addon-knobs";
import {ApolloProvider} from "@apollo/client";
import sdk from "./sdk";

addDecorator(withKnobs);
addDecorator(withA11y);
addDecorator((story) => <BrowserRouter>
  <HelmetProvider>
    <ApolloProvider client={sdk}>
      <section css={{padding: "25px"}}>{story()}</section>
    </ApolloProvider>
  </HelmetProvider>
</BrowserRouter>);
