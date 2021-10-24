import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentSessionId as currentSessionIdAtom} from "@client/atoms";
import {Field} from "@client/elements";
import confirmAccountMutation from "./confirmAccountMutation.graphql";
import type {ConfirmAccountMutation} from "@client/types";

interface PropertiesType {
  confirmationSecret: string;
}

export default function AccountConfirmationForm (properties: Readonly<PropertiesType>): JSX.Element {
  const history = useHistory();
  const setCurrentAccount = useSetRecoilState(currentSessionIdAtom);
  const [confirmAccount, {loading: confirmAccountLoading, error: confirmAccountError, data: confirmAccountData}] = useMutation<ConfirmAccountMutation>(confirmAccountMutation);
  const {confirmationSecret} = properties;
  const [password, setPassword] = useState("");

  if (confirmAccountError) {
    throw confirmAccountError;
  }

  useEffect(() => {
    if (confirmAccountData) {
      setCurrentAccount(confirmAccountData.confirmAccount?.id ?? null);
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
      inputAttributes={{
        readOnly: confirmAccountLoading,
        onChange: (event): void => {
          setPassword(event.target.value);
        },
        autoComplete: "newPassword",
        value: password,
      }}
    />
    <section>
      <button disabled={confirmAccountLoading} type="submit" className="btn btn-primary">Confirm Account</button>
    </section>
  </form>;
}
