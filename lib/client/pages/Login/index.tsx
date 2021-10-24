import React from "react";
import {useRecoilState} from "recoil";
import {useRecoilValue} from "recoil";
import {useHistory} from "react-router-dom";

import {currentSessionId as currentSessionIdAtom} from "@client/atoms";
import {warningMessages as warningMessagesAtom} from "@client/atoms";
import {Page} from "@client/elements";
import LoginForm from "./LoginForm";


export default function Login (): JSX.Element {
  const history = useHistory();
  const currentSessionId = useRecoilValue<string | null>(currentSessionIdAtom);
  const [warningMessages, setWarningMessage] = useRecoilState<Array<string>>(warningMessagesAtom);

  if (currentSessionId !== null) {
    setWarningMessage([...warningMessages, "You cannot create a new account while you're signed in."]);
    history.push("/");
  }

  return <Page as="Login" subtitle="Login">
    <h1>Login</h1>
    <LoginForm />
  </Page>;
}
