import React from "react";
import Link from "../Link";
import {styling} from "./style.module.postcss";

export default function Navbar (): JSX.Element {
  return <nav className={styling}>
    <Link href="/">Navbar</Link>
  </nav>;
}
