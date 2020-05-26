/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import "./index.scss";

export default function Page (properties) {
  const {children, ...remainingProperties} = properties;

  return <main className="Page" {...remainingProperties}>
    {children}
  </main>;
}
