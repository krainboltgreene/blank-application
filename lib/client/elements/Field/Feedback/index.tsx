/* eslint-disable unicorn/no-null */
import React from "react";
import "./index.scss";


export default function Feedback (properties) {
  const {isValid} = properties;
  const {children} = properties;
  const type = isValid ? "valid" : "invalid";

  if (children) {
    return <p data-state={type} className="Feedback">
      {children}
    </p>;
  }

  return null;
}
