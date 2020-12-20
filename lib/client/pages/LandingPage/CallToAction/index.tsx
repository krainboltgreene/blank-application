import React from "react";
import {useRecoilValue} from "recoil";
import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {loadingCurrentAccount as loadingCurrentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Link} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";


export default function CallToAction (): JSX.Element {
  const currentAccount = useRecoilValue<string | null>(currentAccountAtom);
  const loadingCurrentAccount = useRecoilValue<boolean>(loadingCurrentAccountAtom);

  if (loadingCurrentAccount) {
    return <ul>
      <li><Link href="/sign-up">Sign Up</Link></li>
      <li><Link href="/login">Login</Link></li>
    </ul>;
  }

  if (currentAccount === null) {
    return <ul>
      <li><Loading kind="word" /></li>
      <li><Loading kind="word" /></li>
    </ul>;
  }

  return <ul>
    <li><Link href="/settings">Settings</Link></li>
    <li><Link href="/logout">Logout</Link></li>
  </ul>;
}
