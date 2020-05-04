import React from "react";
import {graphql} from "@apollo/react-hoc";
import {useQuery} from "@apollo/react-hooks";
import {Helmet} from "react-helmet-async";

import {Page} from "@internal/elements";
// import {Link} from "@internal/elements";
import query from "./index.gql";
import "./index.scss";
import splash from "./splash.jpg";

export default graphql(query)(function LandingPage () {
  const {loading, error, data} = useQuery(query);

  return <Page id="landing-page">
    <Helmet>
      <title>Henosis</title>
      <meta name="description" content="A description" />
    </Helmet>

    <figure id="splash">
      <img src={splash} alt="The ISS floating in the complete emptiness of space" />
    </figure>

    <section id="pitch">
      <h1>Henosis</h1>
      <h2>We get you there</h2>
      <p>
        There&apos;s a lot to keep track of when building applications for a modern workplace. You
        need to make sure to follow best practices, be consistent with your team, test
        the important business logic, and safely deploy only working code (and in the case of
        failure, make sure the customer never sees a problem for long).
      </p>
      <p>
        You don&apos;t have to have a team of two hundred engineers to get there, though. With Henosis you
        leave those hard topics to us, with the understanding that you can back out at any time.
      </p>
    </section>
  </Page>;
});
