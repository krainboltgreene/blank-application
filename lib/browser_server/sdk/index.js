import {ApolloClient} from "apollo-client";
import {InMemoryCache} from "apollo-cache-inmemory";
import {HttpLink} from "apollo-link-http";
import {onError} from "apollo-link-error";
import {ApolloLink} from "apollo-link";
import fetch from "node-fetch";

export default new ApolloClient({
  ssrMode: true,
  link: ApolloLink.from([
    onError(({graphQLErrors, networkError}) => {
      if (graphQLErrors) {
        graphQLErrors.forEach(({message, locations, path}) => console.log(
          `[GraphQL error]: Message: ${message}, Location: ${locations}, Path: ${path}`,
        ),);
      }
      if (networkError) {
        console.log(`[Network error]: ${networkError}`);
      }
    }),
    new HttpLink({
      uri: "http://localhost:4000/graphql",
      credentials: "same-origin",
      fetch,
    }),
  ]),
  cache: new InMemoryCache(),
});
