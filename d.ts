/* eslint-disable no-undef */
/* eslint-disable init-declarations */
/* eslint-disable no-unused-vars */
import {NormalizedCacheObject} from "@apollo/client";
import {DocumentNode} from "graphql";

interface Window {
  __APOLLO_STATE__: NormalizedCacheObject;
}
declare const RUNTIME_ENV: string;
declare module "*.gql" {
  const value: DocumentNode;
  export = value;
}
