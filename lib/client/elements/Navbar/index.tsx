import React from "react";
import Link from "../Link";
import {styling} from "./index.module.scss";

export default function Navbar (): JSX.Element {
  return <nav className={styling}>
    <Link href="/">Navbar</Link>
  </nav>;
}
