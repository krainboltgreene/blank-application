import React, {useState} from "react";
import {useDispatch} from "react-redux";
import {useMutation} from "@apollo/client";
import {Field} from "@clumsy_chinchilla/elements";
import createAccountMutation from "./createAccount.gql";

export default function SignUpForm () {
  const [createAccount, {loading: createAccountLoading, error: createAccountError, data: createAccountData}] = useMutation(createAccountMutation);
  const dispatch = useDispatch();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const submitForm = async (event) => {
    event.preventDefault();
    await createAccount({variables: {email}});
  };

  if (createAccountError) {
    return <section>Error...</section>;
  }

  if (createAccountData) {
    dispatch({type: "resources/write", payload: createAccountData});

    return <section>{JSON.stringify(createAccountData)}</section>;
  }

  return <form id="signUpForm" onSubmit={submitForm}>
    <Field
      scope="signUpForm"
      attribute="email"
      type="email"
      label="Email"
      autoComplete="email"
      readOnly={createAccountLoading}
      onChange={(event) => setEmail(event.target.value)}
      value={email}
    />
    <Field
      scope="signUpForm"
      attribute="password"
      type="password"
      label="Password"
      autoComplete="new-password"
      readOnly={createAccountLoading}
      onChange={(event) => setPassword(event.target.value)}
      value={password}
    />
    <section>
      <button disabled={createAccountLoading} className="btn btn-primary" type="submit">Sign Up</button>
    </section>
  </form>;
}
