import React from "react";
import Link from "../Link";
import {style} from "./style.module.postcss";

export default function Navbar (): JSX.Element {
  return <nav className={style}>
    <Link id="NavbarBrandLink" href="/">Navbar</Link>
  </nav>;
}
