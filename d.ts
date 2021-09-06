declare module "*.graphql" {
  import type {DocumentNode} from "graphql";

  const Schema: DocumentNode;

  export = Schema;
}
declare module "*.png|jpeg|jpg|webp|gif|json|txt|svg|xml" {
  const value: string;

  export = value;
}
