import React from "react";

import {Page} from "@clumsy_chinchilla/elements";
import ProfileForm from "./ProfileForm";

export default function OwnProfile (): JSX.Element {
  return <Page as="OwnProfile" subtitle="Settings">
    <h1>
      Your Own Profile
    </h1>
    <ProfileForm />
  </Page>;
}
