/* eslint-disable promise/prefer-await-to-callbacks */
import {ApolloClient} from "@apollo/client";
import {InMemoryCache} from "@apollo/client";
import {HttpLink} from "@apollo/client";
import {onError} from "@apollo/client/link/error";
import type {ErrorResponse} from "@apollo/client/link/error";
import type {GraphQLError} from "graphql";
import {from} from "@apollo/client";

// import {socketLink} from "./links";

export default new ApolloClient({
  link: from([
    onError((errors: Readonly<ErrorResponse>) => {
      const {graphQLErrors} = errors;
      const {networkError} = errors;

      if (graphQLErrors) {
        graphQLErrors.forEach((error: Readonly<GraphQLError>) => {
          console.error(
            "[GraphQL error]",
            error,
          );
        });
      }
      if (networkError) {
        console.error("[Network error]", {networkError});
      }
    }),
    new HttpLink({
      uri: "/graphql",
      credentials: "include",
    }),
  ]),
  cache: new InMemoryCache(),
});
