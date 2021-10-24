# Clumsy Chinchilla

This project is actually 5 parts:

  1. The resource application: Written in Elixir, run with Phoenix, speaks GraphQL and HTML. All the resources and levers are via GraphQL while some operational tools are in HTML. Talks to the database directly via Ecto. Also handles the background processes that need to happen.
  2. The browser application: Written in javascript, rendered in React, handling data with Recoil. Makes requests to the resource server via ApolloClient (GraphQL). Has an internal database using PouchDB for handling large datasets.
  3. The content application: Written in javascript, renders content via React, handling data with Recoil. Makes requests to the resource server via ApolloClient (GraphQL). Just a server-rendering of the browser application.
  4. PostgreSQL: Where we store long term data.
  5. Redis: Where we store short term ephemeral data.


## FAQ

### Where do I put static assets?

Almost all static assets go into `assets/` so that webpack can pick it up and ship it to the CDN. If you need a static asset from outside of this directory (say from a package) list it as part of `PACKAGE_ASSETS`.

### Where do I put frontend data?

If it's global data, define a recoil atom in `lib/client/atoms/`, otherwise use local state.

### Where are the global styles?

Well first *shared* styles sit in `lib/client/styles` and there are no (by default) *global* styles. Instead you have to opt-in to a collection of shared resources by doing this in your scss:

``` scss
@import "@client/styles/index.scss";

// Your styles here
```

### How do I add a new web page?

Step one is to create the component in `lib/client/pages/` and then export it in `lib/client/pages/index.ts`. Remember that our component folders are named after the component and the file is `index.tsx` if it has react or `index.ts` if it doesn't (so `<LoginPage>` would be `lib/client/pages/Login/index.tsx`). Finally place it in the `lib/client/elements/Application/Router/index.tsx` file.
The ElixirLS - blank-application server crashed 5 times in the last 3 minutes. The server will not be restarted.
Failed to run 'elixir' command. ElixirLS will probably fail to launch. Logged PATH to Development Console.
