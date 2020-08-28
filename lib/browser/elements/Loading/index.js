import React from "react";
import Icon from "../Icon";
import "./index.scss";

export default function Loading (properties) {
  const {kind} = properties;
  const {reason} = properties;

  if (kind === "overlay") {
    return <section id="loading" className="overlay" data-reason={}>
      <Icon name="fa-circle-notch" modifiers={["fa-spin fa-10x"]} />
    </section>;
  }

  return "Something went wrong";
}
