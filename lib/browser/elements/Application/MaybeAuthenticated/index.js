import React from "react";
import {useLazyQuery} from "@apollo/client";
import {useCookie} from "react-use";
import {useRecoilState} from "recoil";
import {isSessionPresent as isSessionPresentState} from "@clumsy_chinchilla/atoms";
import {currentAccount as currentAccountState} from "@clumsy_chinchilla/atoms";
import Exception from "../../Exception";

import query from "./index.gql";

export default function MaybeAuthenticated ({children}) {
  const [fetchCurrentSession, {error, data, loading}] = useLazyQuery(query);
  const [cookie] = useCookie("_clumsy_chinchilla_key");
  const [isSessionPresent, setIsSessionPresent] = useRecoilState(isSessionPresentState);
  const [, setCurrentAccount] = useRecoilState(currentAccountState);

  if (error) {
    return <Exception kind="overlay" as={error} />;
  }

  if (!isSessionPresent && cookie) {
    setIsSessionPresent(true);
  }

  if (isSessionPresent && !loading && !data && !error) {
    fetchCurrentSession();
  }

  if (isSessionPresent && data) {
    setCurrentAccount(data.id);
  }

  return children;
}
