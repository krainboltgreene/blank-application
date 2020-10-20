/* eslint-disable import/no-internal-modules */
import React from "react";
import {hot} from "react-hot-loader/root";
import ErrorBoundry from "./ErrorBoundry";
import MaybeAuthenticated from "./MaybeAuthenticated";
import WithCookies from "./WithCookies";
import WithLocalDatabase from "./WithLocalDatabase";
import Routing from "./Routing";

export default hot(function Application () {
  return <ErrorBoundry>
    <MaybeAuthenticated>
      <WithCookies>
        <WithLocalDatabase>
          <Routing />
        </WithLocalDatabase>
      </WithCookies>
    </MaybeAuthenticated>
  </ErrorBoundry>;
});
