import {useState} from "react";
import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Field} from "@clumsy_chinchilla/elements";
import createAccountMutation from "./createAccountMutation.gql";

interface CreateAccountMutationType {
  createAccount: {
    id: string;
  };
}

export default function SignUpForm (): JSX.Element {
  const history = useHistory();
  const setCurrentAccount = useSetRecoilState<string | null>(currentAccountAtom);
  const [createAccount, {loading: createAccountLoading, error: createAccountError, data: createAccountData}] = useMutation<CreateAccountMutationType>(createAccountMutation);
  const [emailAddress, setEmailAddress] = useState("");

  if (createAccountError) {
    throw createAccountError;
  }

  useEffect(() => {
    if (createAccountData) {
      setCurrentAccount(createAccountData.createAccount.id);
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
      <button disabled={createAccountLoading} className="btn btn-primary" type="submit">Sign Up</button>
    </section>
  </form>;
}
