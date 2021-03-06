# Clumsy Chinchilla

This project is actually 5 parts:

  1. The resource application: Written in Elixir, run with Phoenix, speaks GraphQL and HTML. All the resources and levers are via GraphQL while some operational tools are in HTML. Talks to the database directly via Ecto. Also handles the background processes that need to happen.
  2. The browser application: Written in javascript, rendered in React, handling data with Recoil. Makes requests to the resource server via ApolloClient (GraphQL). Has an internal database using PouchDB for handling large datasets.
  3. The content application: Written in javascript, renders content via React, handling data with Recoil. Makes requests to the resource server via ApolloClient (GraphQL). Just a server-rendering of the browser application.
  4. PostgreSQL: Where we store long term data.
  5. Redis: Where we store short term ephemeral data.

## Setup

  0. `bin/postgres-setup`
  0. `bin/postgres-start`
  0. `bin/setup`

## FAQ

### Where do I put static assets?

Almost all static assets go into `assets/` so that webpack can pick it up and ship it to the CDN. If you need a static asset from outside of this directory (say from a package) list it as part of `PACKAGE_ASSETS`.

### Where do I put frontend data?

If it's global data, define a recoil atom in `lib/client/atoms/`, otherwise use local state.

### Where are the global styles?

Well first *shared* styles sit in `lib/client/styles` and there are no (by default) *global* styles. Instead you have to opt-in to a collection of shared resources by doing this in your scss:

``` scss
@import "@clumsy_chinchilla/styles/index.scss";

// Your styles here
```

### How do I add a new web page?

Step one is to create the component in `lib/client/pages/` and then export it in `lib/client/pages/index.ts`. Remember that our component folders are named after the component and the file is `index.tsx` if it has react or `index.ts` if it doesn't (so `<LoginPage>` would be `lib/client/pages/Login/index.tsx`). Finally place it in the `lib/client/elements/Application/Router/index.tsx` file.

## Todo

  - https://www.npmjs.com/package/apollo-v3-absinthe-upload-link
  - https://www.npmjs.com/package/@absinthe/absinthe-socket
  - Setup docker for both applications
  - Setup kubernetes for both applications
  - Finish releases setup
  - Finish setting up the html meta
  - Get a google tag manager id
  - Hot reloading not noticing change in css
  - Check out DLLplugin
  - Utilize recoil state persistance for hydration
  - make storybook load recoil
  - Tried to create an account, then I saw this in logs:

    ```
    ** (exit) an exception was raised:
    ** (Protocol.UndefinedError) protocol Enumerable not implemented for #Ecto.Changeset<action: :insert, changes: %{email: "kurtis9@rainbolt-greene.online", onboarding_state: "converted", password_hash: "$argon2id$v=19$m=131072,t=8,p=4$iIrSevSl6u16hDjy0nQ7UQ$DBWOGrAJYgOIMBEw//ZkAVDW1RXymXpbyDSRvYvLj7k", role_state: "user", unconfirmed_email: "kurtis9@rainbolt-greene.online", username: "kurtis9"}, errors: [email: {"has already been taken", [constraint: :unique, constraint_name: "accounts_email_index"]}], data: #Database.Models.Account<>, valid?: false> of type Ecto.Changeset (a struct). This protocol is implemented for the following type(s): Ecto.Adapters.SQL.Stream, Postgrex.Stream, DBConnection.Stream, DBConnection.PrepareStream, HashSet, Range, Map, Function, List, Stream, Date.Range, HashDict, GenEvent.Stream, MapSet, File.Stream, IO.Stream
    ```
      But also the browser encountered a json error
  - Client side errors don't back correctly
