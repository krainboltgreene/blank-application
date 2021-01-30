import React from "react";
import {useRecoilState} from "recoil";
import {useRecoilValue} from "recoil";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {warningMessages as warningMessagesAtom} from "@clumsy_chinchilla/atoms";
import {Page} from "@clumsy_chinchilla/elements";
import SignUpForm from "./SignUpForm";


export default function SignUp (): JSX.Element {
  const history = useHistory();
  const currentAccount = useRecoilValue<string | null>(currentAccountAtom);
  const [warningMessages, setWarningMessage] = useRecoilState<Array<string>>(warningMessagesAtom);

  if (currentAccount !== null) {
    setWarningMessage([...warningMessages, "You cannot create a new account while you're signed in."]);
    history.push("/");
  }

  return <Page as="SignUp" subtitle="Sign Up">
    <SignUpForm />
  </Page>;
}
