import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";
import {dig} from "@unction/complete";

import {account as accountAtom} from "@clumsy_chinchilla/atoms";
import {CheckboxField} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";
import updateAccountMutation from "./updateAccountMutation.gql";
import fetchAccountQuery from "./fetchAccountQuery.gql";
import type {UpdateAccountMutation} from "./UpdateAccountMutation";
import type {FetchAccountQuery} from "./FetchAccountQuery";

interface AccountType {
  id: string;
  lightMode: boolean;
}

export default function AccountForm (): JSX.Element {
  const [account, setAccount] = useRecoilState<AccountType | null>(accountAtom);
  const {loading: fetchAccountLoading, data: fetchAccountData, error: fetchAccountError} = useQuery<FetchAccountQuery>(fetchAccountQuery);
  const [updateAccount, {loading: updateAccountLoading, error: updateAccountError, data: updateAccountData}] = useMutation<UpdateAccountMutation>(updateAccountMutation);
  const {lightMode: savedLightMode = true} = dig<string, FetchAccountQuery | undefined, AccountType | undefined>(["session", "account", "account"])(fetchAccountData) ?? account ?? {};
  const {id} = dig<string, FetchAccountQuery | undefined, AccountType | undefined>(["session", "account", "account"])(fetchAccountData) ?? account ?? {};
  const [lightMode, setLightMode] = useState(savedLightMode);

  useEffect(() => {
    if (updateAccountData) {
      setAccount(updateAccountData.updateAccount);
    }
  }, [updateAccountData, setAccount, fetchAccountData]);
  useEffect(() => {
    if (fetchAccountData) {
      setAccount(fetchAccountData.account ?? null);
    }
  }, [fetchAccountData, setAccount]);

  if (fetchAccountError) {
    throw fetchAccountError;
  }

  if (updateAccountError?.message !== "incorrect_credentials") {
    // TODO: Actually handle real errors
    throw updateAccountError;
  }

  if (fetchAccountLoading) {
    return <Loading kind="block" />;
  }

  const onSubmit = async (event: React.FormEvent<HTMLFormElement>): Promise<void> => {
    event.preventDefault();
    await updateAccount({variables: {input: {id, lightMode}}});
  };
  const onChangeLightMode = (): void => {
    setLightMode(!lightMode);
  };

  return <form id="AccountForm" onSubmit={onSubmit}>
    <CheckboxField
      scope="AccountForm"
      property="lightMode"
      label="Light Mode"
      hasValidated={false}
      inputAttributes={{
        readOnly: updateAccountLoading,
        onChange: onChangeLightMode,
        autoComplete: "currentPassword",
        checked: lightMode,
      }}
    />
    <section>
      <button disabled={updateAccountLoading} type="submit">
        Save Account
      </button>
    </section>
  </form>;
}
