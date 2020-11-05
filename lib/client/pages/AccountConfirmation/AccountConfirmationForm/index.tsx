import React from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
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
  const [, setCurrentAccount] = useRecoilState<string | null>(currentAccountAtom);
  const [confirmAccount, {loading: confirmAccountLoading, error: confirmAccountError, data: confirmAccountData}] = useMutation<confirmAccountMutationType>(confirmAccountMutation);
  const {confirmationSecret} = properties;

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
    await confirmAccount({variables: {input: {confirmationSecret}}});
  }}>
    <section>
      <button disabled={confirmAccountLoading} className="btn btn-primary" type="submit">Confirm Account</button>
    </section>
  </form>;
}