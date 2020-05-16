import React from "react";
import {useQuery} from "@apollo/react-hooks";
import {useDispatch} from "react-redux";
import {useSelector} from "react-redux";
import {dig} from "@unction/complete";

import Exception from "../../Exception";
import Loading from "../../Loading";

import query from "./index.gql";

export default function MaybeAuthenticated ({children}) {
  const currentAccount = useSelector(dig(["session", "createAccount"]));
  const {data, error, loading} = useQuery(query);
  const dispatch = useDispatch();

  if (loading) {
    return <Loading kind="overlay" />;
  }

  if (currentAccount && error) {
    return <Exception kind="overlay" as={error} />;
  }

  if (currentAccount && data) {
    console.debug("We have data, make sure redux knows we're authenticated");
    dispatch({type: "session/set", payload: data});
  }

  return children;
}
