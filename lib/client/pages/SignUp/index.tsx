import React from "react";
import {useRecoilState} from "recoil";
import {useRecoilValue} from "recoil";
import {useHistory} from "react-router-dom";

import {currentSessionId as currentSessionIdAtom} from "@client/atoms";
import {warningMessages as warningMessagesAtom} from "@client/atoms";
import {Page} from "@client/elements";
import SignUpForm from "./SignUpForm";


export default function SignUp (): JSX.Element {
  const history = useHistory();
  const currentSessionId = useRecoilValue<string | null>(currentSessionIdAtom);
  const [warningMessages, setWarningMessage] = useRecoilState<Array<string>>(warningMessagesAtom);

  if (currentSessionId !== null) {
    setWarningMessage([...warningMessages, "You cannot create a new account while you're signed in."]);
    history.push("/");
  }

  return <Page as="SignUp" subtitle="Sign Up">
    <h1>Sign Up</h1>
    <SignUpForm />
  </Page>;
}
