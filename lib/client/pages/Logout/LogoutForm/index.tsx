import React from "react";
import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentSessionId as currentSessionIdAtom} from "@client/atoms";
import destroySessionMutation from "./destroySessionMutation.graphql";
import type {DestroySessionMutation} from "@client/types";

export default function LogoutForm (): JSX.Element {
  const history = useHistory();
  const setCurrentAccount = useSetRecoilState(currentSessionIdAtom);
  const [destroySession, {loading: destroySessionLoading, data: destroySessionData}] = useMutation<DestroySessionMutation>(destroySessionMutation);

  useEffect(() => {
    if (destroySessionData) {
      setCurrentAccount(null);
      history.push("/");
    }
  }, [destroySessionData, setCurrentAccount, history]);

  return <form id="loginForm" onSubmit={async (event): Promise<void> => {
    event.preventDefault();
    await destroySession();
  }}>
    <section>
      <button disabled={destroySessionLoading} type="submit" className="btn btn-primary">Logout</button>
    </section>
  </form>;
}
