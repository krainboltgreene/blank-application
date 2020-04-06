import React from "react";
import {graphql} from "@apollo/react-hoc";
import {useQuery} from "@apollo/react-hooks";
import {Helmet} from "react-helmet-async";
import query from "./index.gql";

import {Page} from "@internal/elements";
import {Link} from "@internal/elements";

const layoutStyle = {
  "display": "grid",
  "grid-template-rows": "1fr 1fr",
};

export default graphql(query)(function LandingPage () {
  const {loading, error, data} = useQuery(query);

  return <Page layoutStyle={layoutStyle}>
    <Helmet>
      <title>Example</title>
      <meta name="description" content="A description" />
    </Helmet>
    <section id="forOrganizations">
      a image
      <header css={{}}>
        <h1>Example For Business</h1>
      </header>
      introduction
      callToAction
    </section>
    <section id="forPlayers">
      b image
      <header css={{}}>
        <h1>Example For Players</h1>
      </header>
      introduction
      callToAction
    </section>
    <section id="remaining">
      <section css={{}}>
      showcase
      </section>

      <section css={{}} />

      <section css={{}}>
      review
      </section>

      <section css={{}}>
      feed
      </section>
    </section>
  </Page>;
});
