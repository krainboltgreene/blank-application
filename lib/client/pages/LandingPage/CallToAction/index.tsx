import {useRecoilValue} from "recoil";
import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {loadingCurrentAccount as loadingCurrentAccountAtom} from "@clumsy_chinchilla/atoms";
import {Link} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";


export default function CallToAction (): JSX.Element {
  const currentAccount = useRecoilValue<string | null>(currentAccountAtom);
  const loadingCurrentAccount = useRecoilValue<boolean>(loadingCurrentAccountAtom);

  if (loadingCurrentAccount) {
    return <section id="call-to-action">
      <Link href="/sign-up">Sign Up</Link>
      <Link href="/login">Login</Link>
    </section>;
  }

  if (currentAccount === null) {
    return <section id="call-to-action">
      <Loading kind="word" />
      <Loading kind="word" />
    </section>;
  }

  return <section id="call-to-action">
    <Link href="/settings">Settings</Link>
    <Link href="/logout">Logout</Link>
  </section>;
}
