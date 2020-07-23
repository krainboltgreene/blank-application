import React from "react";
import {useQuery} from "@apollo/client";
import {useRecoilState} from "recoil";
import {Helmet} from "react-helmet-async";
import {currentAccount as currentAccountState} from "@clumsy_chinchilla/atoms";
import {Page} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";
import {Exception} from "@clumsy_chinchilla/elements";
import {Link} from "@clumsy_chinchilla/elements";
import query from "./index.gql";
import "./index.scss";

export default function LandingPage () {
  const [currentAccount] = useRecoilState(currentAccountState);
  const {loading, error} = useQuery(query);

  if (RUNTIME_ENV === "client" && loading) {
    return <Loading kind="overlay" />;
  }

  if (currentAccount && error) {
    return <Exception kind="overlay" as={error} />;
  }

  return <Page id="LandingPage">
    <Helmet>
      <title>ClumsyChinchilla</title>
      <meta name="description" content="A description" />
    </Helmet>
    <h1>Clumsy Chinchilla</h1>
    <p>
      Cupidatat aliquip exercitation sunt mollit amet laborum tempor. Duis
      elit deserunt cupidatat magna dolor ea sint sunt magna nostrud
      consectetur incididunt ipsum eu. Aliqua mollit labore sint ex
      excepteur duis id labore eiusmod. Velit ex velit nisi ex. Laboris
      deserunt magna aliqua eiusmod excepteur.
    </p>
    <ul>
      <li><Link href="/sign-up">Sign Up</Link></li>
      <li><Link href="/login">Login</Link></li>
    </ul>
  </Page>;
}
