/* eslint-disable import/no-commonjs */
module.exports = {
  presets: [
    ["@babel/preset-env", {useBuiltIns: "entry", corejs: "3.6", targets: "> 0.25%, not dead"}],
    ["@babel/preset-typescript", {isTSX: true, allExtensions: true}],
    ["@babel/preset-react", {runtime: "automatic", development: process.env.NODE_ENV !== "production"}],
    process.env.NODE_ENV === "production" ? "minify" : undefined,
    "@emotion/babel-preset-css-prop",
  ].filter((preset) => preset),
  plugins: [
    "babel-plugin-graphql-tag",
    ["module-resolver", {extensions: [".tsx", ".ts", ".js", ".jsx"], alias: {
      "^@clumsy_chinchilla/(.+)$": "./lib/client/\\1",
      "^@assets/(.+)$": "./assets/\\1",
    }}],
    process.env.NODE_ENV === "production" ? undefined : "react-hot-loader/babel",
    process.env.NODE_ENV === "production" ? undefined : "annotate-console-log",
  ].filter((preset) => preset),
};
