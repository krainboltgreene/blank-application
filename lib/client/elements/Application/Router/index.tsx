import {Route, Switch} from "react-router";
import {AccountConfirmation} from "@clumsy_chinchilla/pages";
import {CodeOfConduct} from "@clumsy_chinchilla/pages";
import {DataPolicy} from "@clumsy_chinchilla/pages";
import {LandingPage} from "@clumsy_chinchilla/pages";
import {Login} from "@clumsy_chinchilla/pages";
import {Logout} from "@clumsy_chinchilla/pages";
import {OurTechnology} from "@clumsy_chinchilla/pages";
import {PageNotFound} from "@clumsy_chinchilla/pages";
import {PrivacyPolicy} from "@clumsy_chinchilla/pages";
import {SignUp} from "@clumsy_chinchilla/pages";
import {TermsOfService} from "@clumsy_chinchilla/pages";
import {ThisIsUs} from "@clumsy_chinchilla/pages";
import {YourProfile} from "@clumsy_chinchilla/pages";
import {YourSettings} from "@clumsy_chinchilla/pages";

export default function Router (): JSX.Element {
  return <Switch>
    <Route path="/account-confirmation" component={AccountConfirmation} />
    <Route path="/code-of-conduct" component={CodeOfConduct} />
    <Route path="/data-policy" component={DataPolicy} />
    <Route path="/login" component={Login} />
    <Route path="/logout" component={Logout} />
    <Route path="/our-technology" component={OurTechnology} />
    <Route path="/privacy-policy" component={PrivacyPolicy} />
    {/* <Route path="/my/account" component={YourAccount} /> */}
    <Route path="/my/profile" component={YourProfile} />
    <Route path="/my/settings" component={YourSettings} />
    <Route path="/sign-up" component={SignUp} />
    <Route path="/terms-of-service" component={TermsOfService} />
    <Route path="/this-is-us" component={ThisIsUs} />
    <Route exact path="/" component={LandingPage} />
    <Route component={PageNotFound} />
  </Switch>;
}
