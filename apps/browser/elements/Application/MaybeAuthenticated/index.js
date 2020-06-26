import React from "react";
import {useLazyQuery} from "@apollo/react-hooks";
import {useCookie} from "react-use";
import {useRecoilState} from "recoil";
import {isSessionPresent as isSessionPresentState} from "@henosis/atoms";
import {currentAccount as currentAccountState} from "@henosis/atoms";
import Exception from "../../Exception";

import query from "./index.gql";

export default function MaybeAuthenticated ({children}) {
  const [fetchCurrentSession, {error, data, loading}] = useLazyQuery(query);
  const [cookie] = useCookie("_henosis_key");
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
