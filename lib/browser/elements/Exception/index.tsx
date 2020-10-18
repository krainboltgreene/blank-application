import React from "react";
import Link from "../Link";
import "./index.scss";

type PropertiesType = {
  kind: string,
  as: string,
  metadata?: {}
}

export default function Exception (properties: PropertiesType) {
  const {kind} = properties;
  const {as} = properties;
  const {metadata = {}} = properties;

  console.debug({as, metadata});

  if (kind === "overlay") {
    return <section className="Exception overlay">
      <h1>Something went wrong.</h1>

      <p>
        The web application you are using is having trouble running. We have been notified of the issue
        automatically, but we might need to reach out to you for more information. <Link href="https://public-issues.clumsy_chinchilla.com">You can
        track the status of this issue by visiting our issue tracker at https://public-issues.clumsy_chinchilla.com.</Link>
      </p>
    </section>;
  }

  return <p>Something went wrong</p>;
}