import React from "react";
import {useRecoilValue} from "recoil";
import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {loadingCurrentAccount as loadingCurrentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Link} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";


const styles = {
  display: "",
};

export default function CallToAction (): JSX.Element {
  const currentAccount = useRecoilValue<string | null>(currentAccountAtom);
  const loadingCurrentAccount = useRecoilValue<boolean>(loadingCurrentAccountAtom);

  if (currentAccount === null) {
    return <section css={styles}>
      <Link href="/sign-up">Sign Up</Link>
      <Link href="/login">Login</Link>
    </section>;
  }

  if (loadingCurrentAccount) {
    return <section css={styles}>
      <Loading kind="word" />
      <Loading kind="word" />
    </section>;
  }

  return <section css={styles}>
    <Link href="/my/account">Your Profile</Link>
    <Link href="/my/profile">Your Account</Link>
    <Link href="/my/settings">Your Settings</Link>
    <Link href="/logout">Logout</Link>
  </section>;
}
