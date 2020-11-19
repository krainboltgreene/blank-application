/* eslint-disable no-undef */
/* eslint-disable init-declarations */
/* eslint-disable no-unused-vars */

declare module "*.gql" {
  import {DocumentNode} from "graphql";

  const Schema: DocumentNode;

  export = Schema
}

declare module ".tsx" {
  import {NormalizedCacheObject} from "@apollo/client";

  interface Window {
    __APOLLO_STATE__: NormalizedCacheObject;
  }
}

declare const RUNTIME_ENV: string;
