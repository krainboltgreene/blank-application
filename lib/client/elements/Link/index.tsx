/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
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

const LINK_STYLES = "text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-base font-medium rounded-md";

export default function Link (properties: Readonly<PropertiesType>): JSX.Element {
  const {id} = properties;
  const {children} = properties;
  const {href} = properties;
  const remainingProperties = omit(REMAINING_PROP_NAMES)(properties);

  if (startsWith("https")(href) || startsWith("http")(href)) {
    return <a className={LINK_STYLES} id={id} data-element="Link" href={href} {...remainingProperties}>
      {children}
    </a>;
  }

  return <ReactRouterLink className={LINK_STYLES} id={id} to={href} {...remainingProperties}>{children}</ReactRouterLink>;
}
