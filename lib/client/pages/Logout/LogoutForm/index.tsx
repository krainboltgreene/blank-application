import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import destroySessionMutation from "./destroySessionMutation.gql";
import type {DestroySessionMutation} from "./DestroySessionMutation.d";

export default function LogoutForm (): JSX.Element {
  const history = useHistory();
  const setCurrentAccount = useSetRecoilState<string | null>(currentAccountAtom);
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
      <button disabled={destroySessionLoading} type="submit">Logout</button>
    </section>
  </form>;
}
