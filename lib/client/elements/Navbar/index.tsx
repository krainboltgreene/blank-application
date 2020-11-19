import React from "react";
import Link from "../Link";
import "./index.scss";

export default function Navbar (): JSX.Element {
  return <nav className="Navbar">
    <Link id="NavbarBrandLink" href="/">Navbar</Link>
  </nav>;
}
