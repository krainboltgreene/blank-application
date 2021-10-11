import React from "react";
import Icon from "../Icon";

interface PropertiesType {
  kind: "overlay" | string;
}

export default function Loading (properties: Readonly<PropertiesType>): JSX.Element {
  const {kind} = properties;

  if (kind === "overlay") {
    return <section>
      <Icon name="fa-circle-notch" modifiers={["fa-spin fa-10x"]} />
    </section>;
  }

  return <p>Something is loading.</p>;
}
