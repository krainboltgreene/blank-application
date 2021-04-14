import {Page} from "@find_reel_love/elements";
import CallToAction from "./CallToAction";

export default function LandingPage (): JSX.Element {
  return <Page as="LandingPage">
    <h1>Find Reel Love</h1>
    <p>
      Cupidatat aliquip exercitation sunt mollit amet laborum tempor. Duis
      elit deserunt cupidatat magna dolor ea sint sunt magna nostrud
      consectetur incididunt ipsum eu. Aliqua mollit labore sint ex
      excepteur duis id labore eiusmod. Velit ex velit nisi ex. Laboris
      deserunt magna aliqua eiusmod excepteur.
    </p>
    <CallToAction />
  </Page>;
}
