import React from "react";
import {Helmet} from "react-helmet-async";
import type {ReactNode} from "react";

const page = {
  color: "green",
  display: "grid",
};

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
      return <article css={[page, styling]} data-component={as}>
        <Helmet>
          {subtitle ? <title>ClumsyChinchilla | {subtitle}</title> : null}
          {description ? <meta name="description" content={description} /> : null}
        </Helmet>
        {children}
      </article>;
    }
    default: {
      return <main css={[page, styling]} data-component={as}>
        <Helmet>
          {subtitle ? <title>ClumsyChinchilla | {subtitle}</title> : null}
          {description ? <meta name="description" content={description} /> : null}
        </Helmet>
        2
        {children}
      </main>;
    }
  }
}
