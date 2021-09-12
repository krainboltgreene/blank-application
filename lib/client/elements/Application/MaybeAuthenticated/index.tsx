import React from "react";
import {useLazyQuery} from "@apollo/client";
import {useRecoilState} from "recoil";
import {useSetRecoilState} from "recoil";
import {useEffect} from "react";

import {currentSessionId as currentSessionIdAtom} from "@clumsy_chinchilla/atoms";
import {loadingCurrentSessionId as loadingCurrentSessionIdAtom} from "@clumsy_chinchilla/atoms";

import fetchSessionQuery from "./fetchSessionQuery.graphql";

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
  const [currentSessionId, setCurrentSessionId] = useRecoilState(currentSessionIdAtom);
  const setLoadingCurrentAccount = useSetRecoilState(loadingCurrentSessionIdAtom);

  useEffect(() => {
    setLoadingCurrentAccount(loading);
  }, [loading, setLoadingCurrentAccount]);

  useEffect(() => {
    if (!data || !data.session.id || Boolean(currentSessionId)) {
      return;
    }

    setCurrentSessionId(data.session.id);
  }, [loading, currentSessionId, data, setCurrentSessionId]);

  useEffect(() => {
    if (error) {
      return;
    }

    if (loading || Boolean(currentSessionId)) {
      return;
    }

    fetchSession();
  }, [fetchSession, error, loading, currentSessionId]);

  if (error && error.message !== "unauthenticated") {
    throw error;
  }

  return children;
}
