import React from "react";

import {Page} from "@clumsy_chinchilla/elements";
import AccountForm from "./AccountForm";

export default function Account (): JSX.Element {
  return <Page as="Account" subtitle="Settings">
    <h1>
      {username}
    </h1>
    <AccountForm />
  </Page>;
}
