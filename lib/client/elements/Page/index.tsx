/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import {Helmet} from "react-helmet-async";
import type {ReactNode} from "react";
import "./index.css";

interface PropertiesType {
  as: string;
  subtitle?: string;
  description?: string;
  kind?: "article" | "section";
  children: ReactNode;
}

export default function Page (properties: Readonly<PropertiesType>): JSX.Element {
  const {as} = properties;
  const {subtitle = ""} = properties;
  const {description = ""} = properties;
  const {kind} = properties;
  const {children} = properties;

  switch (kind) {
    case "article": {
      return <main className={`Page ${as}`}>
        <Helmet>
          <title>ClumsyChinchilla | {subtitle}</title>
          <meta name="description" content={description} />
        </Helmet>
        <section>{children}</section>
      </main>;
    }
    case "section": {
      return <main className={`Page ${as}`}>
        <Helmet>
          <title>ClumsyChinchilla | {subtitle}</title>
          <meta name="description" content={description} />
        </Helmet>
        <section>{children}</section>
      </main>;
    }
    default: {
      return <main className={`Page ${as}`}>
        <Helmet>
          <title>ClumsyChinchilla | {subtitle}</title>
          <meta name="description" content={description} />
        </Helmet>
        {children}
      </main>;
    }
  }
}
