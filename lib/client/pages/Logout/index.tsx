import {Page} from "@find_reel_love/elements";
import LogoutForm from "./LogoutForm";

export default function Logout (): JSX.Element {
  return <Page as="Logout" subtitle="Logout">
    <h1>
      Logout
    </h1>

    <LogoutForm />
  </Page>;
}
