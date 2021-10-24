import React from "react";

import {Page} from "@clumsy_chinchilla/elements";
import AccountForm from "./AccountForm";

export default function MyAccount (): JSX.Element {
  return <Page as="MyAccount" subtitle="Settings">
    <h1>
      My Account
    </h1>
    <AccountForm />
  </Page>;
}
