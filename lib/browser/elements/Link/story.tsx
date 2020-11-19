/* eslint-disable func-style */
import React from "react";
import {BrowserRouter} from "react-router-dom";
import {text} from "@storybook/addon-knobs";
import Link from ".";

export default {title: "elements/Link"};
export function withRelativeHref (): JSX.Element {
  return <BrowserRouter>
    <Link href={text("href", "/help")}>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>;
}

export function withAbsoluteHref (): JSX.Element {
  return <BrowserRouter>
    <Link href={text("href", "https://www.clumsy_chinchilla.com")}>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>;
}
