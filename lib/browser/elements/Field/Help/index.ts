/* eslint-disable unicorn/no-null */
import React from "react";

export default function Help (properties) {
  const {id} = properties;
  const {children} = properties;

  if (children) {
    return <small id={`${id}-help`} className="form-text text-muted">{children}</small>;
  }

  return null;
}
