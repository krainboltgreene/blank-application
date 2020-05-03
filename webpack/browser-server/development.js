/* eslint-disable import/no-nodejs-modules */
import {resolve} from "path";
import webpackNodeExternals from "webpack-node-externals";
import {EnvironmentPlugin} from "webpack";
import {CleanWebpackPlugin} from "clean-webpack-plugin";
import {Plugin as WebpackCommonShake} from "webpack-common-shake";
import DotenvWebpack from "dotenv-webpack";
import {config as dotenvConfiguration} from "dotenv";

dotenvConfiguration();

const inputDirectory = [__dirname, "..", "..", "browser-server"];
const outputDirectory = [__dirname, "..", "..", "tmp", "browser"];

export default {
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
