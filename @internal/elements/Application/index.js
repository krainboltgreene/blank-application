/* eslint-disable import/no-internal-modules */
import React from "react";
import {Route, Switch} from "react-router";
import {hot} from "react-hot-loader/root";

import {OurTechnology} from "@internal/pages";
import {PrivacyPolicy} from "@internal/pages";
import {TermsOfService} from "@internal/pages";
import {CodeOfConduct} from "@internal/pages";
import {ThisIsUs} from "@internal/pages";
import {LandingPage} from "@internal/pages";
import {DataPolicy} from "@internal/pages";
import {SignUp} from "@internal/pages";
import {PageNotFound} from "@internal/pages";
import ErrorBoundry from "./ErrorBoundry";
import "./index.scss";

export default hot(function Application () {
  if (process.env.DESTKOP) {
    return <ErrorBoundry>
      <Switch>
        <Route exact path="/" component={LandingPage} />
        <Route component={PageNotFound} />
      </Switch>
    </ErrorBoundry>;
  }

  return <ErrorBoundry>
    <Switch>
      <Route path="/code-of-conduct" component={CodeOfConduct} />
      <Route path="/data-policy" component={DataPolicy} />
      <Route path="/our-technology" component={OurTechnology} />
      <Route path="/privacy-policy" component={PrivacyPolicy} />
      <Route path="/terms-of-service" component={TermsOfService} />
      <Route path="/this-is-us" component={ThisIsUs} />
      <Route path="/sign-up" component={SignUp} />
      <Route exact path="/" component={LandingPage} />
      <Route component={PageNotFound} />
    </Switch>
  </ErrorBoundry>;
});
