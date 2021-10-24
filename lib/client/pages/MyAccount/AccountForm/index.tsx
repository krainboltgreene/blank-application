import React from "react";
import type {FormEvent} from "react";
import type {ChangeEvent} from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";

import {account as accountAtom} from "@client/atoms";
import {Field} from "@client/elements";
import {Loading} from "@client/elements";
import updateMyAccountMutation from "./updateMyAccountMutation.graphql";
import fetchMyAccountQuery from "./fetchMyAccountQuery.graphql";
import type {FetchMyAccountQuery} from "@client/types";
import type {UpdateMyAccountMutation} from "@client/types";

export default function AccountForm (): JSX.Element {
  const [account, setAccount] = useRecoilState(accountAtom);
  const {loading: fetchAccountLoading, data: fetchAccountData, error: fetchAccountError} = useQuery<FetchMyAccountQuery>(fetchMyAccountQuery);
  const [updateAccount, {loading: updateAccountLoading, error: updateAccountError, data: updateAccountData}] = useMutation<UpdateMyAccountMutation>(updateMyAccountMutation);
  const {emailAddress: savedEmailAddress} = account ?? {};
  const {id} = fetchAccountData?.session?.account ?? {};
  const [emailAddress, setEmailAddress] = useState(savedEmailAddress);

  useEffect(() => {
    if (typeof updateAccountData === "undefined" || updateAccountData === null) {
      return;
    }
    if (typeof updateAccountData.updateAccount === "undefined" || updateAccountData.updateAccount === null) {
      return;
    }
    setAccount(updateAccountData.updateAccount);
  }, [updateAccountData, setAccount, fetchAccountData]);
  useEffect(() => {
    if (typeof fetchAccountData === "undefined" || fetchAccountData === null) {
      return;
    }
    if (typeof fetchAccountData.session === "undefined" || fetchAccountData.session === null) {
      return;
    }
    setAccount(fetchAccountData.session.account);
  }, [fetchAccountData, setAccount]);

  if (fetchAccountError) {
    throw fetchAccountError;
  }

  if (updateAccountError && updateAccountError.message !== "incorrect_credentials") {
    // TODO: Actually handle real errors
    throw updateAccountError;
  }

  if (fetchAccountLoading) {
    return <Loading kind="block" />;
  }

  const onSubmit = async (event: FormEvent<HTMLFormElement>): Promise<void> => {
    event.preventDefault();
    await updateAccount({variables: {input: {id, emailAddress}}});
  };
  const onChangeEmailAddress = (event: ChangeEvent<HTMLInputElement>): void => {
    setEmailAddress(event.target.value);
  };

  return <form id="AccountForm" className="row g-3" onSubmit={onSubmit}>
    <Field
      type="text"
      scope="AccountForm"
      property="emailAddress"
      label="Email Address"
      hasValidated={false}
      inputAttributes={{
        readOnly: updateAccountLoading,
        onChange: onChangeEmailAddress,
      }}
    />
    <section>
      <button disabled={updateAccountLoading} type="submit" className="btn btn-primary">
        Save
      </button>
    </section>
  </form>;
}
