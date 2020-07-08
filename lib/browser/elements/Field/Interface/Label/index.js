/* eslint-disable react/jsx-props-no-spreading */
import React from "react";

export default function Label (properties) {
  const {type} = properties;
  const {children} = properties;
  const {inputId} = properties;
  const {attributes} = properties;

  switch (type) {
    case "checkbox": {
      return <label {...attributes} htmlFor={inputId}>{children}</label>;
    }
    default: {
      return <label {...attributes} htmlFor={inputId}>{children}</label>;
    }
  }
}
