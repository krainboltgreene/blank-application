/* eslint-disable import/no-commonjs */
module.exports = {
  presets: [
    [
      "@babel/preset-env",
      {
        useBuiltIns: "entry",
        corejs: "3.6",
        targets: "> 0.25%, not dead",
      },
    ],
    [
      "@babel/preset-react",
      {
        development: process.env.NODE_ENV !== "production",
      },
    ],
    process.env.NODE_ENV === "production" ? "minify" : undefined,
  ].filter((preset) => preset),
  plugins: [
    "babel-plugin-graphql-tag",
    [
      "module-resolver",
      {
        alias: {
          "^@clumsy_chinchilla/(.+)$": "./lib/browser/\\1",
          "^@assets/(.+)$": "./lib/browser/assets/\\1",
        },
      },
    ],
    process.env.NODE_ENV === "production" ? undefined : "react-hot-loader/babel",
    process.env.NODE_ENV === "production" ? undefined : "annotate-console-log",
  ].filter((preset) => preset),
};
