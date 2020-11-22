import React from "react";
import type {ReactNode} from "react";
import {style} from "./style.module.postcss";

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

  return <small id={id} className={style}>{children}</small>;
}
