import {Page} from "@clumsy_chinchilla/elements";
import LogoutForm from "./LogoutForm";

export default function Logout (): JSX.Element {
  return <Page as="Logout" subtitle="Logout" kind="article">
    <h1>
      Logout
    </h1>

    <LogoutForm />
  </Page>;
}
