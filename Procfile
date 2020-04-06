postgres: postgres -F -D services/postgres/data
browser-client: npx webpack-dev-server
resource-server: mix phx.server 
resource-tests: mix test.watch --stale
eslint: npx esw --color --watch --ext .js --ext .gql browser-client/**/* browser-server/**/* desktop-client/**/* desktop-server/**/* @internal/**/*