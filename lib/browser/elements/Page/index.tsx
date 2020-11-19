import React from "react";
import {Helmet} from "react-helmet-async";
import type {ReactNode} from "react";
import "./index.scss";

interface PropertiesType {
  as: string;
  styling?: string;
  subtitle?: string;
  description?: string;
  kind?: "article";
  children: ReactNode;
}

export default function Page (properties: Readonly<PropertiesType>): JSX.Element {
  const {as} = properties;
  const {styling = ""} = properties;
  const {subtitle = ""} = properties;
  const {description = ""} = properties;
  const {kind} = properties;
  const {children} = properties;

  switch (kind) {
    case "article": {
      return <article className={[page, styling].join(" ")} data-component={as}>
        <Helmet>
          <title>ClumsyChinchilla | {subtitle}</title>
          <meta name="description" content={description} />
        </Helmet>
        {children}
      </article>;
    }
    default: {
      return <main className={[page, styling].join(" ")} data-component={as}>
        <Helmet>
          <title>ClumsyChinchilla | {subtitle}</title>
          <meta name="description" content={description} />
        </Helmet>
        {children}
      </main>;
    }
  }
}
