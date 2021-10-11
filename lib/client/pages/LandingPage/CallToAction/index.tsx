import React from "react";
import {useRecoilValue} from "recoil";
import {currentSessionId as currentSessionIdAtom} from "@clumsy_chinchilla/atoms";
import {loadingCurrentSessionId as loadingCurrentSessionIdAtom} from "@clumsy_chinchilla/atoms";
import {Link} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";


const styles = "";

export default function CallToAction (): JSX.Element {
  const currentSessionId = useRecoilValue<string | null>(currentSessionIdAtom);
  const loadingCurrentSessionId = useRecoilValue<boolean>(loadingCurrentSessionIdAtom);

  if (currentSessionId === null) {
    return <section className={styles}>
      <Link href="/sign-up">Sign Up</Link>
      <Link href="/login">Login</Link>
    </section>;
  }

  if (loadingCurrentSessionId) {
    return <section className={styles}>
      <Loading kind="word" />
      <Loading kind="word" />
    </section>;
  }

  return <section className={styles}>
    <Link href="/my/account">Your Account</Link>
    <Link href="/my/profile">Your Profile</Link>
    <Link href="/my/settings">Your Settings</Link>
    <Link href="/logout">Logout</Link>
  </section>;
}
