import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Field} from "@clumsy_chinchilla/elements";
import createSessionMutation from "./createSessionMutation.gql";

export default function LoginForm () {
  const history = useHistory();
  const [, setCurrentAccount] = useRecoilState<string>(currentAccountAtom);
  const [createSession, {loading: createSessionLoading, error: createSessionError, data: createSessionData}] = useMutation(createSessionMutation);
  const [emailAddress, setEmailAddress] = useState("");
  const [password, setPassword] = useState("");
  const submitForm = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    await createSession({variables: {input: {emailAddress, password}}});
  };

  if (createSessionError && createSessionError.message !== "incorrect_credentials") {
    throw createSessionError;
  }

  useEffect(() => {
    if (createSessionData) {
      setCurrentAccount(createSessionData.createSession.id);
      history.push("/"); // TODO: This should be back instead
    }
  }, [createSessionData, setCurrentAccount, history]);

  return <form id="loginForm" onSubmit={submitForm}>
    <Field
      scope="loginForm"
      type="email"
      property="emailAddress"
      label="Email Address"
      inputAttributes={{readOnly: createSessionLoading, onChange: (event: React.FormEvent<HTMLFormElement>) => setEmailAddress(event.target.value), autoComplete: "email", value: emailAddress}}
      value={emailAddress}
    />
    <Field
      scope="loginForm"
      type="password"
      property="password"
      label="Password"
      inputAttributes={{readOnly: createSessionLoading, onChange: (event: React.FormEvent<HTMLFormElement>) => setPassword(event.target.value), autoComplete: "currentPassword", value: password}}
      value={password}
    />
    <section>
      <button disabled={createSessionLoading} className="btn btn-primary" type="submit">Login</button>
    </section>
  </form>;
}
