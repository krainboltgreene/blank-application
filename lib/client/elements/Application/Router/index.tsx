import React from "react";
import {Route, Switch} from "react-router";
import {AccountConfirmation} from "@client/pages";
import {CodeOfConduct} from "@client/pages";
import {DataPolicy} from "@client/pages";
import {LandingPage} from "@client/pages";
import {Login} from "@client/pages";
import {Logout} from "@client/pages";
import {OurTechnology} from "@client/pages";
import {PageNotFound} from "@client/pages";
import {PrivacyPolicy} from "@client/pages";
import {SignUp} from "@client/pages";
import {TermsOfService} from "@client/pages";
import {ThisIsUs} from "@client/pages";
import {MyProfile} from "@client/pages";
import {MyAccount} from "@client/pages";
import {MySettings} from "@client/pages";

export default function Router (): JSX.Element {
  return <Switch>
    <Route path="/account-confirmation" component={AccountConfirmation} />
    <Route path="/code-of-conduct" component={CodeOfConduct} />
    <Route path="/data-policy" component={DataPolicy} />
    <Route path="/login" component={Login} />
    <Route path="/logout" component={Logout} />
    <Route path="/our-technology" component={OurTechnology} />
    <Route path="/privacy-policy" component={PrivacyPolicy} />
    <Route path="/my/account" component={MyAccount} />
    <Route path="/my/profile" component={MyProfile} />
    <Route path="/my/settings" component={MySettings} />
    <Route path="/sign-up" component={SignUp} />
    <Route path="/terms-of-service" component={TermsOfService} />
    <Route path="/this-is-us" component={ThisIsUs} />
    <Route exact path="/" component={LandingPage} />
    <Route component={PageNotFound} />
  </Switch>;
}
