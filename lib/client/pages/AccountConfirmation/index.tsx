import {useLocation} from "react-router-dom";

import {Page} from "@clumsy_chinchilla/elements";
import AccountConfirmationForm from "./AccountConfirmationForm";

export default function AccountConfirmation (): JSX.Element {
  const {search} = useLocation<Location>();
  const searchParameters = new URLSearchParams(search);
  const token = searchParameters.get("token");

  // TODO: Figure out how to solve this problem
  if (token === null) {
    return <p>Something went wrong.</p>;
  }

  return <Page as="AccountConfirmation">
    <AccountConfirmationForm confirmationSecret={token} />
  </Page>;
}
