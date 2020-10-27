import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Field} from "@clumsy_chinchilla/elements";
import createAccountMutation from "./createAccountMutation.gql";

export default function SignUpForm () {
  const history = useHistory();
  const [, setCurrentAccount] = useRecoilState<string>(currentAccountAtom);
  const [createAccount, {loading: createAccountLoading, error: createAccountError, data: createAccountData}] = useMutation(createAccountMutation);
  const [emailAddress, setEmailAddress] = useState("");
  const submitForm = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    createAccount({variables: {input: {emailAddress}}});
  };

  if (createAccountError) {
    throw createAccountError;
  }

  useEffect(() => {
    if (createAccountData) {
      setCurrentAccount(createAccountData.createAccount.id);
      history.push("/");
    }
  }, [createAccountData, setCurrentAccount, history]);

  return <form id="signUpForm" onSubmit={submitForm}>
    <Field
      scope="signUpForm"
      type="email"
      property="emailAddress"
      label="Email Address"
      inputAttributes={{readOnly: createAccountLoading, onChange: (event: React.FormEvent<HTMLFormElement>) => setEmailAddress(event.target.value), autoComplete: "email", value: emailAddress}}
      value={emailAddress}
    />
    <section>
      <button disabled={createAccountLoading} className="btn btn-primary" type="submit">Sign Up</button>
    </section>
  </form>;
}
