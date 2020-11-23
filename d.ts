/* eslint-disable init-declarations */

declare module "*.gql" {
  import type {DocumentNode} from "graphql";

  const Schema: DocumentNode;

  export = Schema;
}

declare module "*.module.postcss" {
  const classes: Record<string, string>;
  export default classes;
}
