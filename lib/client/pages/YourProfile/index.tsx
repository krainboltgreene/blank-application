import React from "react";

import {Page} from "@find_reel_love/elements";
import ProfileForm from "./ProfileForm";

export default function YourProfile (): JSX.Element {
  return <Page as="YourProfile" subtitle="Settings">
    <h1>
      Your Profile
    </h1>
    <ProfileForm />
  </Page>;
}
