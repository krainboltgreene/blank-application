import React from "react";
import {storiesOf} from "@storybook/react";
import {BrowserRouter} from "react-router-dom";
import {text} from "@storybook/addon-knobs";
import Link from ".";

storiesOf("Link", module)
  .add("with relative href", () => <BrowserRouter>
    <Link href={text("href", "/help")}>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>)
  .add("with absolute href", () => <BrowserRouter>
    <Link href={text("href", "https://www.henosis.com")}>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>)
  .add("with no href", () => <BrowserRouter>
    <Link>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>);
