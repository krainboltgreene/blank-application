/* eslint-disable unicorn/no-null */
import React from "react";

export default function Feedback (properties) {
  const {isValid} = properties;
  const {children} = properties;
  const type = isValid ? "valid" : "invalid";

  if (children) {
    return <p className={`${type}-feedback`}>
      {children}
    </p>;
  }

  return null;
}
