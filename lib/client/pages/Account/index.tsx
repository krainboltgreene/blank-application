import React from "react";

import {Page} from "@client/elements";
import AccountForm from "./AccountForm";

interface PropertiesType {
  username: string;
}
export default function Account (properties: Readonly<PropertiesType>): JSX.Element {
  const {username} = properties;

  return <Page as="Account" subtitle="Settings">
    <h1>
      {username}
    </h1>
    <AccountForm />
  </Page>;
}
