module.exports = {
  client: {
    includes: ["./lib/client/**/*.graphql"],
    service: {
      name: "server",
      localSchemaFile: "./schema.graphql"
    }
  },
};
