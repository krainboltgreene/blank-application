/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import {mapValues} from "@unction/complete";

export default function Input (properties) {
  const {type, labelId, descriptionId, id, options, multiple, rows, selected, name, ...remainingProperties} = properties;

  if (type === "select") {
    return <select id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} multiple={multiple} {...remainingProperties}>
      {mapValues(({key, value}) => <option value={value} selected={selected === key}>{key}</option>)(options)}
    </select>;
  }

  if (type === "textarea") {
    return <textarea id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} rows={rows} {...remainingProperties} />;
  }

  return <input id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} type={type} {...remainingProperties} />;
}
