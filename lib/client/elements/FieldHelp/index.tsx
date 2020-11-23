/* eslint-disable unicorn/no-null */
import React from "react";
import type {ReactNode} from "react";
import {styling} from "./index.module.scss";

interface PropertiesType {
  id: string;
  children: ReactNode;
}

export default function FieldHelp (properties: Readonly<PropertiesType>): JSX.Element | null {
  const {id} = properties;
  const {children} = properties;

  if (children === null) {
    return null;
  }

  return <small id={id} className={styling}>{children}</small>;
}
