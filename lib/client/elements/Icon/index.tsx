import React from "react";
import {compact} from "@unction/complete";

export default function Icon (properties) {
  const {type = "fas"} = properties;
  const {name} = properties;
  const {modifiers = []} = properties;

  return <span className={compact<string>([type, name, ...modifiers || []]).join(" ")} />;
}
