/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */

const {resolve} = require("path");
const {HashedModuleIdsPlugin} = require("webpack");
const {HotModuleReplacementPlugin} = require("webpack");
const {EnvironmentPlugin} = require("webpack");
const {BundleAnalyzerPlugin} = require("webpack-bundle-analyzer");
const {Plugin: WebpackCommonShake} = require("webpack-common-shake");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const DotenvWebpack = require("dotenv-webpack");
const {config: dotenvConfiguration} = require("dotenv");

dotenvConfiguration();

const sharedDirectory = [__dirname, "..", "..", "browser"];
const inputDirectory = [__dirname, "..", "lib"];
const outputDirectory = [__dirname, "..", "..", "..", "tmp", "browser"];

module.exports = {
  mode: "development",
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /\.css$/u,
        use: [
          "style-loader",
          {loader: "css-loader", options: {importLoaders: 1}},
          "sass-loader",
        ],
      },
      {
        test: /\.(?:png|jpe?g|gif|xml|txt|json)$/u,
        exclude: /node_modules/u,
        use: {
          loader: "file-loader",
          options: {
            name: "client-[name].[hash].js",
          },
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
    "react-hot-loader/patch",
    resolve(...inputDirectory, "index.js"),
  ],
  target: "web",
  output: {
    path: resolve(...outputDirectory),
    filename: "client-[name].[hash].js",
    chunkFilename: "[id].[chunkhash].js",
  },
  devServer: {
    hot: true,
    writeToDisk: true,
  },
  watchOptions: {
    ignored: ["node_modules"],
  },
  resolve: {
    alias: {
      "@clumsy_chinchilla/styles": resolve(...sharedDirectory, "styles"),
      "react-dom": "@hot-loader/react-dom",
    },
  },
  plugins: [
    new DotenvWebpack(),
    new HotModuleReplacementPlugin(),
    new WebpackAssetsManifest({
      output: "asset-integrity-manifest.json",
      integrity: false,
    }),
    new HtmlWebpackPlugin({
      hash: true,
      template: resolve(...sharedDirectory, "templates", "index.html"),
    }),
    new EnvironmentPlugin([
      "NODE_ENV",
      "COUCHDB_USERNAME",
      "COUCHDB_PASSWORD",
      "COUCHDB_URI",
    ]),
    new WebpackCommonShake(),
    new HashedModuleIdsPlugin(),
    // new BundleAnalyzerPlugin({analyzerMode: "static", openAnalyzer: false}),
  ],
};
