/* eslint-disable import/no-internal-modules */
import {ApolloClient} from "@apollo/client";
import {InMemoryCache} from "@apollo/client";
import {HttpLink} from "@apollo/client";
import {onError} from "@apollo/client/link/error";
import {from} from "@apollo/client";

export default new ApolloClient({
  link: from([
    onError(({graphQLErrors, networkError}) => {
      if (graphQLErrors) {
        graphQLErrors.forEach(({message, locations, path}) => console.log(
          "[GraphQL error]",
          {message, locations, path},
        ));
      }
      if (networkError) {
        console.log("[Network error]", {networkError});
      }
    }),
    new HttpLink({
      uri: "http://localhost:4000/graphql",
      credentials: "same-origin",
    }),
  ]),
  cache: new InMemoryCache(),
});