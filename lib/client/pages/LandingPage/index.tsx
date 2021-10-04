import React from "react";
import {Page} from "@clumsy_chinchilla/elements";
import CallToAction from "./CallToAction";

export default function LandingPage (): JSX.Element {
  return <Page as="LandingPage" navbar={false}>
    <h1>Clumsy Chinchilla</h1>
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
