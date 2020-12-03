import React from "react";
import {Global} from "@emotion/react";
import {reboot} from "@clumsy_chinchilla/styles";
import ErrorBoundary from "./ErrorBoundary";
import MaybeAuthenticated from "./MaybeAuthenticated";
import WithCookies from "./WithCookies";
import WithLocalDatabase from "./WithLocalDatabase";
import Router from "./Router";

export default function Application (): JSX.Element {
  return <ErrorBoundary>
    <Global styles={reboot} />
    <MaybeAuthenticated>
      <WithCookies>
        <WithLocalDatabase>
          <Router />
        </WithLocalDatabase>
      </WithCookies>
    </MaybeAuthenticated>
  </ErrorBoundary>;
}
