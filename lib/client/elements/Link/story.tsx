/* eslint-disable func-style */
import {BrowserRouter} from "react-router-dom";
import {text} from "@storybook/addon-knobs";
import Link from ".";

export default {title: "elements/Link"};
export function withRelativeHref () {
  return <BrowserRouter>
    <Link href={text("href", "/help")}>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>;
}

export function withAbsoluteHref () {
  return <BrowserRouter>
    <Link href={text("href", "https://www.clumsy-chinchilla.club")}>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>;
}

export function withNoHref () {
  return <BrowserRouter>
    <Link>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>;
}
