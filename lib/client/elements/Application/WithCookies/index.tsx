import React from "react";
import {useCookie} from "react-use";
import {useRecoilState} from "recoil";
import {useEffect} from "react";

import {cookie as cookieAtom} from "@client/atoms";

const COOKIES_KEY = "_clumsy_chinchilla_key";

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
