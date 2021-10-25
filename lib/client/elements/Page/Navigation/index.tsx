import React from "react";
import {Link} from "@client/elements";

export default function Navigation (): JSX.Element {
  return <header className="navbar navbar-expand-lg navbar-light bg-light">
    <section className="container-fluid">
      <Link className="navbar-brand" href="/">Find Reel Love</Link>
    </section>
  </header>;
}
