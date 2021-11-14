import React from "react";
import {Helmet} from "react-helmet-async";
import type {ReactNode} from "react";
import Navigation from "./Navigation";
const PAGE_STYLING = "container";

interface PropertiesType {
  as: string;
  styling?: string;
  subtitle?: string;
  description?: string;
  kind?: "article";
  navbar?: boolean;
  children: ReactNode;
}

export default function Page (properties: Readonly<PropertiesType>): JSX.Element {
  const {as} = properties;
  const {styling = ""} = properties;
  const {subtitle = ""} = properties;
  const {description = ""} = properties;
  const {navbar = true} = properties;
  const {kind} = properties;
  const {children} = properties;
  const titleChange = <Helmet>
    {subtitle ? <title>We All Match | {subtitle}</title> : null}
    {description ? <meta name="description" content={description} /> : null}
  </Helmet>;

  switch (kind) {
    case "article": {
      return <>
        {navbar ? <Navigation /> : null}
        <article className={`${PAGE_STYLING} ${styling}`} data-component={as}>
          {navbar ? <Navigation /> : null}
          {titleChange}
          {children}
        </article>
      </>;
    }
    default: {
      return <>
        {navbar ? <Navigation /> : null}
        <main className={`${PAGE_STYLING} ${styling}`} data-component={as}>
          {titleChange}
          {children}
        </main>
      </>;
    }
  }
}
