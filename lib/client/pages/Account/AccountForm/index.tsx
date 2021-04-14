import React from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";

import {account as accountAtom} from "@find_reel_love/atoms";
import {Loading} from "@find_reel_love/elements";
import updateAccountMutation from "./updateAccountMutation.gql";
import fetchAccountQuery from "./fetchAccountQuery.gql";
import type {UpdateAccountMutation} from "./UpdateAccountMutation";
import type {FetchAccountQuery} from "./FetchAccountQuery";

export default function AccountForm (): JSX.Element {
  const [account, setAccount] = useRecoilState(accountAtom);
  const {loading: fetchAccountLoading, data: fetchAccountData, error: fetchAccountError} = useQuery<FetchAccountQuery>(fetchAccountQuery);
  const [updateAccount, {loading: updateAccountLoading, error: updateAccountError, data: updateAccountData}] = useMutation<UpdateAccountMutation>(updateAccountMutation);
  const {id} = account ?? fetchAccountData?.account ?? {};
  const {username} = account ?? fetchAccountData?.account ?? {};
  const {emailAddress} = account ?? fetchAccountData?.account ?? {};

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

  if (updateAccountError && updateAccountError.message !== "incorrect_credentials") {
    // TODO: Actually handle real errors
    throw updateAccountError;
  }

  if (fetchAccountLoading) {
    return <Loading kind="block" />;
  }

  const onSubmit = async (event: React.FormEvent<HTMLFormElement>): Promise<void> => {
    event.preventDefault();
    await updateAccount({variables: {input: {id, username, emailAddress}}});
  };

  return <form id="AccountForm" onSubmit={onSubmit}>
    <section>
      <button disabled={updateAccountLoading} type="submit">
        Save Account
      </button>
    </section>
  </form>;
}
