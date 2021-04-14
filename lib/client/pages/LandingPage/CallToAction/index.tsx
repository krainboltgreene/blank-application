import {useRecoilValue} from "recoil";
import {currentSessionId as currentSessionIdAtom} from "@find_reel_love/atoms";
import {loadingCurrentSessionId as loadingCurrentSessionIdAtom} from "@find_reel_love/atoms";
import {Link} from "@find_reel_love/elements";
import {Loading} from "@find_reel_love/elements";


const styles = {
  display: "grid",
};

export default function CallToAction (): JSX.Element {
  const currentSessionId = useRecoilValue<string | null>(currentSessionIdAtom);
  const loadingCurrentSessionId = useRecoilValue<boolean>(loadingCurrentSessionIdAtom);

  if (currentSessionId === null) {
    return <section css={styles}>
      <Link href="/sign-up">Sign Up</Link>
      <Link href="/login">Login</Link>
    </section>;
  }

  if (loadingCurrentSessionId) {
    return <section css={styles}>
      <Loading kind="word" />
      <Loading kind="word" />
    </section>;
  }

  return <section css={styles}>
    <Link href="/my/account">Your Account</Link>
    <Link href="/my/profile">Your Profile</Link>
    <Link href="/my/settings">Your Settings</Link>
    <Link href="/logout">Logout</Link>
  </section>;
}
