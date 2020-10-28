/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import {mapValues} from "@unction/complete";

type PropertiesType = {
  id: string,
  type: string,
  labelId: string,
  name: string,
  options?: Array<any>,
  value: any,
  multiple?: boolean,
  rows?: number,
  attributes?: {},
  onChange: (Event) => any
}

export default function Input (properties: PropertiesType) {
  const {type} = properties;
  const {labelId} = properties;
  const {id} = properties;
  const {options} = properties;
  const {multiple} = properties;
  const {rows} = properties;
  const {name} = properties;
  const {onChange} = properties;
  const {value} = properties;
  const {attributes} = properties;
  const helpId = `${id}-help`;

  if (type === "checkbox" || type === "radio") {
    return <input id={id} className="form-check-input" name={name} aria-labelledby={labelId} aria-describedby={helpId} type={type} value={value} onChange={onChange} {...attributes} />;
  }

  // TODO: Handle select change
  if (type === "select") {
    return <select id={id} className="form-control" name={name} aria-labelledby={labelId} aria-describedby={helpId} multiple={multiple} {...attributes}>
      {mapValues(({key, option}) => <option value={option} selected={value === key}>{key}</option>)(options)}
    </select>;
  }

  if (type === "textarea") {
    return <textarea id={id} className="form-control" name={name} aria-labelledby={labelId} aria-describedby={helpId} rows={rows} value={value} onChange={onChange} {...attributes} />;
  }

  return <input id={id} className="form-control" name={name} aria-labelledby={labelId} aria-describedby={helpId} type={type} value={value} onChange={onChange} {...attributes} />;
}
