import React from "react";
import {Route, Switch} from "react-router";
import {OurTechnology} from "@clumsy_chinchilla/pages";
import {PrivacyPolicy} from "@clumsy_chinchilla/pages";
import {TermsOfService} from "@clumsy_chinchilla/pages";
import {CodeOfConduct} from "@clumsy_chinchilla/pages";
import {ThisIsUs} from "@clumsy_chinchilla/pages";
import {LandingPage} from "@clumsy_chinchilla/pages";
import {DataPolicy} from "@clumsy_chinchilla/pages";
import {SignUp} from "@clumsy_chinchilla/pages";
import {PageNotFound} from "@clumsy_chinchilla/pages";

export default function Routing () {
  return <Switch>
    <Route path="/code-of-conduct" component={CodeOfConduct} />
    <Route path="/data-policy" component={DataPolicy} />
    <Route path="/our-technology" component={OurTechnology} />
    <Route path="/privacy-policy" component={PrivacyPolicy} />
    <Route path="/terms-of-service" component={TermsOfService} />
    <Route path="/this-is-us" component={ThisIsUs} />
    <Route path="/sign-up" component={SignUp} />
    <Route exact path="/" component={LandingPage} />
    <Route component={PageNotFound} />
  </Switch>;
}
