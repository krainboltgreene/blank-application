/* eslint-disable import/no-internal-modules */
import React from "react";
import {LightAsync as SyntaxHighlighter} from "react-syntax-highlighter";
import javascript from "react-syntax-highlighter/dist/esm/languages/hljs/javascript";
import Link from "../Link";

SyntaxHighlighter.registerLanguage("javascript", javascript);

export default function Exception ({kind, as, metadata}) {
  console.debug({as, metadata});

  if (kind === "overlay") {
    return <section id="exception" className="overlay">
      <h1>Something went wrong.</h1>

      <p>
        The web application you are using is having trouble running. We have been notified of the issue
        automatically, but we might need to reach out to you for more information. <Link href="https://public-issues.henosis.com">You can
        track the status of this issue by visiting our issue tracker at https://public-issues.henosis.com.</Link>
      </p>

      <p>
        If you&apos;re curious, the exception is:
      </p>

      <SyntaxHighlighter language="javascript">
        {as.message}
      </SyntaxHighlighter>
    </section>;
  }

  return "Something went wrong";
}
