# ClumsyChinchilla

This project is actually 5 parts:

  1. The resource application: Written in Elixir, run with Phoenix, speaks GraphQL and HTML. All the resources and levers are via GraphQL while some operational tools are in HTML. Talks to the database directly via Ecto. Also handles the background processes that need to happen.
  2. The browser application: Written in javascript, rendered in React, handling data with Recoil & Redux (via rematch). Makes requests to the resource server via ApolloClient (GraphQL). Has an internal database using PouchDB for handling large datasets.
  3. The content application: Written in javascript, renders content via React, handling data with Recoil & Redux (via rematch). Makes requests to the resource server via ApolloClient (GraphQL). Just a server-rendering of the browser application.
  4. PostgreSQL: Where we store long term data.
  5. Redis: Where we store short term ephemeral data.

## Setup

  0. `initdb --username=postgres --pwprompt postgres/data`
  0. `bin/postgres-start`
  0. `bin/setup`

## FAQ

### Where do I put static assets?

Almost all static assets go into `lib/browser/assets/` so that webpack can pick it up and ship it to the CDN. If you need a static asset from outside of this directory (say from a package) list it as part of `PACKAGE_ASSETS`.

### Where do I put frontend data?

Almost 100% of the time it's going to be `lib/browser/atoms`, though some data currently sits in redux/rematch.

### Where are the global styles?

Well first *shared* styles sit in `lib/browser/styles` and there are no (by default) *global* styles. Instead you have to opt-in to a collection of shared resources by doing this in your scss:

``` scss
@import "@clumsy_chinchilla/styles/index.scss";

// Your styles here
```

But you don't have to do that, in fact you can pull in whatever you damn well please:

``` scss
@import "@clumsy_chinchilla/styles/variables.scss";

```

## Todo

  - Deal with assets/
  - https://www.npmjs.com/package/apollo-v3-absinthe-upload-link
  - https://www.npmjs.com/package/@absinthe/absinthe-socket
  - Setup docker for both applications
  - Setup kubernetes for both applications
  - Deal with setup
  - Finish setting up the html meta
  - Get a google tag manager id
