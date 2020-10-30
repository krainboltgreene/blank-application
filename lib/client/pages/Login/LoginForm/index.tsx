import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Field} from "@clumsy_chinchilla/elements";
import createSessionMutation from "./createSessionMutation.gql";

interface CreateSessionMutationType {
  createSession: {
    id: string;
  };
}

export default function LoginForm (): JSX.Element {
  const history = useHistory();
  const [, setCurrentAccount] = useRecoilState<string | null>(currentAccountAtom);
  const [createSession, {loading: createSessionLoading, error: createSessionError, data: createSessionData}] = useMutation<CreateSessionMutationType>(createSessionMutation);
  const [emailAddress, setEmailAddress] = useState("");
  const [password, setPassword] = useState("");

  if (createSessionError && createSessionError.message !== "incorrect_credentials") {
    throw createSessionError;
  }

  useEffect(() => {
    if (createSessionData) {
      setCurrentAccount(createSessionData.createSession.id);
      history.push("/"); // TODO: This should be back instead
    }
  }, [createSessionData, setCurrentAccount, history]);

  return <form id="loginForm" onSubmit={async (event): Promise<void> => {
    event.preventDefault();
    await createSession({variables: {input: {emailAddress, password}}});
  }}>
    <Field
      scope="loginForm"
      type="email"
      property="emailAddress"
      label="Email Address"
      hasValidated={false}
      inputAttributes={{readOnly: createSessionLoading, onChange: (event): void => setEmailAddress(event.target.value), autoComplete: "email", value: emailAddress}}
      value={emailAddress}
    />
    <Field
      scope="loginForm"
      type="password"
      property="password"
      label="Password"
      hasValidated={false}
      inputAttributes={{readOnly: createSessionLoading, onChange: (event): void => setPassword(event.target.value), autoComplete: "currentPassword", value: password}}
      value={password}
    />
    <section>
      <button disabled={createSessionLoading} className="btn btn-primary" type="submit">Login</button>
    </section>
  </form>;
}
