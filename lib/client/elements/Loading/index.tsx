import React from "react";
import Icon from "../Icon";
import "./index.scss";

interface PropertiesType {
  kind: string;
}

export default function Loading (properties: Readonly<PropertiesType>): JSX.Element {
  const {kind} = properties;

  if (kind === "overlay") {
    return <section id="loading" className="overlay">
      <Icon name="fa-circle-notch" modifiers={["fa-spin fa-10x"]} />
    </section>;
  }

  return <p>Something went wrong.</p>;
}
