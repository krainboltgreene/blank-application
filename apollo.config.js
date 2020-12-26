module.exports = {
  client: {
    includes: ["./lib/client/**/*.gql"],
    service: {
      name: "server",
      localSchemaFile: "./schema.graphql"
    }
  },
};
