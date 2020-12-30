import React from "react";

import {Page} from "@clumsy_chinchilla/elements";
import SettingsForm from "./SettingsForm";

export default function Settings (): JSX.Element {
  return <Page as="Settings" subtitle="Settings">
    <h1>
      Settings
    </h1>
    <SettingsForm />
  </Page>;
}
