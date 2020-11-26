import React from "react";
import Link from "../Link";

interface PropertiesType {
  kind: string;
  as: string | Error;
  metadata?: Readonly<Record<string, unknown>>;
}

const overlay = {
  display: "flex",
  justifyContent: "center",
  alignItems: "center",
  height: "100vh",
};

export default function Exception (properties: Readonly<PropertiesType>): JSX.Element {
  const {kind} = properties;
  const {as} = properties;
  const {metadata = {}} = properties;

  console.debug({as, metadata});

  if (kind === "overlay") {
    return <section css={overlay}>
      <h1>Something went wrong.</h1>

      <p>
        The web application you are using is having trouble running. We have been notified of the issue
        automatically, but we might need to reach out to you for more information. <Link href="https://public-issues.clumsy-chinchilla.club">You can
        track the status of this issue by visiting our issue tracker at https://public-issues.clumsy-chinchilla.club</Link>
      </p>
    </section>;
  }

  return <p>Something went wrong</p>;
}
