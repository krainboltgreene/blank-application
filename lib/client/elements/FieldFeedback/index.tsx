/* eslint-disable unicorn/no-null */
import React from "react";
import type {ReactNode} from "react";
import "./index.css";

interface PropertiesType {
  isValid: boolean | null;
  hasValidated: boolean;
  children: ReactNode | null;
}

export default function FieldFeedback (properties: Readonly<PropertiesType>): JSX.Element | null {
  const {hasValidated} = properties;
  const {isValid} = properties;
  const {children} = properties;

  if (children === null) {
    return null;
  }

  if (!hasValidated) {
    return null;
  }

  if (isValid === null) {
    return null;
  }

  const type = isValid ? "valid" : "invalid";

  return <p data-state={type} className="FieldFeedback">
    {children}
  </p>;
}
