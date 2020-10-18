import {useCookie} from "react-use";
import {useRecoilState} from "recoil";
import {useEffect} from "react";

import {cookie as cookieAtom} from "lib/client/atoms";

const COOKIES_KEY = "_clumsy_chinchilla_key";

export default function WithCookies ({children}) {
  const [browserCookie] = useCookie(COOKIES_KEY);
  const [cookie, setCookie] = useRecoilState<string>(cookieAtom);

  useEffect(() => {
    if (browserCookie && !cookie) {
      setCookie(cookie);
    }
  }, [browserCookie, cookie, setCookie]);


  return children;
}
