/* eslint-disable unicorn/no-null */
import React from "react";
import {ReactChildren} from "react";
import "./index.scss";

type PropertiesType = {
  id: string,
  children: ReactChildren
}

export default function Help (properties: PropertiesType) {
  const {id} = properties;
  const {children} = properties;

  if (children) {
    return <small id={`${id}-help`} className="Help">{children}</small>;
  }

  return null;
}
