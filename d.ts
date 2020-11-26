/* eslint-disable spaced-comment */
/* eslint-disable init-declarations */

/// <reference types="@emotion/react/types/css-prop" />

declare module "*.gql" {
  import type {DocumentNode} from "graphql";

  const Schema: DocumentNode;

  export = Schema;
}
