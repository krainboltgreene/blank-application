/* eslint-disable react/jsx-props-no-spreading */
import {ReactNode} from "react";

type PropertiesType = {
  id: string,
  type: string,
  htmlFor: string,
  attributes?: {},
  children: ReactNode
}

export default function Label (properties: PropertiesType) {
  const {id} = properties;
  const {type} = properties;
  const {children} = properties;
  const {htmlFor} = properties;
  const {attributes} = properties;

  if (type === "checkbox" || type === "radio") {
    return <label id={id} htmlFor={htmlFor} className="form-check-label" {...attributes}>{children}</label>;
  }

  return <label id={id} htmlFor={htmlFor} {...attributes}>{children}</label>;
}
