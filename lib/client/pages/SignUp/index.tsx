import {useRecoilState} from "recoil";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {warningMessages as warningMessagesAtom} from "@clumsy_chinchilla/atoms";
import {Page} from "@clumsy_chinchilla/elements";
import SignUpForm from "./SignUpForm";


export default function SignUp () {
  const history = useHistory();
  const [currentAccount] = useRecoilState<string>(currentAccountAtom);
  const [warningMesssages, setWarningMessage] = useRecoilState<Array<string>>(warningMessagesAtom);

  if (currentAccount) {
    setWarningMessage([...warningMesssages, "You cannot create a new account while you're signed in."]);
    history.push("/");
  }

  return <Page id="sign-up">
    <SignUpForm />
  </Page>;
}
