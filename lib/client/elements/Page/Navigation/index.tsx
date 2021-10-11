import React from "react";
import {Link} from "@clumsy_chinchilla/elements";

export default function Navigation (): JSX.Element {
  return <header className="navbar navbar-expand-lg navbar-light bg-light">
    <section className="container-fluid">
      <Link className="navbar-brand" href="/">Clumsy Chinchilla</Link>
    </section>
  </header>;
}
