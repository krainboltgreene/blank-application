import {Page} from "@clumsy_chinchilla/elements";
import SettingsForm from "./SettingsForm";

export default function Settings (): JSX.Element {
  return <Page as="Settings" subtitle="Settings" kind="article">
    <h1>
      Settings
    </h1>
    <SettingsForm />
  </Page>;
}
