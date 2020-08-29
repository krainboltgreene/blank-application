import React, {useState} from "react";
import {useDispatch} from "react-redux";
import {useMutation} from "@apollo/client";
import {Field} from "@clumsy_chinchilla/elements";
import createAccountMutation from "./createAccount.gql";

export default function SignUpForm () {
  const [createAccount, {loading: createAccountLoading, error: createAccountError, data: createAccountData}] = useMutation(createAccountMutation);
  const dispatch = useDispatch();
  const [email, setEmail] = useState("");
  const submitForm = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    await createAccount({variables: {input: {email}}});
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
      type="email"
      property="email"
      label="Email"
      inputAttributes={{readOnly: createAccountLoading, onChange: (event: React.FormEvent<HTMLFormElement>) => setEmail(event.target.value), autoComplete: "email", value: email}}
      value={email}
    />
    <section>
      <button disabled={createAccountLoading} className="btn btn-primary" type="submit">Sign Up</button>
    </section>
  </form>;
}
