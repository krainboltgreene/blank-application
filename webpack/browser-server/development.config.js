/* eslint-disable import/no-commonjs, import/no-nodejs-modules */

const {resolve} = require("path");
const webpackNodeExternals = require("webpack-node-externals");
const {EnvironmentPlugin} = require("webpack");
const {CleanWebpackPlugin} = require("clean-webpack-plugin");
const {Plugin: WebpackCommonShake} = require("webpack-common-shake");
const DotenvWebpack = require("dotenv-webpack");
const {config: dotenvConfiguration} = require("dotenv");

dotenvConfiguration();

const inputDirectory = [__dirname, "..", "..", "browser-server"];
const outputDirectory = [__dirname, "..", "..", "tmp", "browser"];

module.exports = {
  mode: "development",
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /index\.js$/u,
        exclude: /node_modules/u,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.gql$/u,
        exclude: /node_modules/u,
        loader: "graphql-tag/loader",
      },
    ],
  },
  entry: [
    resolve(...inputDirectory, "index.js"),
  ],
  target: "node",
  node: {
    __dirname: false,
    __filename: false,
  },
  externals: [
    webpackNodeExternals(),
  ],
  output: {
    path: resolve(...outputDirectory),
  },
  optimization: {
    minimize: false,
  },
  plugins: [
    new CleanWebpackPlugin(),
    new DotenvWebpack(),
    new EnvironmentPlugin([
      "NODE_ENV",
      "COUCHDB_USERNAME",
      "COUCHDB_PASSWORD",
      "COUCHDB_URI",
    ]),
    new WebpackCommonShake(),
  ],
};
