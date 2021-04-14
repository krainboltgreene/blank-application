import {useRecoilState} from "recoil";
import {useRecoilValue} from "recoil";
import {useHistory} from "react-router-dom";

import {currentSessionId as currentSessionIdAtom} from "@find_reel_love/atoms";
import {warningMessages as warningMessagesAtom} from "@find_reel_love/atoms";
import {Page} from "@find_reel_love/elements";
import SignUpForm from "./SignUpForm";


export default function SignUp (): JSX.Element {
  const history = useHistory();
  const currentSessionId = useRecoilValue<string | null>(currentSessionIdAtom);
  const [warningMessages, setWarningMessage] = useRecoilState<Array<string>>(warningMessagesAtom);

  if (currentSessionId !== null) {
    setWarningMessage([...warningMessages, "You cannot create a new account while you're signed in."]);
    history.push("/");
  }

  return <Page as="SignUp" subtitle="Sign Up">
    <SignUpForm />
  </Page>;
}
