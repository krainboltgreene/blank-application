import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentSessionId as currentSessionIdAtom} from "@client/atoms";
import {Field} from "@client/elements";
import createAccountMutation from "./createAccountMutation.graphql";
import type {CreateAccountMutation} from "@client/types";

export default function SignUpForm (): JSX.Element {
  const history = useHistory();
  const setCurrentAccount = useSetRecoilState(currentSessionIdAtom);
  const [createAccount, {loading: createAccountLoading, error: createAccountError, data: createAccountData}] = useMutation<CreateAccountMutation>(createAccountMutation);
  const [emailAddress, setEmailAddress] = useState("");
  const [hasValidated, setHasValidated] = useState(false);
  const [isValid, setIsValid] = useState<boolean | null>(null);
  const [feedback, setFeedback] = useState<string | null>(null);


  useEffect(() => {
    if (createAccountError) {
      setIsValid(false);
      setHasValidated(true);
      switch (createAccountError.message) {
        case "email_address has already been taken":
          setHasValidated(true);
          setFeedback(createAccountError.message);
          break;
        default: {
          throw createAccountError;
        }
      }
    }
  }, [createAccountError, setFeedback, setHasValidated, setIsValid]);

  useEffect(() => {
    if (createAccountData) {
      setCurrentAccount(createAccountData.createAccount?.id ?? null);
      history.push("/");
    }
  }, [createAccountData, setCurrentAccount, history]);

  return <form id="signUpForm" className="row g-3" onSubmit={async (event): Promise<void> => {
    event.preventDefault();
    await createAccount({variables: {input: {emailAddress}}});
  }}>
    <Field
      scope="signUpForm"
      type="email"
      property="emailAddress"
      label="Email Address"
      hasValidated={hasValidated}
      isValid={isValid}
      feedback={feedback}
      inputAttributes={{
        readOnly: createAccountLoading,
        onChange: (event): void => {
          setEmailAddress(event.target.value);
        },
        autoComplete: "email",
        value: emailAddress,
      }}
    />
    <section>
      <button disabled={createAccountLoading} type="submit" className="btn btn-primary">Sign Up</button>
    </section>
  </form>;
}
