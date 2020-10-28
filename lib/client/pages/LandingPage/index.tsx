/* eslint-disable unicorn/no-null */
import {useRecoilValue} from "recoil";
import {Helmet} from "react-helmet-async";
import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Page} from "@clumsy_chinchilla/elements";
import {Link} from "@clumsy_chinchilla/elements";
import "./index.scss";

export default function LandingPage () {
  const currentAccount = useRecoilValue<string>(currentAccountAtom);

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
      {currentAccount ? null : <li><Link href="/sign-up">Sign Up</Link></li>}
      {currentAccount ? null : <li><Link href="/login">Login</Link></li>}
    </ul>
    <ul>
      {currentAccount ? <li><Link href="/settings">Settings</Link></li> : null}
    </ul>
  </Page>;
}
