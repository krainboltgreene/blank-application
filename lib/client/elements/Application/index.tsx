/* eslint-disable import/no-internal-modules */
import {hot} from "react-hot-loader/root";
import ErrorBoundary from "./ErrorBoundary";
import MaybeAuthenticated from "./MaybeAuthenticated";
import WithCookies from "./WithCookies";
import WithLocalDatabase from "./WithLocalDatabase";
import Router from "./Router";

export default hot(function Application () {
  return <ErrorBoundary>
    <MaybeAuthenticated>
      <WithCookies>
        <WithLocalDatabase>
          <Router />
        </WithLocalDatabase>
      </WithCookies>
    </MaybeAuthenticated>
  </ErrorBoundary>;
});
