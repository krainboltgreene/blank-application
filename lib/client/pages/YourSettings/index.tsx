import {Page} from "@find_reel_love/elements";
import SettingsForm from "./SettingsForm";

export default function YourSettings (): JSX.Element {
  return <Page as="YourSettings" subtitle="Settings">
    <h1>
      Your Settings
    </h1>
    <SettingsForm />
  </Page>;
}
