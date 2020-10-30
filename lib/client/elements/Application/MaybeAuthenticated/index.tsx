import type {ReactNode} from "react";
import {useLazyQuery} from "@apollo/client";
import {useRecoilState} from "recoil";
import {useEffect} from "react";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";

import fetchSessionQuery from "./fetchSessionQuery.gql";

interface SessionQueryType {
  session: {
    id: string;
  };
}

interface PropertiesType {
  children: ReactNode;
}

export default function MaybeAuthenticated (properties: Readonly<PropertiesType>): ReactNode {
  const {children} = properties;
  const [fetchSession, {error, data, loading}] = useLazyQuery<SessionQueryType>(fetchSessionQuery);
  const [currentAccount, setCurrentAccount] = useRecoilState<string | null>(currentAccountAtom);

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
