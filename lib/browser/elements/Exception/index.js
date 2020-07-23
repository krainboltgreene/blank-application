import React from "react";
import Link from "../Link";

export default function Exception ({kind, as, metadata}) {
  console.debug({as, metadata});

  if (kind === "overlay") {
    return <section id="exception" className="overlay">
      <h1>Something went wrong.</h1>

      <p>
        The web application you are using is having trouble running. We have been notified of the issue
        automatically, but we might need to reach out to you for more information. <Link href="https://public-issues.clumsy_chinchilla.com">You can
        track the status of this issue by visiting our issue tracker at https://public-issues.clumsy_chinchilla.com.</Link>
      </p>
    </section>;
  }

  return "Something went wrong";
}