/* eslint-disable import/no-internal-modules */
import {ApolloClient} from "@apollo/client";
import {InMemoryCache} from "@apollo/client";
import {createHttpLink} from "@apollo/client";
import {onError} from "@apollo/client/link/error";
import {from} from "@apollo/client";
import fetch from "cross-fetch";

export default function sdk (request) {
  return new ApolloClient({
    ssrMode: true,
    link: from([
      onError(({graphQLErrors, networkError}) => {
        if (graphQLErrors) {
          graphQLErrors.forEach(({message, locations, path}) => console.error(
            "[GraphQL error]",
            {message, locations, path},
          ));
        }
        if (networkError) {
          console.error("[Network error]", {networkError});
        }
      }),
      createHttpLink({
        uri: "http://localhost:4000/graphql",
        credentials: "include",
        headers: {
          cookie: request.header("Cookie"),
        },
        fetch,
      }),
    ]),
    cache: new InMemoryCache(),
  });
}
