/* eslint-disable import/no-internal-modules */
import React from "react";
import {Route, Switch} from "react-router";
import {hot} from "react-hot-loader/root";
import {OurTechnology} from "@henosis/pages";
import {PrivacyPolicy} from "@henosis/pages";
import {TermsOfService} from "@henosis/pages";
import {CodeOfConduct} from "@henosis/pages";
import {ThisIsUs} from "@henosis/pages";
import {LandingPage} from "@henosis/pages";
import {DataPolicy} from "@henosis/pages";
import {SignUp} from "@henosis/pages";
import {PageNotFound} from "@henosis/pages";
import ErrorBoundry from "./ErrorBoundry";
import MaybeAuthenticated from "./MaybeAuthenticated";
import "./index.scss";

export default hot(function Application () {
  return <ErrorBoundry>
    <MaybeAuthenticated>
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
    </MaybeAuthenticated>
  </ErrorBoundry>;
});
