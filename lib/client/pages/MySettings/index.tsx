import React from "react";
import {Page} from "@client/elements";
import SettingsForm from "./SettingsForm";

export default function MySettings (): JSX.Element {
  return <Page as="MySettings" subtitle="Settings">
    <h1>
      Your Settings
    </h1>
    <SettingsForm />
  </Page>;
}
