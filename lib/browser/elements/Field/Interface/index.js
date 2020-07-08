import React from "react";

import Input from "./Input";

export default function Interface (properties) {
  const {type} = properties;
  const {label} = properties;
  const {inputId} = properties;
  const {labelAttributes} = properties;
  const {inputAttributes} = properties;

  switch (type) {
    case "checkbox": {
      return <section>
        <label inputId={inputId} className="checkbox" attributes={labelAttributes}>
          <Input id={inputId} type="checkbox" attributes={inputAttributes} />;
          {label}
        </label>
      </section>;
    }
    default: {
      return <>
        <label inputId={inputId} type="checkbox" attributes={labelAttributes}>
          {label}
        </label>
        <Input id={inputId} type="checkbox" attributes={inputAttributes} />;
      </>;
    }
  }
}
