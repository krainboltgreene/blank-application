import React from "react";
import {filter} from "ramda";

interface PropertiesType {
  type?: string;
  name: string;
  modifiers?: ReadonlyArray<string>;
}

export default function Icon (properties: Readonly<PropertiesType>): JSX.Element {
  const {type = "fas"} = properties;
  const {name} = properties;
  const {modifiers = []} = properties;
  const cssClasses = filter<string>(Boolean)([type, name, ...modifiers]);

  return <span className={cssClasses.join(" ")} />;
}
