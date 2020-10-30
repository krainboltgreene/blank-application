/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import type {ReactNode} from "react";
import "./index.scss";

interface PropertiesType {
  children: ReactNode;
  id?: string;
}

export default function Page (properties: Readonly<PropertiesType>): JSX.Element {
  const {children, ...remainingProperties} = properties;

  return <main className="Page" {...remainingProperties}>
    {children}
  </main>;
}
