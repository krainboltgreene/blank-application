/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */
const {resolve} = require("path");
const webpackNodeExternals = require("webpack-node-externals");
const {EnvironmentPlugin} = require("webpack");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const {HotModuleReplacementPlugin} = require("webpack");
const DotenvWebpack = require("dotenv-webpack");
const {config: dotenvConfiguration} = require("dotenv");
const NodemonWebpackPlugin = require("nodemon-webpack-plugin");

dotenvConfiguration();

const PACKAGE_ASSETS = [];
const sharedDirectory = [__dirname, "..", "..", "browser"];
const inputDirectory = [__dirname, "..", "lib"];
const outputDirectory = [__dirname, "..", "..", "..", "tmp", "browser"];

module.exports = {
  mode: "development",
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /\.scss$/u,
        use: [
          "isomorphic-style-loader",
          {loader: "css-loader", options: {importLoaders: 1}},
          "sass-loader",
        ],
      },
      {
        test: /\.(?:png|jpe?g|gif|xml|txt|json)$/u,
        exclude: /node_modules/u,
        use: {
          loader: "file-loader",
        },
      },
      {
        test: /\.gql$/u,
        exclude: /node_modules/u,
        loader: "graphql-tag/loader",
      },
      {
        test: /\.js$/u,
        exclude: /node_modules/u,
        use: {
          loader: "babel-loader",
        },
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
  watchOptions: {
    ignored: ["node_modules"],
  },
  resolve: {
    alias: {
      "@henosis/styles": resolve(...sharedDirectory, "styles"),
      "react-dom": "@hot-loader/react-dom",
    },
  },
  plugins: [
    new DotenvWebpack(),
    new HotModuleReplacementPlugin(),
    new CopyWebpackPlugin([{
      from: resolve(...sharedDirectory, "assets"),
      to: resolve(...outputDirectory, "assets"),
    }]),
    ...PACKAGE_ASSETS.map(([from, ...to]) => new CopyWebpackPlugin([{
      from,
      to: resolve(...outputDirectory, "assets", ...to),
    }])),
    new EnvironmentPlugin([
      "NODE_ENV",
    ]),
    new NodemonWebpackPlugin({
      watch: resolve(...outputDirectory),
      script: resolve(...outputDirectory, "main.js"),
      ext: "js,html",
    }),
  ],
};
