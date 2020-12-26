import {useLazyQuery} from "@apollo/client";
import {useRecoilState} from "recoil";
import {useSetRecoilState} from "recoil";
import {useEffect} from "react";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {loadingCurrentAccount as loadingCurrentAccountAtom} from "@clumsy_chinchilla/atoms";

import fetchSessionQuery from "./fetchSessionQuery.gql";

interface SessionQueryType {
  session: {
    id: string;
  };
}

interface PropertiesType<C> {
  children: C;
}

export default function MaybeAuthenticated<C> (properties: Readonly<PropertiesType<C>>): C {
  const {children} = properties;
  const [fetchSession, {error, data, loading}] = useLazyQuery<SessionQueryType>(fetchSessionQuery);
  const [currentAccount, setCurrentAccount] = useRecoilState<string | null>(currentAccountAtom);
  const setLoadingCurrentAccount = useSetRecoilState<true | false>(loadingCurrentAccountAtom);

  useEffect(() => {
    setLoadingCurrentAccount(loading);
  }, [loading, setLoadingCurrentAccount]);

  useEffect(() => {
    if (!data || !data.session.id || Boolean(currentAccount)) {
      return;
    }

    setCurrentAccount(data.session.id);
  }, [loading, currentAccount, data, setCurrentAccount]);

  useEffect(() => {
    if (error) {
      return;
    }

    if (loading || Boolean(currentAccount)) {
      return;
    }

    fetchSession();
  }, [fetchSession, error, loading, currentAccount]);

  if (error && error.message !== "unauthenticated") {
    throw error;
  }

  return children;
}
