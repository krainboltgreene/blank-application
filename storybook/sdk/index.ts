import {ApolloClient} from "@apollo/client";
import {InMemoryCache} from "@apollo/client";
import {HttpLink} from "@apollo/client";
import {onError} from "@apollo/client/link/error";
import {from} from "@apollo/client";

export default new ApolloClient({
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
    new HttpLink({
      uri: "/graphql",
      credentials: "include",
    }),
  ]),
  cache: new InMemoryCache(),
});
