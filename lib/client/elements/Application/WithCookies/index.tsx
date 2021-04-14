import {useCookie} from "react-use";
import {useRecoilState} from "recoil";
import {useEffect} from "react";

import {cookie as cookieAtom} from "@find_reel_love/atoms";

const COOKIES_KEY = "_find_reel_love_key";

interface PropertiesType<C> {
  children: C;
}

export default function WithCookies<C> (properties: Readonly<PropertiesType<C>>): C {
  const {children} = properties;
  const [browserCookie] = useCookie(COOKIES_KEY);
  const [cookie, setCookie] = useRecoilState<string | null>(cookieAtom);

  useEffect(() => {
    if (Boolean(browserCookie) && cookie === null) {
      setCookie(cookie);
    }
  }, [browserCookie, cookie, setCookie]);


  return children;
}
