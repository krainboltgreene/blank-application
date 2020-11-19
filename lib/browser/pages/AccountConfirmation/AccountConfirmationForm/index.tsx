import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Field} from "@clumsy_chinchilla/elements";
import confirmAccountMutation from "./confirmAccountMutation.gql";

interface confirmAccountMutationType {
  confirmAccount: {
    id: string;
  };
}

interface PropertiesType {
  confirmationSecret: string;
}

export default function AccountConfirmationForm (properties: Readonly<PropertiesType>): JSX.Element {
  const history = useHistory();
  const setCurrentAccount = useSetRecoilState<string | null>(currentAccountAtom);
  const [confirmAccount, {loading: confirmAccountLoading, error: confirmAccountError, data: confirmAccountData}] = useMutation<confirmAccountMutationType>(confirmAccountMutation);
  const {confirmationSecret} = properties;
  const [password, setPassword] = useState("");

  if (confirmAccountError) {
    throw confirmAccountError;
  }

  useEffect(() => {
    if (confirmAccountData) {
      setCurrentAccount(confirmAccountData.confirmAccount.id);
      history.push("/");
    }
  }, [confirmAccountData, setCurrentAccount, history]);

  return <form id="accountConfirmationForm" onSubmit={async (event): Promise<void> => {
    event.preventDefault();
    await confirmAccount({variables: {input: {confirmationSecret, password}}});
  }}>
    <Field
      scope="accountConfirmationForm"
      type="password"
      property="password"
      label="Password"
      hasValidated={false}
      inputAttributes={{readOnly: confirmAccountLoading, onChange: (event): void => setPassword(event.target.value), autoComplete: "newPassword", value: password}}
      value={password}
    />
    <section>
      <button disabled={confirmAccountLoading} className="btn btn-primary" type="submit">Confirm Account</button>
    </section>
  </form>;
}
