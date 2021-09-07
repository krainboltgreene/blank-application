/* eslint-disable react/jsx-props-no-spreading */
import type {ReactNode} from "react";
// import ComponentLink from "react-router-component-link";
import {Link as ReactRouterLink} from "react-router-dom";
import {startsWith} from "ramda";
import {omit} from "ramda";

const REMAINING_PROP_NAMES = [
  "href",
  "children",
];

interface PropertiesType {
  id?: string;
  children: ReactNode;
  href: string;
}

export default function Link (properties: Readonly<PropertiesType>): JSX.Element {
  const {id} = properties;
  const {children} = properties;
  const {href} = properties;
  const remainingProperties = omit(REMAINING_PROP_NAMES)(properties);

  if (startsWith("https")(href) || startsWith("http")(href)) {
    return <a id={id} data-element="Link" href={href} {...remainingProperties}>
      {children}
    </a>;
  }

  return <ReactRouterLink id={id} to={href} {...remainingProperties}>{children}</ReactRouterLink>;
}
