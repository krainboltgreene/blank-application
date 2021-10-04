import React from "react";

import {Page} from "@clumsy_chinchilla/elements";
import ProfileForm from "./ProfileForm";

export default function MyProfile (): JSX.Element {
  return <Page as="MyProfile" subtitle="Settings">
    <h1>
      Your Profile
    </h1>
    <ProfileForm />
  </Page>;
}