import {Route, Switch} from "react-router";
import {AccountConfirmation} from "@find_reel_love/pages";
import {CodeOfConduct} from "@find_reel_love/pages";
import {DataPolicy} from "@find_reel_love/pages";
import {LandingPage} from "@find_reel_love/pages";
import {Login} from "@find_reel_love/pages";
import {Logout} from "@find_reel_love/pages";
import {OurTechnology} from "@find_reel_love/pages";
import {PageNotFound} from "@find_reel_love/pages";
import {PrivacyPolicy} from "@find_reel_love/pages";
import {SignUp} from "@find_reel_love/pages";
import {TermsOfService} from "@find_reel_love/pages";
import {ThisIsUs} from "@find_reel_love/pages";
import {YourProfile} from "@find_reel_love/pages";
import {YourSettings} from "@find_reel_love/pages";

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
