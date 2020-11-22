/* eslint-disable no-undef */
/* eslint-disable init-declarations */
/* eslint-disable no-unused-vars */

declare module "*.gql" {
  import type {DocumentNode} from "graphql";

  const Schema: DocumentNode;

  export = Schema;
}
