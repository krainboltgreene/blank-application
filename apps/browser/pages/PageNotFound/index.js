import React from "react";
import {Helmet} from "react-helmet-async";

import {Page} from "@henosis/elements";

export default function PageNotFound () {
  return <Page kind="article">
    <Helmet>
      <title>Page Not Found</title>
      <meta name="description" content="This page is for if the content you're requesting is not available." />
    </Helmet>
    <p>
      I&apos;m sorry, but we couldn&apos;t find that page.
    </p>
  </Page>;
}
