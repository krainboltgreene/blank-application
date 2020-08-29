/* eslint-disable react/jsx-props-no-spreading */
import React from "react";

export default function Label (properties) {
  const {type} = properties;
  const {children} = properties;
  const {htmlFor} = properties;
  const {attributes} = properties;

  if (type === "checkbox" || type === "radio") {
    return <label htmlFor={htmlFor} className="form-check-label" {...attributes}>{children}</label>;
  }

  return <label htmlFor={htmlFor} {...attributes}>{children}</label>;
}
