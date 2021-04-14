import {useState} from "react";
import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentSessionId as currentSessionIdAtom} from "@find_reel_love/atoms";
import {Field} from "@find_reel_love/elements";
import createAccountMutation from "./createAccountMutation.gql";
import type {CreateAccountMutation} from "./CreateAccountMutation.d";

export default function SignUpForm (): JSX.Element {
  const history = useHistory();
  const setCurrentAccount = useSetRecoilState(currentSessionIdAtom);
  const [createAccount, {loading: createAccountLoading, error: createAccountError, data: createAccountData}] = useMutation<CreateAccountMutation>(createAccountMutation);
  const [emailAddress, setEmailAddress] = useState("");

  if (createAccountError) {
    throw createAccountError;
  }

  useEffect(() => {
    if (createAccountData) {
      setCurrentAccount(createAccountData.createAccount?.id ?? null);
      history.push("/");
    }
  }, [createAccountData, setCurrentAccount, history]);

  return <form id="signUpForm" onSubmit={async (event): Promise<void> => {
    event.preventDefault();
    await createAccount({variables: {input: {emailAddress}}});
  }}>
    <Field
      scope="signUpForm"
      type="email"
      property="emailAddress"
      label="Email Address"
      hasValidated={false}
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
      <button disabled={createAccountLoading} type="submit">Sign Up</button>
    </section>
  </form>;
}
