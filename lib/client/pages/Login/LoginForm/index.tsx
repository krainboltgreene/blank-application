import {useState} from "react";
import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentSessionId as currentSessionIdAtom} from "@clumsy_chinchilla/atoms";
import {Field} from "@clumsy_chinchilla/elements";
import createSessionMutation from "./createSessionMutation.graphql";
import type {CreateSessionMutation} from "@clumsy_chinchilla/types";

export default function LoginForm (): JSX.Element {
  const history = useHistory();
  const setCurrentSessionId = useSetRecoilState(currentSessionIdAtom);
  const [createSession, {loading: createSessionLoading, error: createSessionError, data: createSessionData}] = useMutation<CreateSessionMutation>(createSessionMutation);
  const [emailAddress, setEmailAddress] = useState("");
  const [password, setPassword] = useState("");

  if (createSessionError && createSessionError.message !== "incorrect_credentials") {
    throw createSessionError;
  }

  useEffect(() => {
    if (createSessionData) {
      setCurrentSessionId(createSessionData.createSession?.id ?? null);
      history.push("/"); // TODO: This should be back instead
    }
  }, [createSessionData, setCurrentSessionId, history]);

  return <form id="loginForm" onSubmit={async (event): Promise<void> => {
    event.preventDefault();
    await createSession({variables: {input: {emailAddress, password}}});
  }}>
    {
      createSessionError ? <section>
        <p>
          {createSessionError.message}
        </p>
      </section> : null
    }
    <Field
      scope="loginForm"
      type="email"
      property="emailAddress"
      label="Email Address"
      hasValidated={false}
      inputAttributes={{
        readOnly: createSessionLoading,
        onChange: (event): void => {
          setEmailAddress(event.target.value);
        },
        autoComplete: "email",
        value: emailAddress,
      }}
    />
    <Field
      scope="loginForm"
      type="password"
      property="password"
      label="Password"
      hasValidated={false}
      inputAttributes={{
        readOnly: createSessionLoading,
        onChange: (event): void => {
          setPassword(event.target.value);
        },
        autoComplete: "currentPassword",
        value: password,
      }}
    />
    <section>
      <button disabled={createSessionLoading} type="submit">Login</button>
    </section>
  </form>;
}
